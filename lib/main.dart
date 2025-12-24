
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'video_cubit.dart';
import 'video_repository.dart';
import 'video_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => VideoCubit(VideoRepository())..fetchVideos(),
        child: const VideoListScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class VideoListScreen extends StatefulWidget {
  const VideoListScreen({super.key});

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<VideoCubit>().fetchVideos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mini TikTok')),
      body: BlocBuilder<VideoCubit, VideoState>(
        builder: (context, state) {
          if (state is VideoInitial || (state is VideoLoading && _isFirstLoad(state))) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is VideoError) {
            return const Center(child: Text('Error loading videos'));
          }
          if (state is VideoLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.videos.length + (state.hasReachedMax ? 0 : 1),
              itemBuilder: (context, index) {
                if (index >= state.videos.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                return VideoItem(video: state.videos[index]);
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  bool _isFirstLoad(VideoState state) {
    return state is VideoLoading && (context.read<VideoCubit>().state is! VideoLoaded);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class VideoItem extends StatefulWidget {
  final VideoModel video;
  const VideoItem({super.key, required this.video});

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.video.url));
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      looping: true,
      aspectRatio: _videoPlayerController.value.aspectRatio,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: _chewieController != null
              ? Chewie(controller: _chewieController!)
              : const Center(child: CircularProgressIndicator()),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('By: ${widget.video.user}', style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        const Divider(),
      ],
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}

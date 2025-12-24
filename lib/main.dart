import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auto Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => CounterCubit(),
        child: const CounterScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auto Increment Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Value:',
              style: TextStyle(fontSize: 24),
            ),
            BlocBuilder<CounterCubit, int>(
              builder: (context, state) {
                return Text(
                  '$state',
                  style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                );
              },
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTapDown: (_) {
                context.read<CounterCubit>().increment();
                context.read<CounterCubit>().startAutoIncrement();
              },
              onTapUp: (_) {
                context.read<CounterCubit>().stopAutoIncrement();
              },
              onTapCancel: () {
                context.read<CounterCubit>().stopAutoIncrement();
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Hold the button to "shoot" numbers!'),
          ],
        ),
      ),
    );
  }
}

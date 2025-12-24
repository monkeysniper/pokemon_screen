class CharacterResponse {
  final Info info;
  final List<RMCharacter> results;

  CharacterResponse({required this.info, required this.results});

  factory CharacterResponse.fromJson(Map<String, dynamic> json) {
    return CharacterResponse(
      info: Info.fromJson(json['info']),
      results: (json['results'] as List)
          .map((i) => RMCharacter.fromJson(i))
          .toList(),
    );
  }
}

class Info {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  Info({required this.count, required this.pages, this.next, this.prev});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      count: json['count'],
      pages: json['pages'],
      next: json['next'],
      prev: json['prev'],
    );
  }
}

class RMCharacter {
  final int id;
  final String name;
  final String status;
  final String species;
  final String image;

  RMCharacter({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.image,
  });

  factory RMCharacter.fromJson(Map<String, dynamic> json) {
    return RMCharacter(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      image: json['image'],
    );
  }
}

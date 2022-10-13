class User {
  final String name;
  final String headline;
  final String picture;

  User({
    required this.name,
    required this.headline,
    required this.picture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      headline: json['headline'],
      picture: json['picture'],
    );
  }
}

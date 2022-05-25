class Fundraiser {
  late int id;
  late String full_name;
  late String headline;
  String email;
  String phone;
  late String username;
  late String picture;

  Fundraiser({
    required this.id,
    required this.full_name,
    required this.headline,
    required this.email,
    required this.phone,
    required this.username,
    required this.picture,
  });

  factory Fundraiser.fromJson(Map<String, dynamic> json, int id) {
    return Fundraiser(
        id: id,
        full_name: json['full_name'] == null ? "" : json['full_name'],
        headline: json['headline'] == null ? "" : json['headline'],
        email: json['email'] == null ? "" : json['email'],
        phone: json['phone'] == null ? false : json['phone'],
        username: json['on_spot'] == null ? '' : json['username'],
        picture: '');
  }

  factory Fundraiser.fromJsonWithPicture(
      Map<String, dynamic> json, int id, String picture) {
    return Fundraiser(
      id: id,
      full_name: json['full_name'] == null ? "" : json['full_name'],
      headline: json['headline'] == null ? "" : json['headline'],
      email: json['email'] == null ? "" : json['email'],
      phone: json['phone'] == null ? false : json['phone'],
      username: json['username'] == null ? '' : json['username'],
      picture: picture,
    );
  }
}

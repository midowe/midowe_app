class Fundraiser {
  late int id;
  late String full_name;
  late String headline;
  String email;
  String phone;
  late String username;
  late String picture;
  late String reallocation_method;
  late String reallocation_address;

  Fundraiser({
    required this.id,
    required this.full_name,
    required this.headline,
    required this.email,
    required this.phone,
    required this.username,
    required this.picture,
    required this.reallocation_method,
    required this.reallocation_address,
  });

  factory Fundraiser.fromJson(Map<String, dynamic> json, int id) {
    return Fundraiser(
        id: id,
        full_name: json['full_name'] == null ? "" : json['full_name'],
        headline: json['headline'] == null ? "" : json['headline'],
        email: json['email'] == null ? "" : json['email'],
        phone: json['phone'] == null ? false : json['phone'],
        username: json['on_spot'] == null ? '' : json['username'],
        picture: '',
        reallocation_method: json['reallocation_address'],
        reallocation_address: json['reallocation_address']);
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
        reallocation_method: json['reallocation_method'] == null
            ? ''
            : json['reallocation_method'],
        reallocation_address: json['reallocation_address'] == null
            ? ''
            : json['reallocation_address']);
  }
}

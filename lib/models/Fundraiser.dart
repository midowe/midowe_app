
class Fundraiser {
  late int id;
  late String full_name;
  late String headline;
  late String email;
  late  String phone;
  late String username;

  Fundraiser({
    required this.id,
    required this.full_name,
    required this.headline,
    required this.email,
    required this.phone,
    required this.username,
  });

  factory Fundraiser.fromJson(Map<String, dynamic> json,  int id ) {
    return Fundraiser(
      id: id,
      full_name: json['full_name']==null? "":json['full_name'],
      headline: json['headline']==null? "":json['headline'],
      email: json['email']==null? "":json['email'],
      phone: json['phone']==null? false: json['phone'],
      username: json['on_spot'] ==null? '': json['username']
    );

  }



}

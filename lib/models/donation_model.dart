class Donation {
  final int id;
  final String transaction_id;
  final num amount;
  final String donor_name;
  final String donor_phone;
  final String donor_email;
  final String donor_message;

  final String createdAt;
  final String updatedAt;

  Donation({
    required this.id,
    required this.transaction_id,
    required this.amount,
    required this.donor_name,
    required this.donor_phone,
    required this.donor_email,
    required this.donor_message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Donation.fromJson(Map<String, dynamic> json, int id) {
    return Donation(
        id: id,
        transaction_id:
            json['transaction_id'] == null ? "" : json['transaction_id'],
        amount: json['amount'] == null ? "" : json['amount'],
        donor_name: json['donor_name'] == null ? "" : json['donor_name'],
        donor_phone: json['donor_phone'] == null ? "" : json['donor_phone'],
        donor_email: json['donor_email'] == null ? "" : json['donor_email'],
        donor_message:
            json['donor_message'] == null ? "" : json['donor_message'],
        createdAt: json['createdAt'] == null ? "" : json['createdAt'],
        updatedAt: json['updatedAt'] == null ? "" : json['updatedAt']);
  }
}

// ignore_for_file: non_constant_identifier_names

class PaymentRequest {
  late String account_id;
  late String campaign_id;
  late String campaign_name;
  late String amount;
  late String third_party_reference;
  late String payment_method;
  late String payment_address;
  late String supporter_email;
  late String supporter_name;
  late String supporter_message;

  PaymentRequest(
      {required this.account_id,
      required this.campaign_id,
      required this.campaign_name,
      required this.amount,
      required this.third_party_reference,
      required this.payment_method,
      required this.payment_address,
      required this.supporter_email,
      required this.supporter_name,
      required this.supporter_message});

  factory PaymentRequest.fromJson(Map<String, dynamic> json) {
    return PaymentRequest(
        account_id: json['account_id'] == null ? "" : json['account_id'],
        campaign_id: json['campaign_id'] == null ? "" : json['campaign_id'],
        campaign_name:
            json['campaign_name'] == null ? "" : json['campaign_name'],
        amount: json['amount'] == null ? "" : json['amount'],
        third_party_reference: json['third_party_reference'] == null
            ? ""
            : json['third_party_reference'],
        payment_method:
            json['payment_method'] == null ? "" : json['payment_method'],
        payment_address:
            json['payment_address'] == null ? "" : json['payment_address'],
        supporter_email:
            json['supporter_email'] == null ? "" : json['supporter_email'],
        supporter_name:
            json['supporter_name'] == null ? "" : json['supporter_name'],
        supporter_message:
            json['supporter_message'] == null ? "" : json['supporter_message']);
  }
}

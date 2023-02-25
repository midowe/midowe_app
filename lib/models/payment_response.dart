class PaymentResponse {
  late bool success;
  late String thirdPartyReference;
  late String conversationId;
  late String transactionId;
  late String responseCode;
  late String responseDescription;

  PaymentResponse(
      {required this.success,
      required this.thirdPartyReference,
      required this.conversationId,
      required this.transactionId,
      required this.responseCode,
      required this.responseDescription});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
        success: json['Success'] ?? false,
        thirdPartyReference: json['ThirdPartyReference'] == null
            ? ""
            : json['ThirdPartyReference'],
        conversationId:
            json['ConversationId'] == null ? "" : json['ConversationId'],
        transactionId:
            json['TransactionId'] == null ? "" : json['TransactionId'],
        responseCode: json['ResponseCode'] == null ? "" : json['ResponseCode'],
        responseDescription: json['ResponseDescription'] == null
            ? ""
            : json['ResponseDescription']);
  }
}

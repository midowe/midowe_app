class Statistics {
  final int totalDonations;
  final double totalAmount;

  Statistics({required this.totalDonations, required this.totalAmount});

  factory Statistics.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return Statistics(totalDonations: 0, totalAmount: 0);
    }
    return Statistics(
      totalDonations: int.parse(json['totalDonations']['N']),
      totalAmount: double.parse(json['totalAmount']['N']),
    );
  }
}

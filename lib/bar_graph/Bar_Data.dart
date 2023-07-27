import 'package:expand_tracker/bar_graph/individualbar.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thrAmount;
  final double friAmount;
  final double satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thrAmount,
    required this.friAmount,
    required this.satAmount,
  });

  List<IndividualBar> barData = [];

  void intializeBarData() {
    barData = [
      IndividualBar(X: 0, y: sunAmount),
      IndividualBar(X: 1, y: monAmount),
      IndividualBar(X: 2, y: tueAmount),
      IndividualBar(X: 3, y: wedAmount),
      IndividualBar(X: 4, y: thrAmount),
      IndividualBar(X: 5, y: friAmount),
      IndividualBar(X: 6, y: satAmount)
    ];
  }
}

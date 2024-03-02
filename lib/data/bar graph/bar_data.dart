// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expense_tracker/data/bar%20graph/indivisual_bar.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;
  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount,
  });
  List<IndivisualBarData> barData = [];
  void initialiseBarData() {
    barData = [
      IndivisualBarData(x: 0, y: sunAmount),
      IndivisualBarData(x: 1, y: monAmount),
      IndivisualBarData(x: 2, y: tueAmount),
      IndivisualBarData(x: 3, y: wedAmount),
      IndivisualBarData(x: 4, y: thuAmount),
      IndivisualBarData(x: 5, y: friAmount),
      IndivisualBarData(x: 6, y: satAmount),
    ];
  }
}

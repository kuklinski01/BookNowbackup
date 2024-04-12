import 'package:flutter/material.dart';

class SeatSelection extends StatefulWidget {
  final ValueChanged<int> onSeatSelected;

  const SeatSelection({Key? key, required this.onSeatSelected}) : super(key: key);

  @override
  _SeatSelectionState createState() => _SeatSelectionState();
}

class _SeatSelectionState extends State<SeatSelection> {
  List<bool> _selectedSeats = List.generate(56, (index) => false);
  int _selectedSeatCount = 0;

  void _toggleSeat(int index) {
    setState(() {
      _selectedSeats[index] = !_selectedSeats[index];
      _selectedSeatCount += _selectedSeats[index] ? 1 : -1;
      widget.onSeatSelected(_selectedSeatCount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 400,
      height: 400,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: List.generate(56, (index) {
          return GestureDetector(
            onTap: () => _toggleSeat(index),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: _selectedSeats[index] ? Colors.blue : Colors.grey[300],
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

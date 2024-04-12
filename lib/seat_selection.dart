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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      for (int i = 1; i <= 8; i++) 
                        Text(
                          'Row $i',
                          style: TextStyle(fontSize: 12),
                        ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 400,
                    height: 300,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 8,
                        childAspectRatio: 1,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: 56,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => _toggleSeat(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedSeats[index] ? Colors.blue : Colors.grey[300],
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                'S${index + 1}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

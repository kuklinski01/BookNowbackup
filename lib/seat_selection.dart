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
          // Seats
          Container(
            width: 400,
            height: 300,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 56,
              itemBuilder: (BuildContext context, int index) {
                int seatNumber = (index % 8) + 1; // Calculate seat number from 1 to 8

                return GestureDetector(
                  onTap: () => _toggleSeat(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedSeats[index] ? Color(0xFF01163e) : Color(0xFF444451),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    margin: EdgeInsets.all(5),
                    width: 35,
                    height: 30,
                    child: Center(
                      child: Text(
                        '$seatNumber', // Display seat number from 1 to 8
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20), // Add some spacing between the seats and the screen
          // Theater Screen
          Container(
            width: 400,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'Theater Screen',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 20), // Add some spacing between the screen and personal details
          // Personal Details Box
          Container(
            width: 400,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 42, 93, 170),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Personal Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Add your logic here to handle personal details submission
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

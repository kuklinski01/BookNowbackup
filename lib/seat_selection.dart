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
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Category Box
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // N/A Seat
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 138, 129, 128),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'N/A',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  // Occupied Seat
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 148, 17, 17),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Occupied',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  // Selected Seat
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 18, 173, 83),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Selected',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
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
                        color: _selectedSeats[index] ? Color.fromARGB(255, 51, 163, 75) : Color(0xFF444451),
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
            // Theater Screen with Image
            Container(
              width: 650,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://dl.dropbox.com/scl/fi/6m7mf1v85ljjyh6c6wcoe/screen-edited.png?rlkey=lal8fo77d5oo28ksb6c4gvlyv&dl=0',
                  width: 200,
                  height: 900,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 20),
    
    
    // Add some spacing at the end of the page
 
                      
          ],
        ),
      ),
    );
  }
}

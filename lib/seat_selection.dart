import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seat Selection',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Movie Theater Seat Selection'),
        ),
        body: SeatSelection(onSeatSelected: (int count) {
          print('Selected $count seats');
        }),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SeatSelection extends StatefulWidget {
  final ValueChanged<int> onSeatSelected;

  const SeatSelection({Key? key, required this.onSeatSelected}) : super(key: key);

  @override
  _SeatSelectionState createState() => _SeatSelectionState();
}

class _SeatSelectionState extends State<SeatSelection> {
  List<bool> _selectedSeats = List.generate(84, (index) => false);
  int _selectedSeatCount = 0;
  int _hoveredSeatIndex = -1;
  final double seatPrice = 12.50;

  void _toggleSeat(int index) {
    setState(() {
      _selectedSeats[index] = !_selectedSeats[index];
      _selectedSeatCount += _selectedSeats[index] ? 1 : -1;
      widget.onSeatSelected(_selectedSeatCount);
    });
  }

  double calculateTotalAmount() {
    return _selectedSeatCount * seatPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(33, 77, 117, 0.84),
            Color.fromRGBO(14, 11, 22, 0.95),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView( // Added SingleChildScrollView
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Category Box
              Container(
                margin: EdgeInsets.only(bottom: 30),
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
                width: 500,
                height: 500,
                padding: EdgeInsets.all(10),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 12, // Updated to 13 seats per row
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 7,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 84,
                  itemBuilder: (BuildContext context, int index) {
                    int row = index ~/ 12 + 1;
                    int column = index % 12 + 1;
                    return MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          // Change the color when the mouse enters
                          _hoveredSeatIndex = index;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          // Reset the color when the mouse exits
                          _hoveredSeatIndex = -1;
                        });
                      },
                      child: GestureDetector(
                        onTap: () => _toggleSeat(index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedSeats[index]
                                ? Color.fromARGB(255,51, 163, 75)
                                : (_hoveredSeatIndex == index ? Colors.grey : Color(0xFF444451)),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          margin: EdgeInsets.all(1),
                          width: 20,
                          height: 50,
                          child: Center(
                            child: Text(
                              '$column',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
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
                  borderRadius: BorderRadius.circular(0),
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
              SizedBox(height: 10), // Add some spacing between the theater screen and the selected seat count
              // Selected Seat Count and Total Amount
              Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          'Selected Seats: $_selectedSeatCount',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 35, 6, 71), // Set the color of the container
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Total Amount: ${calculateTotalAmount().toStringAsFixed(2)} €',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 252, 252)),
                            ),
                          ),
                        ),
                        SizedBox(height: 20), // Add some space between the total amount and the button
                        ElevatedButton(
                          onPressed: () {
                            // Add logic here to handle booking tickets
                            print('Booking $_selectedSeatCount tickets'); // For demonstration, printing the number of selected seats
                          },
                          child: Text('Book Tickets'),
                          
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

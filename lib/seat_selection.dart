import 'package:flutter/material.dart';

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
  List<bool> _selectedSeats = List.generate(98, (index) => false);
  int _selectedSeatCount = 0;

  final double seatPrice = 12.50;
  String _seatNumber = '';

  void _toggleSeat(int index) {
    setState(() {
      _selectedSeats[index] = !_selectedSeats[index];
      _selectedSeatCount += _selectedSeats[index] ? 1 : -1;
    });
  }

  void _displaySeatNumber(int index) {
    int row = (index / 12).floor() + 1;
    int column = index % 12 + 1;
    _seatNumber = 'Seat: $row-$column';
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
        body: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 2, top: 20),
                          padding: EdgeInsets.all(10),
                          width: 300,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 36, 44, 122),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _infoBox('N/A', Color.fromARGB(255, 138, 129, 128)),
                              _infoBox('Occupied', Color.fromARGB(255, 148, 17, 17)),
                              _infoBox('Selected', Color.fromARGB(255, 22, 138, 138)),
                            ],
                          ),
                        ),
                        Container(
                          width: 700,
                          height: 550,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Expanded(
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 12,
                                    childAspectRatio: 1.1,
                                    crossAxisSpacing: 6,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemCount: 96,
                                  itemBuilder: (BuildContext context, int index) {
                                    int seatNumber = 12 - (index % 12);
                                    return GestureDetector(
                                      onTap: () => _toggleSeat(index),
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.ease,
                                        decoration: BoxDecoration(
                                          color: _selectedSeats[index] ? Color.fromARGB(255, 8, 23, 73) : Color.fromARGB(255, 121, 143, 156),
                                          border: Border.all(color: Color.fromARGB(255, 255, 255, 255), width: 2),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                          ),
                                        ),
                                        margin: EdgeInsets.all(5),
                                        width: 10,
                                        height: 30,
                                        child: Center(
                                          child: Text(
                                            _selectedSeats[index] ? '${seatNumber}' : '',
                                            style: TextStyle(
                                              color: _selectedSeats[index] ? Colors.white : Color.fromARGB(255, 121, 143, 156),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
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
                        Text(
                          _seatNumber,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 560,
              left: 555,
              child: Container(
                width: 800,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://dl.dropbox.com/scl/fi/6m7mf1v85ljjyh6c6wcoe/screen-edited.png?rlkey=lal8fo77d5oo28ksb6c4gvlyv&dl=0',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 120,
              right: 120,
              child: Container(
                
                  
                
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Selected Seats: $_selectedSeatCount',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Total Amount: ${calculateTotalAmount().toStringAsFixed(2)} €',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => print('Booking $_selectedSeatCount tickets'),
                      child: Text('Book Tickets'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(String label, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

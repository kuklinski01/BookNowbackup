// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'seat_selection.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Ticket Booking',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/booking': (context) => BookingPage(),
      },
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Poster'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'https://dl.dropboxusercontent.com/scl/fi/o3fplq18o9ebclq4q6hzu/poster.jpeg?rlkey=xckka23q55ukwbgudxfns744w&dl=0',
              width: 200,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Movie Description: Add your movie description here',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/booking');
                },
                child: Text('Book Tickets'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Tickets'),
      ),
      body: SeatSelection(
        onSeatSelected: (selectedSeatCount) {
          // Update total price or perform other actions based on selected seat count
        },
        
      ),
      
    );
  }
}

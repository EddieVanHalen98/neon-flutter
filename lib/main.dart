import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Blocks(),
        ),
      ),
    );
  }
}

class BlocksState extends State<Blocks> {
  @override
  Widget build(BuildContext context) {
    return _buildBlocks();
  }
}

class Blocks extends StatefulWidget {
  @override
  BlocksState createState() => BlocksState();
}

Widget _buildBlocks() {
  return ListView.builder(
      padding: const EdgeInsets.all(32.0),
      physics: const BouncingScrollPhysics(),
      itemCount: 8,
      itemBuilder: (context, i) {
        return _buildBlock();
      });
}

Widget _buildBlock() {
  return Container(
    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
    child: Card(
      color: Colors.white,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "5PM",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Write music",
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Icon(Icons.audiotrack, size: 48, color: Colors.grey),
          ],
        ),
      ),
    ),
  );
}
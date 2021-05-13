import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int leftDice = 1;
  int rightDice = 1;
  AnimationController _controller;
  CurvedAnimation animation;
  @override
  void initState() {
    // ignore: todo
    //TODO: implement initState
    super.initState();
    animate();
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  animate() {
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);

    animation.addListener(() {
      setState(() {});
      print(_controller.value);
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          leftDice = Random().nextInt(6) + 1;
          rightDice = Random().nextInt(6) + 1;
        });
        print('Completed');
        _controller.reverse();
      }
    });
  }

  void roll() {
    _controller.forward();
    // setState(() {
    //   leftDice = Random().nextInt(6) + 1;
    //   rightDice = Random().nextInt(6) + 1;
    //});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Roll Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: roll,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Image(
                        height: 200 - (animation.value) * 200,
                        image: AssetImage('assets/images/d$leftDice.png'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: roll,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Image(
                        height: 200 - (animation.value) * 200,
                        image: AssetImage('assets/images/d$rightDice.png'),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: ElevatedButton(
                    onPressed: roll,
                    child: Text(
                      'Roll',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    )))
          ],
        ),
      ),
    );
  }
}

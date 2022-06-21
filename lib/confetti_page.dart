import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiPage extends StatefulWidget {
  const ConfettiPage({Key? key}) : super(key: key);

  @override
  State<ConfettiPage> createState() => _ConfettiPageState();
}

class _ConfettiPageState extends State<ConfettiPage> {
  final controller = ConfettiController();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {
        isPlaying = controller.state == ConfettiControllerState.playing;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const Text('Confetti Animation'),
          ),
          body: Center(
            child: ElevatedButton(
              child: Text(isPlaying ? 'Stop' : 'Celebrate'),
              onPressed: () {
                if (isPlaying) {
                  controller.stop();
                } else {
                  controller.play();
                }
              },
            ),
          ),
        ),
        ConfettiWidget(
          confettiController: controller,
          shouldLoop: true,

          //set direction
          blastDirection: -pi / 2, //up
          blastDirectionality: BlastDirectionality.explosive, //all

          ///set emision count
          emissionFrequency: 0.02, //0.0 --> 1.0
          numberOfParticles: 4,

          ///set intensity
          minBlastForce: 1,
          maxBlastForce: 10,

          ///set speed
          gravity: 0.2, //0.0 --> 1.0

          //change confetty shape
          createParticlePath: (size) {
            final path = Path();
            path.addOval(Rect.fromCircle(center: Offset.zero, radius: 10));
            return path;
          },

          ///change the colors of confetties
          colors: const [Colors.red, Colors.pink, Colors.yellow, Colors.blue],
        )
      ],
    );
  }
}

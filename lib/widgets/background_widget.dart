import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BackgroundWidget extends StatelessWidget {
  final int index;

  const BackgroundWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final imageAsset = index == 0 ? 'assets/images/image1.png' : 'assets/images/skin2.png';

    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imageAsset), fit: BoxFit.cover),
      ),
      child:
          Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: index == 0
                        ? [Colors.black, Colors.black26]
                        : [Colors.black.withOpacity(0.6), Colors.transparent],
                    stops: index == 0 ? [0.0, 0.7] : [0.0, 0.2],
                  ),
                ),
              )
              .animate()
              .fadeIn()
              .slideY(begin: 0.05, end: 0, curve: Curves.easeOut)
              .scale(begin: const Offset(1.1, 1.1), end: const Offset(1, 1), curve: Curves.easeOut),
    );
  }
}

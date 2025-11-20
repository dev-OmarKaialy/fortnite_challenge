import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HeaderWidget extends StatelessWidget {
  final int index;

  const HeaderWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final skinNames = ['Shadow Assassin', 'Ice King', 'Raven', 'Drift'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo with enhanced animation and About button
        Image.asset('assets/images/Logo.png')
            .animate()
            .fadeIn(duration: 600.ms)
            .slideX(begin: -0.1, end: 0, curve: Curves.elasticOut)
            .shake(duration: 800.ms, delay: 400.ms),

        const SizedBox(height: 16),

        // Title with skin name
        Text(
              '${skinNames[index % skinNames.length]} Skin',
              style: theme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
            )
            .animate(delay: 80.ms)
            .fadeIn(duration: 500.ms)
            .slideY(begin: 0.5, end: 0, curve: Curves.easeOut)
            .then(delay: 100.ms),

        const SizedBox(height: 16),

        // Subtitle
        Text(
              'Everything you might have missed in the Fortnite New Skin.',
              style: theme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.9),
              ),
            )
            .animate(delay: 160.ms)
            .fadeIn(duration: 500.ms)
            .slideY(begin: 0.3, end: 0, curve: Curves.easeOut)
            .then(delay: 100.ms),
      ],
    );
  }
}

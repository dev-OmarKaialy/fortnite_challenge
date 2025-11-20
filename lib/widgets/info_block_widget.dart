import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class InfoBlockWidget extends StatefulWidget {
  const InfoBlockWidget({super.key});

  @override
  State<InfoBlockWidget> createState() => _InfoBlockWidgetState();
}

class _InfoBlockWidgetState extends State<InfoBlockWidget> {
  static const Duration _tickDuration = Duration(seconds: 1);

  final ValueNotifier<Duration> _time = ValueNotifier<Duration>(
    Duration(
      hours: Random().nextInt(24),
      minutes: Random().nextInt(60),
      seconds: Random().nextInt(60),
    ),
  );

  Timer? _timer;
  @override
  void initState() {
    super.initState();

    // Countdown timer
    _timer = Timer.periodic(_tickDuration, (t) {
      final current = _time.value;
      if (current > Duration.zero) {
        _time.value = current - const Duration(seconds: 1);
      } else {
        t.cancel();
      }
    });

    // Start initial download simulation
  }

  @override
  void dispose() {
    _timer?.cancel();
    _time.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hintStyle = Theme.of(context).hintColor;
    final labelStyle = Theme.of(context).textTheme.labelLarge;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Divider with glow effect
        Divider(color: Colors.white.withOpacity(0.3))
            .animate(delay: 200.ms)
            .fadeIn(duration: 500.ms)
            .scaleX(begin: 0, end: 1, curve: Curves.easeOut),

        // Status section
        Text('Current status:', style: labelStyle?.copyWith(color: hintStyle))
            .animate(delay: 220.ms)
            .fadeIn(duration: 400.ms)
            .slideX(begin: -0.2, end: 0, curve: Curves.easeOut),

        Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 16,
            ).animate(delay: 240.ms).scale(duration: 300.ms),
            const SizedBox(width: 8),
            Text('No incidents reported today.')
                .animate(delay: 240.ms)
                .fadeIn(duration: 400.ms)
                .slideX(begin: -0.1, end: 0, curve: Curves.easeOut),
          ],
        ),

        Divider(color: Colors.white.withOpacity(0.3))
            .animate(delay: 260.ms)
            .fadeIn(duration: 500.ms)
            .scaleX(begin: 0, end: 1, curve: Curves.easeOut),

        Text('Event remaining time:', style: labelStyle?.copyWith(color: hintStyle))
            .animate(delay: 280.ms)
            .fadeIn(duration: 400.ms)
            .slideX(begin: -0.2, end: 0, curve: Curves.easeOut),

        // Countdown time with pulse effect
        ValueListenableBuilder<Duration>(
          valueListenable: _time,
          builder: (context, value, _) {
            final hours = value.inHours.toString().padLeft(2, '0');
            final minutes = (value.inMinutes % 60).toString().padLeft(2, '0');
            final seconds = (value.inSeconds % 60).toString().padLeft(2, '0');

            return Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.amber,
                  size: 18,
                ).animate(delay: 300.ms).fadeIn(duration: 400.ms),
                const SizedBox(width: 8),
                Text(
                      '$hours:$minutes:$seconds',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    )
                    .animate(delay: 300.ms)
                    .fadeIn(duration: 400.ms)
                    .slideX(begin: -0.1, end: 0, curve: Curves.easeOut),
              ],
            );
          },
        ),
      ],
    );
  }
}

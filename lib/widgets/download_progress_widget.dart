import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DownloadProgressWidget extends StatefulWidget {
  const DownloadProgressWidget({super.key});

  @override
  State<DownloadProgressWidget> createState() => _DownloadProgressWidgetState();
}

class _DownloadProgressWidgetState extends State<DownloadProgressWidget> {
  final ValueNotifier<double> percent = ValueNotifier<double>(0);
  Timer? _downloadTimer;
  final Random _random = Random();

  final ValueNotifier<bool> isDownloading = ValueNotifier<bool>(false);
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _downloadTimer?.cancel();
    percent.dispose();
    isDownloading.dispose();
    super.dispose();
  }

  void _startDownloadSimulation() {
    isDownloading.value = true;
    percent.value = 0;

    // Simulate realistic download progression
    _downloadTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (percent.value >= 1.0) {
        timer.cancel();
        isDownloading.value = false;
      } else {
        final progress = percent.value;
        double increment;
        if (progress < 0.3) {
          increment = 0.01; // Slow start
        } else if (progress < 0.8) {
          increment = 0.008; // Fast middle
        } else if (progress > 0.95) {
          increment = 0.00002;
        } else {
          increment = 0.0005; // Slow finish
        }

        percent.value = (percent.value + increment + _random.nextDouble() * 0.02).clamp(0.0, 1.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: percent,
      builder: (context, value, _) {
        final displayed = (value * 100);

        return ValueListenableBuilder<bool>(
          valueListenable: isDownloading,
          builder: (context, downloading, _) {
            String statusText;
            if (!downloading) {
              statusText = value == 0 ? '' : 'Download Complete!';
            } else if (value < 0.3) {
              statusText = 'Preparing download...';
            } else if (value < 0.7) {
              statusText = 'Downloading skin data...';
            } else {
              statusText = 'Finalizing installation...';
            }

            return Column(
              children: [
                // Status text
                Text(
                      statusText,
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge?.copyWith(color: Colors.white.withOpacity(0.8)),
                    )
                    .animate(delay: 320.ms)
                    .fadeIn(duration: 400.ms)
                    .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),

                const SizedBox(height: 8),

                // Progress bar with enhanced animations
                GestureDetector(
                  onTap: () {
                    if (value == 1) {
                      showAdaptiveDialog(
                        context: context,
                        builder: (context) => reDownloadDialog(context),
                      );
                    } else {
                      _startDownloadSimulation();
                    }
                  },
                  child:
                      LinearPercentIndicator(
                            lineHeight: 50,
                            percent: value.clamp(0.0, 1.0),
                            animation: true,
                            animateFromLastPercent: true,
                            animationDuration: 500,
                            linearGradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xffC036D0), Color(0xff9013FE), Color(0xff6A11CB)],
                            ),
                            center: value == 0.0
                                ? TextButton(
                                    onPressed: () {
                                      _startDownloadSimulation();
                                    },
                                    child: Text('Click here to download skin'),
                                  )
                                : Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 16),
                                        Text(
                                          '${displayed.toStringAsFixed(1)}%',
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            backgroundColor: Colors.black.withOpacity(0.4),
                            padding: EdgeInsets.zero,
                          )
                          .animate(delay: 360.ms)
                          .fadeIn(duration: 600.ms)
                          .slideY(begin: 0.3, end: 0, curve: Curves.elasticOut)
                          .then(delay: 200.ms)
                          .shimmer(
                            delay: 1.seconds,
                            duration: 2.seconds,
                            color: Colors.white.withOpacity(0.1),
                          ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Dialog reDownloadDialog(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2A0B5E), Color(0xFF6A11CB)],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.45),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.cloud_download, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Re-download skin',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Body
            Text(
              'Are you sure you want to re-download this skin? This will overwrite any existing data for the skin and restart the download process.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white.withOpacity(0.9)),
            ),
            const SizedBox(height: 18),

            // Actions
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.white.withOpacity(0.06),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFC036D0), Color(0xFF9013FE)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _startDownloadSimulation();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.sync, size: 18),
                          SizedBox(width: 8),
                          Text('Re-download', style: TextStyle(fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

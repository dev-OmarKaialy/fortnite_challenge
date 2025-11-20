import 'package:flutter/material.dart';
import 'package:fortnite_challenge/screens/about_me.dart';

import '../widgets/background_widget.dart';
import '../widgets/download_progress_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/info_block_widget.dart';

class SkinsScreen extends StatefulWidget {
  const SkinsScreen({super.key});

  @override
  State<SkinsScreen> createState() => _SkinsScreenState();
}

class _SkinsScreenState extends State<SkinsScreen> {
  // Constants
  static const double _horizontalPadding = 24.0;
  static const double _bottomSpacing = kBottomNavigationBarHeight;
  static const int _pageCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [const AboutMeIcon()],
      ),
      body: PageView.builder(
        itemCount: _pageCount,
        padEnds: true,
        pageSnapping: true,
        itemBuilder: (context, index) {
          return Stack(
            fit: StackFit.expand,
            children: [
              BackgroundWidget(index: index),
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(_horizontalPadding),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeaderWidget(index: index),
                            const SizedBox(height: 12),
                            InfoBlockWidget(),
                          ],
                        ),
                      ),
                    ),
                    DownloadProgressWidget(),
                    const SizedBox(height: _bottomSpacing),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

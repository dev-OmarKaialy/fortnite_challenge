import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fortnite_challenge/screens/about_me.dart';
import 'package:fortnite_challenge/screens/skins_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/image.png'), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row with Skip and About buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) =>
                                ScaleTransition(
                                  scale: animation,
                                  child: SlideTransition(
                                    position: Tween(
                                      begin: Offset(1, 0),
                                      end: Offset(0, 0),
                                    ).animate(animation),
                                    child: SkinsScreen(),
                                  ),
                                ),
                          ),
                        );
                      },
                      child: Text('Skip', style: Theme.of(context).textTheme.titleMedium),
                    ),
                    const AboutMeIcon(),
                  ],
                ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.5, end: 0),

                SizedBox(height: 100),

                // Logo with scale and bounce animation
                Image.asset('assets/images/Icon.png')
                    .animate()
                    .scale(begin: Offset(0.5, 0.5), end: Offset(1, 1), curve: Curves.elasticOut)
                    .fadeIn(duration: 600.ms)
                    .animate(
                      onComplete: (controller) => Future.delayed(800.ms, () async {
                        if (context.mounted) {
                          await controller.reverse();
                          await controller.forward();
                        }
                      }),
                    )
                    .scale(begin: Offset(0.8, 0.8), end: Offset(1, 1)),

                SizedBox(height: 24),

                // Title section with staggered animations
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Column(
                    children: [
                      Text(
                            'Create your account',
                            style: Theme.of(
                              context,
                            ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
                          )
                          .animate()
                          .fadeIn(duration: 500.ms)
                          .slideY(begin: 0.5, end: 0, curve: Curves.easeOut),

                      SizedBox(height: 16),

                      Text(
                            'Come on in! Join Fortnite to always be in the game.',
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          )
                          .animate()
                          .fadeIn(duration: 500.ms)
                          .slideY(begin: 0.3, end: 0, curve: Curves.easeOut)
                          .then(delay: 100.ms),
                    ],
                  ),
                ),

                // Form with sequential animations
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40),

                      // First Name field
                      TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) => value?.isNotEmpty ?? false ? null : 'Required',
                            decoration: InputDecoration(hintText: 'First Name'),
                          )
                          .animate()
                          .fadeIn(duration: 400.ms)
                          .slideX(begin: -0.3, end: 0, curve: Curves.easeOut)
                          .then(delay: 100.ms),

                      SizedBox(height: 16),

                      // Email field
                      TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                                RegExp(
                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$",
                                  caseSensitive: false,
                                ).hasMatch(value ?? '')
                                ? null
                                : 'Enter Valid Email',
                            decoration: InputDecoration(hintText: 'E-mail'),
                          )
                          .animate()
                          .fadeIn(duration: 400.ms)
                          .slideX(begin: -0.3, end: 0, curve: Curves.easeOut)
                          .then(delay: 200.ms),

                      SizedBox(height: 40),

                      ElevatedButton.icon(
                            icon: Icon(Icons.arrow_forward_ios_rounded),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) =>
                                        ScaleTransition(
                                          scale: animation,
                                          child: SlideTransition(
                                            position: Tween(
                                              begin: Offset(1, 0),
                                              end: Offset(0, 0),
                                            ).animate(animation),
                                            child: SkinsScreen(),
                                          ),
                                        ),
                                  ),
                                );
                              }
                            },
                            iconAlignment: IconAlignment.end,
                            label: Text('Next'),
                          )
                          .animate()
                          .fadeIn(duration: 500.ms)
                          .slideY(begin: 0.5, end: 0, curve: Curves.easeOut)
                          .shake(delay: 1.seconds, duration: 800.ms), // Optional: add subtle shake
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bie_daalt/pages/home_page.dart';

class IntroScreenPage extends StatelessWidget {
  const IntroScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "Welcome to Flutter",
          bodyWidget: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: "Build ",
                    style:
                        GoogleFonts.poppins(color: Colors.black, fontSize: 20)),
                TextSpan(
                    text: "beautiful apps ",
                    style: GoogleFonts.poppins(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                TextSpan(
                    text: "easily!",
                    style:
                        GoogleFonts.poppins(color: Colors.black, fontSize: 20)),
              ],
            ),
          ),
          image: const CircleAvatar(
            backgroundImage: AssetImage('assets/flutter_logo.png'),
            radius: 50,
          ),
        ),
        PageViewModel(
          title: "Interactive Widgets",
          body: "Use Flexible, Expanded, and Animated widgets for rich UI.",
          image: const Icon(Icons.animation, size: 100, color: Colors.blue),
        ),
        PageViewModel(
          title: "Let’s Get Started!",
          body: "Tap Done to explore the main page.",
          image: const Icon(Icons.done_all, size: 100, color: Colors.green),
        ),
      ],
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.bold)),
      onDone: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      },
    );
  }
}

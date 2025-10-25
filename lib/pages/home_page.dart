import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<String> _data;

  Future<String> fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    return "Flutter FutureBuilder successfully loaded async data!";
  }

  @override
  void initState() {
    super.initState();
    _data = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Home Page', style: GoogleFonts.poppins()),
              background: Hero(
                tag: 'logo',
                child:
                    Image.asset('assets/flutter_logo.png', fit: BoxFit.cover),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Flexible(
                    child: Container(
                      height: size.height * 0.2,
                      color: Colors.blue[50],
                      child: const Center(
                        child: Text("Flexible Container Example"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: FutureBuilder<String>(
                      future: _data,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else {
                          return SelectableText(snapshot.data!,
                              style: GoogleFonts.poppins(fontSize: 16));
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: InteractiveViewer(
                      child: Image.asset('assets/flutter_logo.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

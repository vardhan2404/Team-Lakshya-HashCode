import 'package:flutter/material.dart';

class Choice extends StatelessWidget {
  const Choice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 180.0,
              ),
              const Image(
                image: AssetImage('assets/images/logo.png'),
                height: 180,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Keeping you safe and informed",
                style: TextStyle(
                    fontFamily: "Times New Roman",
                    fontSize: 22,
                    fontStyle: FontStyle.italic,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2.0
                      ..color = Colors.redAccent),
              ),
              const SizedBox(
                height: 110,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  minimumSize: const Size(150, 40),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                child: const Text('Sign In'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  minimumSize: const Size(150, 40),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:fashion_challenger_system/loginpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: width,
            height: height,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                Positioned(
                  left: width * 0.3,
                  top: height * 0.7,
                  child: Container(
                    width: width * 0.4,
                    height: height * 0.07,
                    padding: const EdgeInsets.all(12),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xFFC96B7C),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFF2C2C2C)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginSignup()),
                        );
                      },
                      child: Center(
                        child: Text(
                          'Explore',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Positioned(
                  left: width * 0.10,
                  top: height * 0.79,
                  child: Text(
                    'Welcome to the Fashion Challenger System!',
                    style: TextStyle(
                      color: Color.fromARGB(255, 7, 72, 123),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  left: width * 0.07,
                  top: height * 0.15,
                  child: Container(
                    width: width * 0.86,
                    height: height * 0.53,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://tse2.mm.bing.net/th?id=OIG2.PKI7G1E.qyIkg_6LHe3T&w=270&h=270&c=6&r=0&o=5&dpr=1.5&pid=ImgGn",
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
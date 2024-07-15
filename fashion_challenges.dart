import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FashionChallengesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7E7DC),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.logout, color: Colors.black),
          onPressed: () {
            // Implement your logout functionality here
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
              }
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Color(0xFFF7E7DC)),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  'The Fashion Challenges',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              _buildChallengeBox(
                context,
                color: Color(0xFFD3C9EE),
                title: 'Mix and Match Patterns Challenge',
                description:
                    'Challenge Number: 1\n'
                    'Create an outfit that successfully combines different patterns.\n'
                    'Showcase your ability to mix patterns while maintaining a stylish and balanced look.',
                imageUrl:
                    "https://tse3.mm.bing.net/th?id=OIG2..zJZKT3NPBkyauAnULr1&w=270&h=270&c=6&r=0&o=5&dpr=1.5&pid=ImgGn", // Replace with actual image URL
                challengeId: '1', // Pass the actual challenge ID
              ),
              SizedBox(height: 20),
              _buildChallengeBox(
                context,
                color: Color(0xFF95E5EA),
                title: 'Modern Tradition Fusion Challenge',
                description:
                    'Challenge Number: 2\n'
                    'Blend traditional cultural attire with modern fashion elements to create a unique and innovative outfit.',
                imageUrl:
                    "https://tse4.mm.bing.net/th?id=OIG3.HgGHiv4BpFdk7vEbGs9X&w=270&h=270&c=6&r=0&o=5&dpr=1.5&pid=ImgGn", // Replace with actual image URL
                challengeId: '2', // Pass the actual challenge ID
              ),
              SizedBox(height: 20),
              _buildRewardButton(context, 'My Rewards'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChallengeBox(
    BuildContext context, {
    required Color color,
    required String title,
    required String description,
    required String imageUrl,
    required String challengeId,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'Righteous',
              fontWeight: FontWeight.w400,
              height: 1.2,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 1.5,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Image.network(
              imageUrl,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton(context, 'Participate', Colors.blue, '/upload'),
              _buildButton(context, 'Leaderboard', Colors.green, '/leaderboard', challengeId: challengeId),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Color color, String route, {String? challengeId}) {
    return ElevatedButton(
      onPressed: () {
        if (challengeId != null) {
          Get.toNamed(route, parameters: {'challengeId': challengeId});
        } else {
          Navigator.pushNamed(context, route);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          height: 1.2,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildRewardButton(BuildContext context, String text) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/rewards');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          height: 1.2,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

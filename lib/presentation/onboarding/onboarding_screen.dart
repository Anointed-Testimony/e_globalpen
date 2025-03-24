import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:e_globalpen_app/widgets/indicator_widget.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Welcome to Global Pen Reads",
      "description":
          "Discover a world of books at your fingertips. Read, listen, and enjoy stories that inspire, educate, and entertain.",
      "image": "assets/images/welcome_illustration.png"
    },
    {
      "title": "Listen to your favourite audiobooks",
      "description":
          "Immerse yourself in captivating audiobooks anytime, anywhere. Let the stories come to life with just a tap.",
      "image": "assets/images/welcome_illustration_2.webp"
    },
    {
      "title": "Easy to explore",
      "description":
          "Find books effortlessly with our seamless navigation. Browse by genre, author, or trending titles and start reading instantly.",
      "image": "assets/images/welcome_illustration_3.jpg"
    },
  ];

  void _nextPage() {
    if (_currentPage == onboardingData.length - 1) {
      _finishOnboarding();
    } else {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _finishOnboarding() async {
    var box = await Hive.openBox('appData'); // Ensure box is opened
    await box.put('hasSeenOnboarding', true); // Ensure onboarding is saved
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/signin');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, index) => OnboardingContent(
                title: onboardingData[index]["title"]!,
                description: onboardingData[index]["description"]!,
                image: onboardingData[index]["image"]!,
                onSkip: _finishOnboarding,
              ),
            ),
          ),
          _buildBottomSection(),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
              (index) => IndicatorDot(isActive: index == _currentPage),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_currentPage != onboardingData.length - 1)
                TextButton(
                  onPressed: _finishOnboarding,
                  child: Text("Skip"),
                ),
              ElevatedButton(
                onPressed: _nextPage,
                child: Text(_currentPage == onboardingData.length - 1
                    ? "Sign in"
                    : "Next"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String title, description, image;
  final VoidCallback onSkip;

  const OnboardingContent({
    required this.title,
    required this.description,
    required this.image,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Color(0xFF790679),
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: onSkip,
                  child: Text("Skip", style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 30),
              Text(
                title,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        Image.asset(image, width: 250),
      ],
    );
  }
}

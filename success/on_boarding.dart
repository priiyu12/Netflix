import 'package:flutter/material.dart';
import 'package:showbox1/screens/sign_in.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: 4, // Number of slides
            itemBuilder: (context, index) {
              return _buildSlide(index);
            },
          ),
          // Top Buttons (Right Aligned)
          Positioned(
            top: 30.0,
            right: 20.0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle Privacy button press
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text('Privacy', style: TextStyle(fontSize: 12.0)),
                ),
                const SizedBox(width: 5.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const SignInScreen()),
                    );
                    // Handle Sign In button press
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text('Sign In', style: TextStyle(fontSize: 12.0)),
                ),
                const SizedBox(width: 5.0),
                PopupMenuButton(
                  offset: Offset(0, 40), // adjust the offset to move the menu down
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 0, color: Colors.grey),
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text('FAQs'),
                      value: 'FAQs',
                    ),
                    PopupMenuItem(
                      child: Text('Help'),
                      value: 'Help',
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'FAQs') {
                      // Handle FAQs button press
                    } else if (value == 'Help') {
                      // Handle Help button press
                    }
                  },
                  icon: Theme(
                    data: Theme.of(context).copyWith(
                      iconTheme: IconThemeData(color: Colors.white),
                    ),
                  child: Icon(Icons.menu, size: 18.0),
                ),
                ),
              ],
            ),
          ),
          // Top Left Logo
          Positioned(
            top: 20.0,
            left: 10.0,
            child: Image.asset(
              'assets/logo.png', // Replace with your logo image path
              height: 67.0,
            ),
          ),
          // Bottom Button and Page Indicator
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Page Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        height: 20.0,
                        width: 10.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? Colors.red
                              : Colors.grey[300],
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Get Started button press
                      if (_currentPage < 3) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // Navigate to the next screen
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 150.0, vertical: 15.0),
                      textStyle: const TextStyle(fontSize: 18.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                    ),
                    child: const Text('Get Started',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlide(int index) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpg'), // Replace with your image path
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Slide content based on index
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child:
            Text(
              _getSlideText1(index),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            _getSlideText2(index),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
              color: Colors.white70,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  String _getSlideText1(int index) {
    switch (index) {
      case 0:
        return 'Unlimited Entertainment';
      case 1:
        return 'Download & \nWatch Offline';
      case 2:
        return 'Create \nMultiple Profiles';
      case 3:
        return 'Watch \nEverywhere';
      default:
        return '';
    }
  }

  String _getSlideText2(int index) {
    switch (index) {
      case 0:
        return 'Everything on ShowBox.';
      case 1:
        return 'Always have something to Watch.';
      case 2:
        return 'One app, many profiles. \nEveryone gets their own.';
      case 3:
        return 'Stream on your Phone,Tablet,\nLaptop,TV and more.';
      default:
        return '';
    }
  }
}
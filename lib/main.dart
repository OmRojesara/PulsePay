import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login_screen.dart';

void main() {
  runApp(const PulsePayApp());
}

class PulsePayApp extends StatelessWidget {
  const PulsePayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PulsePay',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6B46C1)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _logoRotationAnimation;
  late Animation<double> _textSlideAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _taglineSlideAnimation;
  late Animation<double> _taglineOpacityAnimation;
  late Animation<double> _taglineFadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Single animation controller for all animations
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // Logo animations - starts immediately
    _logoScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.4, curve: Curves.elasticOut),
    ));

    _logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
    ));

    _logoRotationAnimation = Tween<double>(
      begin: -0.2,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
    ));

    // Text animations - starts after logo
    _textSlideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.3, 0.7, curve: Curves.easeOutCubic),
    ));

    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.3, 0.6, curve: Curves.easeOut),
    ));

    // Tagline animations - starts after text
    _taglineSlideAnimation = Tween<double>(
      begin: 30.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.5, 0.9, curve: Curves.easeOutCubic),
    ));

    _taglineOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.5, 0.8, curve: Curves.easeOut),
    ));

    _taglineFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeInOut),
    ));

         // Start the main animation
     _mainController.forward();
     
     // Navigate to login screen after animations complete
     Future.delayed(const Duration(milliseconds: 3000), () {
       if (mounted) {
         Navigator.of(context).pushReplacement(
           MaterialPageRoute(builder: (context) => const LoginScreen()),
         );
       }
     });
   }

  @override
  void dispose() {
    _mainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light gray background

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
                     children: [
             // Logo with animations
            AnimatedBuilder(
              animation: _mainController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _logoScaleAnimation.value,
                  child: Transform.rotate(
                    angle: _logoRotationAnimation.value,
                    child: Opacity(
                      opacity: _logoOpacityAnimation.value,
                      child: SvgPicture.asset(
                        'assets/pulsepay.svg',
                        width: 70,
                        height: 70,
                      ),
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 20),
            
            // App name with animations
            AnimatedBuilder(
              animation: _mainController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _textSlideAnimation.value),
                  child: Opacity(
                    opacity: _textOpacityAnimation.value,
                    child: Text(
  'Pulse Pay',
  style: GoogleFonts.varelaRound(
    fontSize: 42,
    fontWeight: FontWeight.w400, // regular but smooth
    color: const Color(0xFF2C2C2C), // Dark gray
    letterSpacing: 0.5,
    height: 1.2,
    shadows: [
      Shadow(
        color: Colors.black.withOpacity(0.08),
        offset: const Offset(0, 2),
        blurRadius: 4,
      ),
    ],
  ),
),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 230),
            
            // Tagline with animations
            AnimatedBuilder(
              animation: _mainController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _taglineSlideAnimation.value),
                  child: Opacity(
                    opacity: _taglineOpacityAnimation.value * _taglineFadeAnimation.value,
                    child: Text(
                      'Every Transaction, Instantly Noted!',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF666666), // Medium gray
                        letterSpacing: 0.3,
                        height: 1.4,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
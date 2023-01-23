import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/screens/onboding/components/animated_btn.dart';
import 'package:rive_animation/screens/onboding/components/custom_sign_in_dialog.dart';
import 'package:rive_animation/screens/onboding/components/sign_in_form.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isSignInDialogShow = false;
  late RiveAnimationController _btnAnimationController;
  @override
  void initState() {
    _btnAnimationController = OneShotAnimation('active', autoplay: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Positioned(
              // height: 100,
              width: size.width * 1.7,
              bottom: 200,
              left: 100,
              child: Image.asset("assets/Backgrounds/Spline.png")),
          Positioned.fill(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10))),
          const RiveAnimation.asset('assets/RiveAssets/shapes.riv'),
          Positioned.fill(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30), child: Container())),
          AnimatedPositioned(
            top: isSignInDialogShow ? -50 : 0,
            duration: const Duration(milliseconds: 240),
            height: size.height,
            width: size.width,
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  SizedBox(
                    width: 260,
                    child: Column(
                      children: const [
                        Text(
                          "Learn desing & code",
                          style: TextStyle(
                            fontSize: 60,
                            fontFamily: 'Poppins',
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Dont't skip desing. Learn design and code, by building real apps with Flutter and Swift. Complete courses about the best tools.",
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                  AnimatedBtn(
                      btnAnimationController: _btnAnimationController,
                      press: () {
                        _btnAnimationController.isActive = true;
                        Future.delayed(
                          const Duration(milliseconds: 800),
                          () {
                            setState(() {
                              isSignInDialogShow = true;
                            });
                            customSigninDialog(
                              context,
                              onClosed: (value) {
                                setState(() {
                                  isSignInDialogShow = false;
                                });
                              },
                            );
                          },
                        );
                      }),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text("Purchase includes access to 30+ courses, 240+ premium turaeials, 120+ hours of videos, source files and certificates."),
                  )
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}

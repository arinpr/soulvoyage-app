import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Image.asset('assets/Images/secondTitle.png', height: size.height * 0.15,),
        SizedBox(height: size.height *0.04,),
        // SvgPicture.asset('assets/Images/second.svg',),
        Image.asset('assets/Images/secondImage.png'),
         SizedBox(height: size.height *0.05,),
        SvgPicture.asset('assets/Images/headingOne.svg'),
        SizedBox(height: size.height *0.05,),
        SvgPicture.asset('assets/Images/headingTwo.svg'),
      ],
    );
  }
}
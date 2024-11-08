import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class ScreenThree extends StatelessWidget {
  const ScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
         SvgPicture.asset('assets/Images/thirdtitle.svg'),
         const Text('The possibilities are beyond your imagination'),

        SizedBox(height: size.height *0.04,),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: const Text('AI-based journaling analytics involves using artificial intelligence techniques to analyze and derive insights from the content of journals or personal diaries.'),
        ),
         SizedBox(height: size.height *0.03,),
        SvgPicture.asset('assets/Images/textRow.svg'),
        SizedBox(height: size.height *0.03,),
        Image.asset('assets/Images/lastScrren.png'),
      ],
    );
  }
}
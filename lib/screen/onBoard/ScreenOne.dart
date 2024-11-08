import 'package:flutter/material.dart';
import 'package:soulvoyage/component/constatnt.dart';


class Screenone extends StatelessWidget {
  const Screenone({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Image.asset('assets/Images/title.png', height: size.height * 0.15,),
        SizedBox(height: size.height *0.04,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: size.height * 0.06),
          
          decoration: BoxDecoration(
            color: kPageColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Image.asset("assets/Images/scnone.png"),
        ),
         SizedBox(height: size.height *0.04,),
         const Padding(
           padding:  EdgeInsets.symmetric(horizontal: 15),
           child:  Text('This fusion of AI and journaling aims to provide users with various tools, features, or systems that assist in organizing thoughts, generating insights, providing professional help, or offering personalized prompts for journal entries.',
           textAlign: TextAlign.center,
           ),
         )
        // SvgPicture.asset('assets/Images/scnonetitle.svg', height: size.height * 0.15,),
      ],
    );
  }
}
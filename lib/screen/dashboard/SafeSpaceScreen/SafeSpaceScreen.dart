import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:soulvoyage/component/constatnt.dart';
import 'package:soulvoyage/component/dashboardButton.dart';
import 'package:soulvoyage/component/toast.dart';
import 'package:soulvoyage/helper/SafeSpace.dart';
import 'package:toastification/toastification.dart';

class SafeSpaceScreen extends StatefulWidget {
  const SafeSpaceScreen({super.key});

  @override
  _SafeSpaceScreenState createState() => _SafeSpaceScreenState();
}

class _SafeSpaceScreenState extends State<SafeSpaceScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  bool loadingBtn = false;

  final List<TextEditingController> ansControllers = [];
  final List<FocusNode> focusNodes = [];
  final List<bool> isFieldEmpty = [];

  final List<String> questions = [
    "1. What makes you feel safe?",
    "2. Are there places where you feel safe? Describe below.",
    "3. Briefly describe your ideal safe place...",
    "4. What sensations do you feel in your safe place?",
    "5. Describe the outside noise effect...",
    "6. Write a paragraph about how you feel..."
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < questions.length; i++) {
      ansControllers.add(TextEditingController());
      focusNodes.add(FocusNode());
      isFieldEmpty.add(false);
    }
  }

  @override
  void dispose() {
    for (var controller in ansControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void checkFieldsAndSubmit() async {
    bool anyFieldEmpty = false;
    int firstEmptyIndex = -1;

    for (int i = 0; i < ansControllers.length; i++) {
      if (ansControllers[i].text.isEmpty) {
        setState(() {
          isFieldEmpty[i] = true;
        });
        if (firstEmptyIndex == -1) {
          firstEmptyIndex = i; // Mark the first empty field's index
          focusNodes[i].requestFocus();
          anyFieldEmpty = true;
        }
      } else {
        setState(() {
          isFieldEmpty[i] = false;
        });
      }
    }

    if (anyFieldEmpty) {
      if (firstEmptyIndex != -1) {
        _pageController.animateToPage(
          firstEmptyIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
      showCustomToast(title: 'Please fill all the details', type: ToastificationType.error);
      
    } else {
      if(!loadingBtn){

      if (mounted) {
          setState(() {
            loadingBtn = true;
          });
        }

      await Future.delayed(const Duration(seconds: 1));
      const String title = "Safe Space Journaling template";
      SafeSpace(
        title: title,
        entry1: ansControllers[0],
        entry2: ansControllers[1],
        entry3: ansControllers[2],
        entry4: ansControllers[3],
        entry5: ansControllers[4],
        entry6: ansControllers[5],
      ).safeSpaceEntry();

      await Future.delayed(const Duration(seconds: 5));
      if (mounted) {
          setState(() {
            loadingBtn = false;
          });
        }
        // for (var controller in ansControllers) {
        //   controller.clear();
        // }
      }else{
        return null;
      }

      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return Questions(
                    questionText: questions[index],
                    ansController: ansControllers[index],
                    focusNode: focusNodes[index],
                    isFieldEmpty: isFieldEmpty[index],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: questions.length,
                effect: const ExpandingDotsEffect(
                  activeDotColor: kButton,
                  dotHeight: 8,
                  dotWidth: 8,
                  expansionFactor: 4,
                  spacing: 8,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DashboardButton(
                name: !loadingBtn
                    ? const Text("SUBMIT", style: TextStyle(fontSize: 22))
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("LOADING...", style: TextStyle(fontSize: 22)),
                          SizedBox(width: 10),
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(color: Colors.white),
                          )
                        ],
                      ),
                onPressed: checkFieldsAndSubmit,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class Questions extends StatelessWidget {
  final String questionText;
  final TextEditingController ansController;
  final FocusNode focusNode;
  final bool isFieldEmpty;

  const Questions({
    super.key,
    required this.questionText,
    required this.ansController,
    required this.focusNode,
    required this.isFieldEmpty,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 10,
            spreadRadius: 2,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: kQuestion,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9),
                topRight: Radius.circular(9),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                questionText,
                style: const TextStyle(fontSize: 18, color: Colors.white),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: ansController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Write here...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isFieldEmpty ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

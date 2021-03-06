import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import 'question_five_screen.dart';
import 'question_four_screen.dart';
import 'question_one_screen.dart';
import 'question_three_screen..dart';
import 'question_two_screen.dart';
import 'question_zero_screen.dart';

class QuestionIndex {
  QuestionIndex._();
  static const int QUESTION_ZERO = 0;
  static const int QUESTION_ONE = 1;
  static const int QUESTION_TWO = 2;
  static const int QUESTION_THREE = 3;
  static const int QUESTION_FOUR = 4;
  static const int QUESTION_FIVE = 5;
}

class QuestionsScreen extends StatefulWidget {
  QuestionsScreen({Key key}) : super(key: key);

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
  }

  void _switchForm(int page) {
    _pageController.animateToPage(page, duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
  }
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: <Widget>[
        QuestionZeroScreen(
          onGoToNextQuestion: () {
            _switchForm(QuestionIndex.QUESTION_ONE);
          },
        ),
        QuestionOneScreen(
          onGoToBackQuestion: () {
            _switchForm(QuestionIndex.QUESTION_ZERO);
          },
          onGoToNextQuestion: () {
            _switchForm(QuestionIndex.QUESTION_TWO);
          },
        ),
        QuestionTwoScreen(
          onGoToBackQuestion: () {
            _switchForm(QuestionIndex.QUESTION_ONE);
          },
          onGoToNextQuestion: () {
            _switchForm(QuestionIndex.QUESTION_THREE);
          },
        ),
        QuestionThreeScreen(
          onGoToBackQuestion: () {
            _switchForm(QuestionIndex.QUESTION_TWO);
          },
          onGoToNextQuestion: () {
            _switchForm(QuestionIndex.QUESTION_FOUR);
          },
        ),
        QuestionFourScreen(
          onGoToBackQuestion: () {
            _switchForm(QuestionIndex.QUESTION_THREE);
          },
          onGoToNextQuestion: () {
            _switchForm(QuestionIndex.QUESTION_FIVE);
          },
        ),
        QuestionFiveScreen(
          onGoToBackQuestion: () {
            _switchForm(QuestionIndex.QUESTION_FOUR);
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

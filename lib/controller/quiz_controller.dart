import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quiz_app/models/Questions.dart';
import 'package:quiz_app/screens/score_screen.dart';


class QuestionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Lets animated our progress bar

  late AnimationController _animationController;
  late Animation _animation;
  // so that we can access our animation outside
  Animation get animation => _animation;

  late PageController _pageController;
  PageController get pageController => _pageController;

  final List<Question> _questions = sample_data
      .map(
        (question) => Question(
        id: question['id'],
        question: question['question'],
        options: question['options'],
        answer: question['answer_index']),
  )
      .toList();
  List<Question> get questions => _questions;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;



  late int _selectedAns;
  int get selectedAns => this._selectedAns;

  // for more about obs please check documentation
  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;
  late int _id;
  final int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;
  int  _Worryscore = 0;
  int get Worryscore => _Worryscore;
  int _CScore = 0;
  int get CScore => _CScore;
  int _Sscore = 0;
  int get Sscore  => _Sscore;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    // Our animation duration is 60 s
    // so our plan is to fill the progress bar within 60s
    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        // update like setState
        update();
      });

    // start our animation
    // Once 60s is completed go to the next qn
    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    // because once user press any option then it will run
    _isAnswered = true;
    _selectedAns = selectedIndex;
    _id=question.id;

    if (_id==3 || _id==5 || _id==9 || _id==10 || _id==13 || _id==16 || _id==18){
      if(_selectedAns==0){
          _Worryscore++;
      }
      else if(_selectedAns==1){
        _Worryscore=_Worryscore+2;
      }
      else if(_selectedAns==2){
        _Worryscore=_Worryscore+3;
      }
      else if(_selectedAns==3){
        _Worryscore=_Worryscore+4;
      }
    }
    else if(_id==2 || _id==6 || _id==7 || _id==14 || _id==13 || _id==16 || _id==20){
      if(_selectedAns==0){
        _CScore++;
      }
      else if(_selectedAns==1){
        _CScore=_CScore+2;
      }
      else if(_selectedAns==2){
        _CScore=_CScore+3;
      }
      else if(_selectedAns==3){
        _CScore=_CScore+4;
      }
    }
    else if(_id==1 || _id==4 || _id==8 || _id==11 || _id==12 || _id==15 || _id==17 || _id==19 || _id==21){
      if(_selectedAns==0){
        _Sscore++;
      }
      else if(_selectedAns==1){
        _Sscore=_Sscore+2;
      }
      else if(_selectedAns==2){
        _Sscore=_Sscore+3;
      }
      else if(_selectedAns==3){
        _Sscore=_Sscore+4;
      }
    }


    // It will stop the counter
    _animationController.stop();
    update();

    // Once user select an ans after 3s it will go to the next qn
    Future.delayed(const Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      _animationController.reset();

      // Then start it again
      // Once timer is finish go to the next qn
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      // Get package provide us simple way to naviigate another page
      Get.to(()=>ScoreScreen(_Worryscore,_CScore,_Sscore));
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
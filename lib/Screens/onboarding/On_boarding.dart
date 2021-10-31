import 'package:flutter/material.dart';
import 'package:shop_app/Network/sharedPerference/sharedPerference.dart';
import 'package:shop_app/Screens/loginScreen/login.dart';
import 'package:shop_app/const/const.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class OnBoard {
  final String image;
  final String title;
  final String body;

  OnBoard({
   required this.image,
    required this.title,
    required this.body,
  });
}




class OnBoarding extends StatefulWidget {

  @override
  _OnBoardingState createState() => _OnBoardingState();
}
class _OnBoardingState extends State<OnBoarding> {

  List <OnBoard> boardList = [
    OnBoard(
      image: 'assets/ob1.png' ,
      title: 'Order From Desk' ,
      body:  'you can make order now online' ,
    ),
    OnBoard(
      image: 'assets/ob2.png' ,
      title: 'now , pay Online Easily now ' ,
      body:  'you can pay now online' ,
    ),
    OnBoard(
      image: 'assets/ob4.png' ,
      title: ' contact us' ,
      body:  'you can contact us from any where,time' ,
    ),
  ];
   var boarderController =PageController();
    bool isLast = false ;

     void submit()
     {
       CashHelper.saveData(key: 'OnBoarding', value: true).then((value){
         if(value)
           {
             navigateToPushReplacement(context,LoginScreen());
           }
       });
     }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: Text('Skip', style: TextStyle(
              color: defaultColor,
              fontWeight: FontWeight.bold,
            ),),
            onPressed: ()
            {
              submit();
            },

          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boarderController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => onBoarding(boardList[index]),
                itemCount: 3,
                onPageChanged: (index)
                {
                  if(index==boardList.length - 1)
                    {
                     setState(() {
                       isLast = true;
                     });
                    }
                  else
                  {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
          SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boarderController,
                    count: boardList.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotHeight: 12,
                    expansionFactor:4,
                    dotColor: darkColor,
                    spacing: 10,

                  ) ,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    setState(() {
                      isLast? submit() :
                      boarderController.nextPage(duration: Duration(seconds:2), curve: Curves.fastOutSlowIn  );
                    });
                  },
                  child: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget onBoarding(OnBoard model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image.asset(
          model.image,
          )),
          SizedBox(
            height:40,
          ),
          Center(
            child: Text(
              model.title,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Text(
              model.body,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      );
}

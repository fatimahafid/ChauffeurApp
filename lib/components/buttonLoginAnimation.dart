import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ButtonLoginAnimation extends StatefulWidget {

  final String label;
  final Color background;
  final Color borderColor;
  final Color fontColor;
  final Function onTap;
  final Widget child;

  const ButtonLoginAnimation({Key key, this.label, this.background, this.borderColor, this.fontColor, this.onTap, this.child}) : super(key: key);

  @override
  _ButtonLoginAnimationState createState() => _ButtonLoginAnimationState();
}

class _ButtonLoginAnimationState extends State<ButtonLoginAnimation>
with TickerProviderStateMixin {

  AnimationController _positionController;
  Animation<double> _positionAnimation;

  AnimationController _scaleController;
  Animation<double> _scaleAnimation;

  bool _isLogin = false;
  bool _isIconHide = false;

  @override
  void initState() {
    super.initState();

    _positionController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800)
    );

    _positionAnimation = Tween<double>(begin: 10.0, end: 255.0)
    .animate(_positionController)..addStatusListener((status){
      if(status == AnimationStatus.completed){
        setState(() {
         _isIconHide = true; 
        });
        _scaleController.forward();
      }
    });

    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900)
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 32)
    .animate(_scaleController)..addStatusListener((status){
      if(status == AnimationStatus.completed){
        Navigator.pushReplacement(context, PageTransition(
          type: PageTransitionType.fade,
          child: widget.child
        ));
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          setState(() {
           _isLogin = true; 
          });
          _positionController.forward();
        },
        child: Container(
          height: 63,
          width: double.infinity,
          decoration: BoxDecoration(
            color: widget.background,
            borderRadius: BorderRadius.circular(25),
          ),
          child: !_isLogin ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left:80,right: 20),
                child: Text(widget.label, style: TextStyle(
                  color: widget.fontColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,


                )),
              ),
              SizedBox(width: 0),
              Container(
                //width: 50.0,
                //height: 50.0,
                margin: EdgeInsets.only(right: 20),
                padding: const EdgeInsets.all(2.0),//I used some padding without fixed width and height
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,// You can use like this way or like the below line
                  //borderRadius: new BorderRadius.circular(30.0),
                  color: Colors.white,
                ),
                  child:Icon(Icons.arrow_forward, color: Color(0xffe6b301),size: 28)
              ),//............
            ],
          ) : Stack(
            children: <Widget>[
              AnimatedBuilder(
                animation: _positionController,
                builder: (context, child) => Positioned(
                  left: _positionAnimation.value,
                  top: 5,
                  child: AnimatedBuilder(
                    animation: _scaleController,
                    builder: (context,build) => Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,// You can use like this way or like the below line
                        //borderRadius: new BorderRadius.circular(30.0),
                        color: Colors.white,
                      ),
                      child: !_isIconHide ?Icon(Icons.arrow_forward, color: Color(0xffe6b301),size: 28)
                        : Container(),
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}
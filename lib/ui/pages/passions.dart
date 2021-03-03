import 'package:auto_size_text/auto_size_text.dart';
import 'package:beunique/core/providers/passionsProvider.dart';
import 'package:beunique/ui/pages/profile.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class Passions extends StatefulWidget {
  @override
  _PassionsState createState() => _PassionsState();
}

class _PassionsState extends State<Passions> with TickerProviderStateMixin {
  //scroll bar controller
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    // setup the controller
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // get the interests from the provider
      Provider.of<PassionsProvider>(context, listen: false).getData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    //  set the screen based on the sized of the device on the XD file
    ResponsiveWidgets.init(
      context,
      height: 736,
      width: 414,
      allowFontScaling: true,
    );
    return ResponsiveWidgets.builder(
      height: 736,
      width: 414,
      allowFontScaling: true,
      child: Scaffold(
        body: ConnectivityWidgetWrapper(
          child: ContainerResponsive(
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.fill,
              //  screen background
              image: AssetImage(
                'assets/images/passionsBackground.png',
              ),
            )),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        //appbar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                            AutoSizeText(
                              'PASSIONS',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(15),
                                  fontFamily: 'helvetica',
                                  fontWeight: FontWeight.w500),
                            ),
                            ContainerResponsive(
                              width: 50,
                            )
                          ],
                        ),
                        SizedBoxResponsive(
                          height: 60,
                        ),
                        AutoSizeText(
                          'What are you into?',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(32),
                              fontFamily: 'helvetica',
                              fontWeight: FontWeight.w100),
                        ),
                        SizedBoxResponsive(
                          height: 22,
                        ),
                        AutoSizeText(
                          'Pick at least 5',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(14),
                            fontFamily: 'helvetica',
                          ),
                        ),
                        //interests widget
                        Consumer<PassionsProvider>(
                            builder: (context, provider, child) {
                          //data have been pulled
                          return SizedBoxResponsive(
                            height: 500,
                            width: 500,
                            child: Scrollbar(
                              isAlwaysShown: true,
                              controller: _scrollController,
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                child: !provider.isLoading
                                    ? provider.passions.interests == null ||
                                            provider.passions.interests.isEmpty
                                        ? Container(
                                            width: width,
                                            height: 280.h,
                                            child: Center(
                                              child: AutoSizeText(
                                                'No Information Avilable',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        ScreenUtil().setSp(14),
                                                    fontFamily: 'helvetica',
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          )
                                        : SizedBoxResponsive(
                                            height: 500,
                                            width: provider
                                                    .passions.interests.length *
                                                45.0,
                                            child: Stack(
                                              children: provider
                                                  .passions.interests
                                                  .map((myInterest) {
                                                //find index of current interest
                                                int index = provider
                                                    .passions.interests
                                                    .indexOf(myInterest);
                                                // go throw all the interest, filter the index and inesrt it to the algorithim blow to
                                                // keep the spaces and the sizes as in the XD
                                                return index == 0 ||
                                                        index == 11 + 1 ||
                                                        index == 23 + 1
                                                    ? interest(myInterest.name,
                                                        10.0, 40.0, 64, index)
                                                    : index == 1 ||
                                                            index == 11 + 2 ||
                                                            index == 23 + 2
                                                        ? interest(
                                                            myInterest.name,
                                                            20.0,
                                                            180.0,
                                                            104,
                                                            index)
                                                        : index == 2 ||
                                                                index ==
                                                                    11 + 3 ||
                                                                index == 23 + 3
                                                            ? interest(
                                                                myInterest.name,
                                                                0.0,
                                                                340.0,
                                                                103,
                                                                index)
                                                            : index == 3 ||
                                                                    index ==
                                                                        11 +
                                                                            4 ||
                                                                    index ==
                                                                        23 + 4
                                                                ? interest(
                                                                    myInterest
                                                                        .name,
                                                                    100.0,
                                                                    20.0,
                                                                    110,
                                                                    index)
                                                                : index == 4 ||
                                                                        index ==
                                                                            11 +
                                                                                5 ||
                                                                        index ==
                                                                            23 +
                                                                                5
                                                                    ? interest(
                                                                        myInterest
                                                                            .name,
                                                                        140.0,
                                                                        200.0,
                                                                        96,
                                                                        index)
                                                                    : index == 5 ||
                                                                            index ==
                                                                                11 +
                                                                                    6 ||
                                                                            index ==
                                                                                23 +
                                                                                    6
                                                                        ? interest(
                                                                            myInterest
                                                                                .name,
                                                                            110.0,
                                                                            360.0,
                                                                            111,
                                                                            index)
                                                                        : index == 6 ||
                                                                                index == 11 + 7 ||
                                                                                index == 23 + 7
                                                                            ? interest(myInterest.name, 240.0, 30.0, 64, index)
                                                                            : index == 7 || index == 11 + 8 || index == 23 + 8
                                                                                ? interest(myInterest.name, 250.0, 150.0, 92, index)
                                                                                : index == 8 || index == 11 + 9 || index == 23 + 9
                                                                                    ? interest(myInterest.name, 240.0, 320.0, 136, index)
                                                                                    : index == 9 || index == 11 + 10 || index == 23 + 10
                                                                                        ? interest(myInterest.name, 320.0, 60.0, 90, index)
                                                                                        : index == 10 || index == 11 + 11 || index == 23 + 11
                                                                                            ? interest(myInterest.name, 370.0, 186.0, 64, index)
                                                                                            : index == 11 || index == 11 + 12 || index == 23 + 12
                                                                                                ? interest(myInterest.name, 380.0, 306.0, 98, index)
                                                                                                : interest(myInterest.name, 200.0, 300.0, 111, index);
                                              }).toList(),
                                            ),
                                          )
                                    : SizedBoxResponsive(
                                        height: 500,
                                        width: width,
                                        child: Stack(children: [
                                          loadingInterest(24.0.w, 33.0.h),
                                          loadingInterest(155.0.w, 0.0.h),
                                          loadingInterest(242.0.w, 242.0.h),
                                          loadingInterest(0.0.w, 181.0.h),
                                          loadingInterest(256.0.w, 94.0.h),
                                          loadingInterest(131.0.w, 152.0.h),
                                          loadingInterest(107.0.w, 304.0.h)
                                        ]),
                                      ),
                              ),
                            ),
                          );
                          //still trying to pull data
                        }),
                      ],
                    ),
                    //to profile
                    FlatButton(
                      child: ContainerResponsive(
                        margin: EdgeInsetsResponsive.only(bottom: 54, top: 20),
                        height: 53,
                        width: 320.81,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xff4B6FFF), Color(0xff0226B2)],
                              begin: const FractionalOffset(0.2, 0.0),
                              end: const FractionalOffset(0.7, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          'CONTINUE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(14),
                              fontFamily: 'helvetica',
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, _, __) {
                                return Profile();
                              }),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

//intrest circle
  Positioned interest(text, x, y, size, index) {
    AnimationController controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            }
          });
    bool isSelected = Provider.of<PassionsProvider>(context, listen: true)
        .savedpassions
        .contains(text);
    return Positioned(
      left: ScreenUtil().setSp(x),
      top: ScreenUtil().setSp(y),
      child: GestureDetector(
        onTap: () {
          Provider.of<PassionsProvider>(context, listen: false)
              .addToPassions(index);
        },
        child: AnimatedBuilder(
          animation: offsetAnimation,
          builder: (buildContext, child) {
            if (offsetAnimation.value < 0.0)
              print('${offsetAnimation.value + 8.0}');
            return ClipRRect(
              borderRadius: new BorderRadius.all(
                Radius.circular(360),
              ),
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                width: ScreenUtil().setSp(size) * 1.0,
                height: ScreenUtil().setSp(size) * 1.0,
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [Color(0xff4B6FFF), Color(0xff0226B2)],
                          begin: const FractionalOffset(0.5, 0.5),
                          end: const FractionalOffset(0.5, 0.9),
                          tileMode: TileMode.clamp)
                      : LinearGradient(
                          colors: [Color(0xff495896), Color(0xff495896)],
                          begin: const FractionalOffset(0.5, 0.5),
                          end: const FractionalOffset(0.5, 0.9),
                          tileMode: TileMode.clamp),
                ),
                child: AutoSizeText(
                  text,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(17),
                      fontFamily: 'helvetica',
                      fontWeight: FontWeight.w100),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Positioned loadingInterest(x, y) {
    return Positioned(
      left: x,
      top: y,
      child: ClipRRect(
        borderRadius: new BorderRadius.all(
          Radius.circular(360),
        ),
        child: Container(
            width: 133,
            height: 133,
            alignment: Alignment.center,
            decoration:
                BoxDecoration(color: Color(0xff495896).withOpacity(0.4)),
            child: CircularProgressIndicator()),
      ),
    );
  }
}

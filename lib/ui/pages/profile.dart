import 'package:auto_size_text/auto_size_text.dart';
import 'package:beunique/ui/widgets/imageFullScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:beunique/core/providers/profileProvider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    //set the url to the controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // get the interests from the provider
      Provider.of<ProfileProvider>(context, listen: false).getData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    //  current screen width
    var width = MediaQuery.of(context).size.width;
//  set the screen based on the sized of the device on the XD file
    ResponsiveWidgets.init(
      context,
      height: 812.0,
      width: 375.0,
      allowFontScaling: true,
    );
    return ResponsiveWidgets.builder(
      height: 812.0,
      width: 375.0,
      allowFontScaling: true,
      child: Scaffold(
        body: ConnectivityWidgetWrapper(
          child: ContainerResponsive(
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.fill,
              // background image
              image: AssetImage(
                'assets/images/passionsBackground.png',
              ),
            )),
            child:
                //data have been pulled
                ListView(
              children: <Widget>[
                !Provider.of<ProfileProvider>(context, listen: true).isLoading
                    ?

                    //the header
                    Stack(
                        children: [
                          //the header media
                          Provider.of<ProfileProvider>(context, listen: false)
                                          .imageSliders !=
                                      null &&
                                  Provider.of<ProfileProvider>(context,
                                          listen: false)
                                      .imageSliders
                                      .isNotEmpty
                              ? Consumer<ProfileProvider>(
                                  builder: (context, provider, child) {
                                  return CarouselSlider(
                                    items: provider.imageSliders,
                                    options: CarouselOptions(
                                        scrollDirection: Axis.horizontal,
                                        aspectRatio: width / 480.h,
                                        viewportFraction: 1,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            provider.current = index;
                                          });
                                        }),
                                  );
                                })
                              : Container(
                                  width: width,
                                  height: 480.h,
                                  child: Center(
                                    child: AutoSizeText(
                                      ' No Media Avilable Right Now ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(16),
                                          fontFamily: 'helvetica',
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                          // to passions screen
                          Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          //fav button
                          Positioned(
                            right: 28.w,
                            bottom: 192.h,
                            child: ClipRRect(
                              borderRadius: new BorderRadius.all(
                                Radius.circular(360),
                              ),
                              child: Container(
                                width: 49,
                                height: 49,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xff0032FF).withOpacity(0.3),
                                        Color(0xff0032FF).withOpacity(0.7)
                                      ],
                                      begin: const FractionalOffset(0.0, 0.9),
                                      end: const FractionalOffset(0.0, 0.4),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Provider.of<ProfileProvider>(context,
                                                listen: true)
                                            .liked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => Provider.of<ProfileProvider>(
                                          context,
                                          listen: false)
                                      .like(),
                                ),
                              ),
                            ),
                          ),
                          //dislike button
                          Positioned(
                            right: 28.w,
                            bottom: 120.h,
                            child: ClipRRect(
                              borderRadius: new BorderRadius.all(
                                Radius.circular(360),
                              ),
                              child: Container(
                                width: 49,
                                height: 49,
                                padding: EdgeInsetsResponsive.all(12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xff0032FF).withOpacity(0.3),
                                        Color(0xff0032FF).withOpacity(0.7)
                                      ],
                                      begin: const FractionalOffset(0.0, 0.9),
                                      end: const FractionalOffset(0.0, 0.4),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/dislike.svg',
                                  color: Colors.white,
                                  height: 22.h,
                                  width: 22.w,
                                ),
                              ),
                            ),
                          ),
                          //header indicator
                          Provider.of<ProfileProvider>(context, listen: false)
                                          .imageSliders !=
                                      null &&
                                  Provider.of<ProfileProvider>(context,
                                          listen: false)
                                      .imageSliders
                                      .isNotEmpty
                              ? Positioned(
                                  right: (width / 2 -
                                          (8 *
                                              Provider.of<ProfileProvider>(
                                                      context,
                                                      listen: false)
                                                  .imageSliders
                                                  .length))
                                      .w,
                                  bottom: (68).h,
                                  child: Consumer<ProfileProvider>(
                                      builder: (context, provider, child) {
                                    List<String> myList = provider.myHeaderList;

                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: myList.map((url) {
                                        int index = myList.indexOf(url);
                                        return ContainerResponsive(
                                          padding: EdgeInsetsResponsive.all(8),
                                          margin: EdgeInsetsResponsive.all(4),
                                          width: 5,
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: provider.current == index
                                                ? Colors.white
                                                : Colors.grey[600],
                                            border: Border.all(
                                                color: provider.current == index
                                                    ? Colors.white
                                                    : Colors.grey[600],
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(360),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  }),
                                )
                              : Container(),
                        ],
                      )
                    : Container(
                        width: width,
                        height: 480.h,
                        child: Stack(
                          children: [
                            // to passions screen
                            Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: IconButton(
                                icon:
                                    Icon(Icons.arrow_back, color: Colors.white),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            Center(child: CircularProgressIndicator()),
                          ],
                        )),
                SizedBoxResponsive(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBoxResponsive(
                      width: 40,
                    ),
                    Consumer<ProfileProvider>(
                        builder: (context, provider, child) {
                      return AutoSizeText(
                        !Provider.of<ProfileProvider>(context, listen: true)
                                .isLoading
                            ? provider.profile.name == null
                                ? "unkown"
                                : '${provider.profile.name}, ${provider.profile.age}'
                            : "Name",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(16),
                            fontFamily: 'helvetica',
                            fontWeight: FontWeight.w300),
                      );
                    }),
                  ],
                ),
                SizedBoxResponsive(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBoxResponsive(
                      width: 40,
                    ),
                    Consumer<ProfileProvider>(
                        builder: (context, provider, child) {
                      return AutoSizeText(
                        !Provider.of<ProfileProvider>(context, listen: true)
                                .isLoading
                            ? provider.profile?.bio ?? "no bio"
                            : 'BIO',
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(14),
                          fontFamily: 'helvetica',
                        ),
                      );
                    }),
                  ],
                ),
                SizedBoxResponsive(
                  height: 23,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBoxResponsive(
                      width: 40,
                    ),
                    AutoSizeText(
                      'Basic Info',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(16),
                          fontFamily: 'helvetica',
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                SizedBoxResponsive(
                  height: 22,
                ),
                Padding(
                  padding: EdgeInsetsResponsive.only(right: 36, left: 36),
                  child: ClipRRect(
                    borderRadius: new BorderRadius.all(
                      Radius.circular(5),
                    ),
                    child: ContainerResponsive(
                      color: Colors.white.withOpacity(0.2),
                      child: Consumer<ProfileProvider>(
                          builder: (context, provider, child) {
                        return !Provider.of<ProfileProvider>(context,
                                    listen: true)
                                .isLoading
                            ? provider.profile.interests == null ||
                                    provider.profile.interests.isEmpty
                                ? Container(
                                    width: width,
                                    height: 280.h,
                                    child: Center(
                                      child: AutoSizeText(
                                        'No Information Avilable',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(14),
                                            fontFamily: 'helvetica',
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      profileRow('Name',
                                          '${provider.profile.name}', true),
                                      profileRow('Gender',
                                          '${provider.profile.gender}', true),
                                      profileRow('Age',
                                          '${provider.profile.age}', true),
                                      !provider.isLoadingLoc
                                          ? profileRow(
                                              'Location',
                                              '${provider.placemark[0].country}, ${provider.placemark[0].locality}',
                                              false)
                                          : CircularProgressIndicator(),
                                    ],
                                  )
                            : Container(
                                width: width,
                                height: 280.h,
                                child:
                                    Center(child: CircularProgressIndicator()));
                      }),
                    ),
                  ),
                ),
                SizedBoxResponsive(
                  height: 43,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBoxResponsive(
                      width: 40,
                    ),
                    AutoSizeText(
                      'Personal Info',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(16),
                          fontFamily: 'helvetica',
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                SizedBoxResponsive(
                  height: 22,
                ),
                Padding(
                  padding: EdgeInsetsResponsive.only(right: 36, left: 36),
                  child: ClipRRect(
                    borderRadius: new BorderRadius.all(
                      Radius.circular(5),
                    ),
                    child: ContainerResponsive(
                        color: Colors.white.withOpacity(0.2),
                        child: Consumer<ProfileProvider>(
                            builder: (context, provider, child) {
                          return !Provider.of<ProfileProvider>(context,
                                      listen: true)
                                  .isLoading
                              ? provider.profile.interests == null ||
                                      provider.profile.interests.isEmpty
                                  ? Container(
                                      width: width,
                                      height: 450.h,
                                      child: Center(
                                        child: AutoSizeText(
                                          'No Information Avilable',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ScreenUtil().setSp(14),
                                              fontFamily: 'helvetica',
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: provider.profile.basicInfo
                                          .map((info) {
                                        int index = provider.profile.basicInfo
                                            .indexOf(info);
                                        return profileRow(
                                            '${info.key.name}',
                                            '${info.value}',
                                            index !=
                                                    provider.profile.basicInfo
                                                            .length -
                                                        1
                                                ? true
                                                : false);
                                      }).toList())
                              : Container(
                                  width: width,
                                  height: 450.h,
                                  child: Center(
                                      child: CircularProgressIndicator()));
                        })),
                  ),
                ),
                SizedBoxResponsive(
                  height: 43,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBoxResponsive(
                      width: 40,
                    ),
                    AutoSizeText(
                      !Provider.of<ProfileProvider>(context, listen: true)
                              .isLoading
                          ? '${Provider.of<ProfileProvider>(context, listen: true).profile.photos.length} Instagram Posts'
                          : 'Instagram Posts',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(16),
                          fontFamily: 'helvetica',
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                SizedBoxResponsive(
                  height: 23,
                ),
                ContainerResponsive(
                  width: width,
                  height: 214,
                  child: Consumer<ProfileProvider>(
                      builder: (context, provider, child) {
                    return !Provider.of<ProfileProvider>(context, listen: true)
                            .isLoading
                        ? provider.profile.interests == null ||
                                provider.profile.interests.isEmpty
                            ? Center(
                                child: AutoSizeText(
                                  'No Posts Added Yet',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(14),
                                      fontFamily: 'helvetica',
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            : GridView.builder(
                                itemCount: provider.profile.photos.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 126 / 158,
                                        crossAxisCount: 2),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                            opaque: false,
                                            pageBuilder:
                                                (BuildContext context, _, __) {
                                              return FullScreenImage(
                                                pic: provider.profile
                                                    .photos[index].filename,
                                              );
                                            }),
                                      );
                                    },
                                    child: ContainerResponsive(
                                      width: 106,
                                      height: 108,
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: provider
                                            .profile.photos[index].filename,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            new CircularProgressIndicator(
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            new Icon(Icons.error),
                                      ),
                                    ),
                                  );
                                })
                        : GridView(
                            children: [
                              Container(
                                  margin: EdgeInsets.all(5),
                                  color: Colors.white.withOpacity(0.2),
                                  child: Center(
                                      child: CircularProgressIndicator())),
                              Container(
                                  margin: EdgeInsets.all(5),
                                  color: Colors.white.withOpacity(0.2),
                                  child: Center(
                                      child: CircularProgressIndicator())),
                              Container(
                                  margin: EdgeInsets.all(5),
                                  color: Colors.white.withOpacity(0.2),
                                  child: Center(
                                      child: CircularProgressIndicator())),
                              Container(
                                  margin: EdgeInsets.all(5),
                                  color: Colors.white.withOpacity(0.2),
                                  child: Center(
                                      child: CircularProgressIndicator())),
                            ],
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 126 / 158,
                                    crossAxisCount: 2),
                          );
                  }),
                ),
                SizedBoxResponsive(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBoxResponsive(
                      width: 40,
                    ),
                    AutoSizeText(
                      'Passions',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(16),
                          fontFamily: 'helvetica',
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                SizedBoxResponsive(
                  height: 20,
                ),
                SizedBoxResponsive(
                  height: 520,
                  child: Consumer<ProfileProvider>(
                      builder: (context, provider, child) {
                    return !Provider.of<ProfileProvider>(context, listen: true)
                            .isLoading
                        ? provider.profile.interests == null ||
                                provider.profile.interests.isEmpty
                            ? Center(
                                child: AutoSizeText(
                                  'No Interests Added Yet',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(14),
                                      fontFamily: 'helvetica',
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            : Stack(
                                children:
                                    provider.profile.interests.map((interest) {
                                int index = provider.profile.interests
                                    .indexOf(interest);
                                return index == 0
                                    ? coloredInterest(
                                        interest.name, 24.0.w, 33.0.h)
                                    : index == 1
                                        ? coloredInterest(
                                            interest.name, 155.0.w, 0.0.h)
                                        : index == 2
                                            ? coloredInterest(
                                                interest.name, 242.0.w, 242.0.h)
                                            : index == 3
                                                ? nonColoredInterest(
                                                    interest.name,
                                                    0.0.w,
                                                    181.0.h)
                                                : index == 4
                                                    ? nonColoredInterest(
                                                        interest.name,
                                                        256.0.w,
                                                        94.0.h)
                                                    : index == 4
                                                        ? nonColoredInterest(
                                                            interest.name,
                                                            131.0.w,
                                                            152.0.h)
                                                        : nonColoredInterest(
                                                            interest.name,
                                                            107.0.w,
                                                            304.0.h);
                              }).toList())
                        : Stack(children: [
                            loadingInterest(24.0.w, 33.0.h),
                            loadingInterest(155.0.w, 0.0.h),
                            loadingInterest(242.0.w, 242.0.h),
                            loadingInterest(0.0.w, 181.0.h),
                            loadingInterest(256.0.w, 94.0.h),
                            loadingInterest(131.0.w, 152.0.h),
                            loadingInterest(107.0.w, 304.0.h)
                          ]);
                  }),
                ),
                SizedBoxResponsive(
                  height: 40,
                ),
                Column(
                  children: [
                    FlatButton(
                      child: ClipRRect(
                        borderRadius: new BorderRadius.all(
                          Radius.circular(4),
                        ),
                        child: ContainerResponsive(
                          height: 53,
                          width: 320.81,
                          decoration: BoxDecoration(
                              color: Color(0xff081C71).withOpacity(0.9)),
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            'REPORT',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(14),
                                fontFamily: 'helvetica',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      onPressed: () {},
                    ),
                    SizedBoxResponsive(
                      height: 12,
                    ),
                    FlatButton(
                      child: ClipRRect(
                        borderRadius: new BorderRadius.all(
                          Radius.circular(4),
                        ),
                        child: ContainerResponsive(
                          height: 53,
                          width: 320.81,
                          decoration: BoxDecoration(
                              color: Color(0xff2699FB).withOpacity(0.5)),
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            'UNPAIR',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(14),
                                fontFamily: 'helvetica',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      onPressed: () {},
                    ),
                    SizedBoxResponsive(
                      height: 12,
                    ),
                    FlatButton(
                      child: ClipRRect(
                        borderRadius: new BorderRadius.all(
                          Radius.circular(4),
                        ),
                        child: ContainerResponsive(
                          height: 53,
                          width: 320.81,
                          decoration: BoxDecoration(
                              color: Color(0xffDEDEDE).withOpacity(0.5)),
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            'BLOCK',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(14),
                                fontFamily: 'helvetica',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                SizedBoxResponsive(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Positioned coloredInterest(text, x, y) {
    return Positioned(
      left: ScreenUtil().setSp(x),
      top: ScreenUtil().setSp(y),
      child: ClipRRect(
        borderRadius: new BorderRadius.all(
          Radius.circular(360),
        ),
        child: ContainerResponsive(
          width: 133,
          height: 133,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff4B6FFF), Color(0xff0226B2)],
                begin: const FractionalOffset(0.5, 0.5),
                end: const FractionalOffset(0.5, 0.9),
                tileMode: TileMode.clamp),
          ),
          child: AutoSizeText(
            text,
            style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(17),
                fontFamily: 'helvetica',
                fontWeight: FontWeight.w100),
          ),
        ),
      ),
    );
  }

  Positioned nonColoredInterest(text, x, y) {
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
          decoration: BoxDecoration(color: Color(0xff495896).withOpacity(0.4)),
          child: AutoSizeText(
            text,
            style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(17),
                fontFamily: 'helvetica',
                fontWeight: FontWeight.w100),
          ),
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

  ContainerResponsive profileRow(field, value, divider) {
    return ContainerResponsive(
      height: divider ? 81 : 61,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ContainerResponsive(
                width: 120,
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  field,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(17),
                      fontFamily: 'helvetica',
                      fontWeight: FontWeight.w100),
                ),
              ),
              SizedBoxResponsive(
                width: 50,
              ),
              ContainerResponsive(
                width: 120,
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  value,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(17),
                      fontFamily: 'helvetica',
                      fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
          divider
              ? Divider(
                  color: Color(0xff0A2175),
                  thickness: 2,
                )
              : Container()
        ],
      ),
    );
  }
}

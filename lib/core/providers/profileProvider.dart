import 'package:beunique/core/models/profileModel.dart';
import 'package:beunique/core/services/profileServices.dart';
import 'package:beunique/ui/widgets/videoPlaerItem.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:video_player/video_player.dart';

class ProfileProvider extends ChangeNotifier {
  UserServices _userRepository = new UserServices();
  Profile profile;
  int current = 0;
  bool isLoading = true;
  bool isLoadingLoc = true;
  List<String> myHeaderList = [];
  List<Placemark> placemark;
  List<Widget> imageSliders;
  bool liked = false;
  void getData(context) async {
    try {
      //get the profile data
      isLoading = true;
      notifyListeners();
      var response = _userRepository.getProfile();
      FocusScope.of(context).unfocus();
      response.then((onValue) async {
        profile = Profile.fromJson(onValue['data']['profile']);
        isLoading = false;
        notifyListeners();
        getLocation();
        setHeader();
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: e,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0);
      isLoading = false;
      notifyListeners();
    }
  }

  like() {
    liked = !liked;
    notifyListeners();
  }

  getLocation() async {
    //translate the Coordinates to the name of the location
    isLoadingLoc = true;
    notifyListeners();
    placemark = await Geolocator().placemarkFromCoordinates(
        profile.location.coordinates[0], profile.location.coordinates[1]);
    isLoadingLoc = false;
    notifyListeners();
  }

//the media slider setup
  void setHeader() {
    //fill myHeaderList with media URLs
    myHeaderList.clear();
    profile.media.forEach((item) {
      myHeaderList.add(item.filename);
    });

    imageSliders = profile.media.map((item) {
      if (item.isVideo != true) {
        //if the media file is not a vedio then return Image
        return ContainerResponsive(
          width: 414,
          height: 523,
          child: CachedNetworkImage(
            imageUrl: item.filename,
            fit: BoxFit.cover,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
        );
      } else {
        return VideoItems(
          videoPlayerController: VideoPlayerController.asset(
            item.video,
          ),
          looping: true,
          autoplay: true,
        );
        //if the media file is a vedio then set video widget

        // this the video widget controller
        VideoPlayerController controller;
        //set the url to the controller
        controller = VideoPlayerController.network(item.video)
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            controller.play();
            notifyListeners();
            return GestureDetector(
              onTap: () {
                controller.value.isPlaying
                    ? controller.pause()
                    : controller.play();
                notifyListeners();
              },
              child: AspectRatio(
                child: VideoPlayer(controller),
                aspectRatio: controller.value.aspectRatio,
              ),
            );
          });
      }
    }).toList();
    imageSliders.toSet().toList();
  }
}

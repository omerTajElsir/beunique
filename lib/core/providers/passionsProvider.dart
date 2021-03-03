import 'package:beunique/core/models/passionsModel.dart';
import 'package:beunique/core/services/passionsSerives.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PassionsProvider extends ChangeNotifier {
  PassionsServices _userRepository = new PassionsServices();
  bool isLoading = true;
  PassionsModel passions;
  List savedpassions = [];
  void getData(context) async {
    // get the interests
    try {
      isLoading = true;
      notifyListeners();
      var response = _userRepository.getInterests();
      FocusScope.of(context).unfocus();
      response.then((onValue) {
        passions = PassionsModel.fromJson(onValue['data']);
        isLoading = false;
        notifyListeners();
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

  addToPassions(index) {
    //when user tap on an interest
    bool isSelected = savedpassions.contains(passions.interests[index].name);
    if (!isSelected) {
      // if it's not selected then select it
      savedpassions.add(passions.interests[index].name);
    } else {
      // if it's selected then remove it from the selected list
      savedpassions.remove(passions.interests[index].name);
    }
    notifyListeners();
  }
}

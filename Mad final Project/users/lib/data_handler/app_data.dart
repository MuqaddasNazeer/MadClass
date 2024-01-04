import 'package:flutter/cupertino.dart';
import 'package:users/models/address.dart';

class AppData extends ChangeNotifier
{
  Address pickUpLocation = Address();
  void updatePickUpLocationAddress(Address pickUpAddress)
  {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }
}
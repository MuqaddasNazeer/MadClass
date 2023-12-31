import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:users/assistance/request_assistance.dart';
import 'package:users/data_handler/app_data.dart';
import 'package:users/models/address.dart';


// Class for reverse geocoding
class AssistantMethods
{
  static Future<String> searchCoordinateAddress(Position position, context) async
  {
    String placeAddress = '';
    String st1, st2, st3, st4;
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyDz6kVILoHJmepM0jqT1d_ivnogDUdGc4g";

    var response = await RequestAssistance.getRequest(url);

    if(response != "Failed")
    {
     // placeAddress = response["results"][0]["formatted_address"];
     st1 = response["results"][0]["address_components"][0]["long_name"];
     st2 = response["results"][0]["address_components"][1]["long_name"];
     st3 = response["results"][0]["address_components"][5]["long_name"];
     st4 = response["results"][0]["address_components"][6]["long_name"];
     placeAddress = st1 + ", " + st2 + ", " + st3 + ", " + st4;


      Address userPickUpAddress = new Address();
      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false).updatePickUpLocationAddress(userPickUpAddress);
    }

    return placeAddress;
  }
}
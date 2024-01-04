import 'dart:convert';
import 'package:http/http.dart' as http;

// Request for the API
class RequestAssistance{
  static Future<dynamic> getRequest(String url) async {
    http.Response response = await http.get(url as Uri);

    try
    {
      if(response.statusCode == 200){
        String jSonData = response.body;
        var decodeData = jsonDecode(jSonData);
        return decodeData;
      }
      else{
        return "Failed";
      }
    }
    catch(exp)
    {
      return "Failed";
    }
  }
}
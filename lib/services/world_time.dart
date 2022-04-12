import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {
  String location; //location name
  String time = ''; //the time in the location
  String flag; //url asset for flag icon
  String url; //location url for api endpoints

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      String uri = "http://worldtimeapi.org/api/timezone/$url";
      Response response = await get(Uri.parse(uri));
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime);
      // print(offset);

      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      time = now.toString();
    } catch (e) {
      print('caught error: $e');
      time = 'Could not get time data.';
    }
  }
}

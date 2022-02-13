import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  String serverUrl = 'https://admweb-heroku.herokuapp.com/api/';
  //add data Order
  void adddata(String order, String file) async {
    final prefs = await SharedPreferences.getInstance();
    // final api_key =
        // 'ebf740cda1cd777305801e6784670ff6b88e919155fe10c74d5c1954b349c694';
    // final value = prefs.get(api_key) ?? 0;
    String url = '$serverUrl/addorder';
    //passing ke backend
    http.post(Uri.parse(url), body: {"order": "$order", "file": "$file"}).then(
        (response) {
      print('Response Status: ${response.statusCode}');
      print('isi Reponse bodynya : ${response.body}');
    });
  }

  //get pelayanan
  
}

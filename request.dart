import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:gen_fuel_data/class.dart';

class RequestUtil {
  static Future sitedetails(String siteID) async {
    var res = await http.get(Uri.parse(
        "https://fuelforcastapi.azurewebsites.net/site/" +
            siteID.toUpperCase()));
    var sites = json.decode(res.body);

    print(sites);
    return sites;
  }

  static Future<String> less30() async {
    http.Response res = await http
        .get(Uri.parse("https://fuelforcastapi.azurewebsites.net/less30"));

    return res.body;
  }

  static Future<String> less100() async {
    http.Response res = await http
        .get(Uri.parse("https://fuelforcastapi.azurewebsites.net/less100"));

    return res.body;
  }

  static Future<String> less200() async {
    http.Response res = await http
        .get(Uri.parse("https://fuelforcastapi.azurewebsites.net/other"));
    return res.body;
  }
}

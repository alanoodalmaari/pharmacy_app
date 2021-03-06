import 'package:pharmacy_app/models/geopoint.dart';
import 'package:pharmacy_app/models/nearby.dart';
import 'package:pharmacy_app/constant/map_key.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class NearcyLocationApi {
  static NearcyLocationApi _instance;

  NearcyLocationApi._();

  static NearcyLocationApi get instance {
    if (_instance == null) {
      _instance = NearcyLocationApi._();
    }
    return _instance;
  }

  Future<List<Nearby>> getNearby({GeoPoint userLocation, double radius, String type, String keyword}) async {
    // String url =
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${userLocation.latitude},${userLocation.longitude}&radius=$radius&type=$type&keyword=$keyword&key=${MapKey.apiKey}');
    http.Response response = await http.get(url);
    final values = jsonDecode(response.body);
    final List result = values['results'];
    print(result);
    return result.map((e) => Nearby.fromJson(e)).toList();
  }
}

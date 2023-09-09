import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getUserId() {
    return _prefs.getString('userId') ?? '';
  }

  static void setUserId(String userId) {
    _prefs.setString('userId', userId);
  }

  static void clearUserId() {
    _prefs.remove('userId');
  }

  // To check it is corporate profile or not.....also enable and disable corporate profile

  static void setCorporateProfile(bool isCorporate) {
    _prefs.setBool('isCorporate', isCorporate);
  }

  static bool checkCorporateProfile(){
    return _prefs.getBool("isCorporate") ??false;
  }

  static void clearCorporateProfile() {
    _prefs.remove('isCorporate');
  }

  // To set access token for particular user
  static String getUserAccessToken() {
    return _prefs.getString('accessToken') ??
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDkxMDksImlhdCI6MTY5OTk2MDY4OCwiZXhwIjoxNzAwNTY1NDg4fQ.Ue4_5SXLFwJ_vTkqvE5x1iYH8rsQ5wZNDcr3jHBzC0o';
  // refreshToken:
  //   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDkxMDksImlhdCI6MTY5OTk2MDY4OCwiZXhwIjoxNzMxNDk2Njg4fQ.N7MvXdFqHF79MMM9myjbiflhfvJhwLRBL7dp-wobpQ0';
  }

  static void setUserAccessToken(String accessToken) {
    _prefs.setString('accessToken', accessToken);
  }

  static void clearUserAccessToken() {
    _prefs.remove('accessToken');
  }
}

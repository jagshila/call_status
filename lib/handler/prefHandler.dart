import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;



void saveStringPref(key,value) async {
  // 2
  // 3
  if(prefs==null)
  prefs=await SharedPreferences.getInstance();
  await prefs.setString(key,value);
}

Future<String> getStringPref(key) async {
  // 2
  if(prefs==null)
  prefs = await SharedPreferences.getInstance();
  // 3
  return prefs.getString(key);
}


void saveArrayToPref(key,list) async{
if(prefs==null)
  prefs = await SharedPreferences.getInstance();
  prefs.setStringList(key, list);

}

Future<List<String>> getArrayFromPref(key) async{
  if(prefs==null)
  prefs = await SharedPreferences.getInstance();
  return prefs.getStringList(key);

}
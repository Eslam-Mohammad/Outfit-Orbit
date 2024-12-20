
import 'dart:convert';


import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
class SendNotification {
  static final jsonKey   = {

   };


 static List<String> scopes=[
    "https://www.googleapis.com/auth/firebase.messaging",
  ];

static Future<String> getAccessToken()async{
http.Client client = await auth.clientViaServiceAccount(
  auth.ServiceAccountCredentials.fromJson(jsonKey),
  scopes,
);

auth.AccessCredentials credentials =
await auth.obtainAccessCredentialsViaServiceAccount(auth.ServiceAccountCredentials.fromJson(jsonKey), scopes, client);

client.close();

  return credentials.accessToken.data;
}

static Future<void> sendNotification(
    {required String deviceToken,required String title,required String body, String? data})async{

String accessToken=await getAccessToken();
String endpoint='https://fcm.googleapis.com/v1/projects/mytestapps-83a40/messages:send';
final Map<String,dynamic> message ={
  "message":{
    "token":deviceToken,
    "notification":{
      "title":title,
      "body":body,
    },
    "data":data,
  }
};


final http.Response response =await http.post(Uri.parse(endpoint),
  headers: <String, String>{
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  },
  body: jsonEncode(message),);


if(response.statusCode==200){
  print('notification sent');
}else{
  print('notification failed');
}

  return Future.value();
}




}
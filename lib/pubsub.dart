import 'dart:io';
import 'dart:convert';
import 'package:gcloud/pubsub.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;





Future<bool> sendMessage(String message) async {
  print("Sending message: $message");
// Read the service account credentials from the file.
  var jsonCredentials = new File('gohome-cred.json').readAsStringSync();
  var credentials = new auth.ServiceAccountCredentials.fromJson(jsonCredentials);
  var client = await auth.clientViaServiceAccount(credentials, PubSub.SCOPES);
  var pubsub = PubSub(client, "gohome-dev");
  var topic = await pubsub.lookupTopic("calling_home");
  await topic.publishString(message);
  print("Sent message: $message");
  return true;
}

String buildLightCommandMessage({String ambient, String light, String command}) {
  var where = ambient + "." + light;
  var message = {"who": "LIGHT", "what": command, "where":where, "kind":"COMMAND"};
  var json = jsonEncode(message);
  return json;
}
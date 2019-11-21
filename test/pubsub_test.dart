import "package:test/test.dart";
import 'package:flhome/pubsub.dart';

void main() async {
  test("Send messages", () async {
    await sendMessage("ciao");
    await sendMessage('{"who":"LIGHT","what":"TURN_ON", "where":"esterno.ingresso","kind":"COMMAND"}');
  });

  test("BuildLightCommandMessage", () async {
    var msg = buildLightCommandMessage(ambient:"kitchen", light:"main", command:"TURN_ON");
    print("Got json: $msg");
    if (msg != '{"who":"LIGHT","what":"TURN_ON","where":"kitchen.main","kind":"COMMAND"}') {
      fail("Got wrong JSON: $msg");
    }

  });
}

import 'dart:developer' as devs show log;

extension Logger on Object {
  void log() => devs.log(toString());
}

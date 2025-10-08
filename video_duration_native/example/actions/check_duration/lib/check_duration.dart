import 'package:check_duration/check_duration.dart';
import 'package:fluttium/fluttium.dart';

export 'src/check_duration.dart';

/// Will be executed by Fluttium on startup.
void register(Registry registry) {
  registry.registerAction('checkDuration', CheckDuration.new);
}

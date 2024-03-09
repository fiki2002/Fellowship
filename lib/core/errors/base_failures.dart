import 'package:fellowship/core/core.dart';

class BaseFailures extends Failure {
  const BaseFailures({
    required String message,
    StackTrace? trace,
  }) : super(
          message: message,
          trace: trace,
        );
  @override
  String toString() {
    return 'Base Failures: $message $trace';
  }
}

class SocketFailures extends Failure {
  const SocketFailures({
    required String message,
    StackTrace? trace,
  }) : super(
          message: message,
          trace: trace,
        );
}

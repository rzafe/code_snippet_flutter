
class HTTPException implements Exception {
  final dynamic message;
  final dynamic prefix;

  HTTPException([this.message, this.prefix]);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends HTTPException {
  FetchDataException([String? message])
      : super(message, 'Error During Communication: ');
}

class BadRequestException extends HTTPException {
  BadRequestException([message]) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends HTTPException {
  UnauthorisedException([message]) : super(message, 'Unauthorised: ');
}

class InvalidInputException extends HTTPException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input: ');
}
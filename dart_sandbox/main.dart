void main() {}

Future<void> myfunction(bool isError) async {
  if (isError) {
    throw MyException('An error occurred');
  }
}

class MyException implements Exception {
  final String message;
  MyException(this.message);
}

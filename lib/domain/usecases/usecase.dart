import 'package:ePaisa_interview/data/model/app_result.dart';

abstract class Usecase<T> {
  Future<AppResult<T>> execute();
}

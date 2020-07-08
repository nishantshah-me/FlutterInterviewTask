import 'package:ePaisa_interview/data/model/app_result.dart';
import 'package:ePaisa_interview/domain/entities/order.dart';

abstract class Datasource {
  Future<AppResult<Order>> fetchOrder();
}

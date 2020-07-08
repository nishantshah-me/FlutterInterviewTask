import 'package:ePaisa_interview/data/datasources/RemoteDatasource.dart';
import 'package:ePaisa_interview/data/model/app_result.dart';
import 'package:ePaisa_interview/domain/entities/order.dart';
import 'package:get_it/get_it.dart';

class OrderRepository {
  final RemoteDatasource remoteDatasource = GetIt.instance<RemoteDatasource>();

  Future<AppResult<Order>> getOrder() {
    return remoteDatasource.fetchOrder();
  }
}

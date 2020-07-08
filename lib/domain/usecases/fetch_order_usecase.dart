import 'package:ePaisa_interview/data/model/app_result.dart';
import 'package:ePaisa_interview/data/repositories/order_repository.dart';
import 'package:ePaisa_interview/domain/entities/order.dart';
import 'package:ePaisa_interview/domain/usecases/usecase.dart';

class FetchOrderUsecase extends Usecase<Order> {
  final OrderRepository orderRepository;

  FetchOrderUsecase(this.orderRepository);

  @override
  Future<AppResult<Order>> execute() async {
    return orderRepository.getOrder();
  }
}

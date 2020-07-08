import 'dart:async';

import 'package:ePaisa_interview/data/di/factory.dart';
import 'package:ePaisa_interview/data/model/app_result.dart';
import 'package:ePaisa_interview/domain/entities/order.dart';
import 'package:ePaisa_interview/domain/usecases/fetch_order_usecase.dart';
import 'package:get_it/get_it.dart';

import '../../domain/usecases/fetch_order_usecase.dart';

class MapBloc {
  FetchOrderUsecase _usecase = GetIt.instance<FetchOrderUsecase>();
  final StreamController<Order> streamController =
      StreamController<Order>.broadcast();

  void getOrderInfo() async {
    final response = await _usecase.execute();
    // Data handling.
    switch (response.status) {
      case Status.SUCCESS:
        streamController.sink.add(response.data);
        break;
      case Status.FAILURE:
        streamController.sink.addError(Exception(response.message));
        break;
    }
    streamController.done;
  }

  dispose() {
    streamController.close();
  }
}

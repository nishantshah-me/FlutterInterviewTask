import 'dart:async';

import 'package:ePaisa_interview/data/model/app_result.dart';
import 'package:ePaisa_interview/domain/entities/login.dart';
import 'package:ePaisa_interview/domain/entities/order.dart';
import 'package:ePaisa_interview/domain/usecases/fetch_login_response.dart';
import 'package:ePaisa_interview/domain/usecases/fetch_notification_usecase.dart';
import 'package:ePaisa_interview/domain/usecases/fetch_order_usecase.dart';
import 'package:get_it/get_it.dart';

class LoginBloc{
  FetchLoginUsecase _usecase = GetIt.instance<FetchLoginUsecase>();
  FetchNotificationUsecase _usecaseForNotification = GetIt.instance<FetchNotificationUsecase>();


  final StreamController<LoginEntity> streamController =
  StreamController<LoginEntity>.broadcast();

  final StreamController<NotificationEntity> notifyStreamController =
  StreamController<NotificationEntity>.broadcast();

  void facebookAuth() async{
    final response = await _usecase.execute();

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

  void pushNotification() async{
    final response = await _usecaseForNotification.execute();

    switch (response.status) {
      case Status.SUCCESS:
        notifyStreamController.sink.add(response.data);
        break;
      case Status.FAILURE:
        notifyStreamController.sink.addError(Exception(response.message));
        break;
    }
    notifyStreamController.done;

  }

  dispose() {
    streamController.close();
    notifyStreamController.close();
  }

}
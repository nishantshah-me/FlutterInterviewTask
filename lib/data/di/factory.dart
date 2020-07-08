import 'package:ePaisa_interview/data/datasources/RemoteDatasource.dart';
import 'package:ePaisa_interview/data/repositories/login_repository.dart';
import 'package:ePaisa_interview/data/repositories/order_repository.dart';
import 'package:ePaisa_interview/domain/usecases/fetch_login_response.dart';
import 'package:ePaisa_interview/domain/usecases/fetch_notification_usecase.dart';
import 'package:ePaisa_interview/domain/usecases/fetch_order_usecase.dart';
import 'package:ePaisa_interview/presentation/login/login_bloc.dart';
import 'package:ePaisa_interview/presentation/map/map_bloc.dart';
import 'package:get_it/get_it.dart';

class ObjectFactory {
  static register() {
    var getI = GetIt.instance;
    //Usecase
    getI.registerFactory<FetchOrderUsecase>(
        () => FetchOrderUsecase(OrderRepository()));

    getI.registerFactory<FetchLoginUsecase>(
            () => FetchLoginUsecase(LoginRepository()));

    getI.registerFactory<FetchNotificationUsecase>(
            () => FetchNotificationUsecase(LoginRepository()));



    //Bloc
    getI.registerFactory<MapBloc>(() => MapBloc());
    getI.registerFactory<LoginBloc>(() => LoginBloc());
    //Datasource
    getI.registerLazySingleton<RemoteDatasource>(() => RemoteDatasource());
  }
}

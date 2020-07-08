import 'package:ePaisa_interview/data/model/app_result.dart';
import 'package:ePaisa_interview/data/repositories/login_repository.dart';
import 'package:ePaisa_interview/domain/entities/login.dart';
import 'package:ePaisa_interview/domain/usecases/usecase.dart';

class FetchNotificationUsecase extends Usecase<NotificationEntity> {
  final LoginRepository notifyRepository;

  FetchNotificationUsecase(this.notifyRepository);

  @override
  Future<AppResult<NotificationEntity>> execute() async {
    return notifyRepository.getNotificationResponse();
  }

}

import 'package:ePaisa_interview/data/model/app_result.dart';
import 'package:ePaisa_interview/data/repositories/login_repository.dart';
import 'package:ePaisa_interview/domain/entities/login.dart';
import 'package:ePaisa_interview/domain/usecases/usecase.dart';

class FetchLoginUsecase extends Usecase<LoginEntity> {
  final LoginRepository loginRepository;

  FetchLoginUsecase(this.loginRepository);

  @override
  Future<AppResult<LoginEntity>> execute() async {
    return loginRepository.getLoginResponse();
  }

}

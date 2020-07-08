import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final bool success ;
  final Map userProfile ;

  LoginEntity(this.success, this.userProfile);

  @override
  List<Object> get props => throw UnimplementedError();
}

class NotificationEntity extends Equatable{
  final String title;
  final String body;
  final bool sucess;

  NotificationEntity(this.title, this.body, this.sucess);
  @override
  List<Object> get props => throw UnimplementedError();

}

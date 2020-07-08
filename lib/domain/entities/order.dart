import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final int id;
  final String customerName;
  final String restaurantName;
  final double customerLat;
  final double customerLng;
  final double restaurantLat;
  final double restaurantLng;

  Order(this.id, this.customerName, this.restaurantName, this.customerLat,
      this.customerLng, this.restaurantLat, this.restaurantLng);

  @override
  List<Object> get props => throw UnimplementedError();
}

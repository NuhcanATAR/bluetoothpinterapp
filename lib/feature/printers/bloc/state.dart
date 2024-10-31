part of '../bloc/cubit.dart';

abstract class PrintersState extends Equatable {
  const PrintersState();

  @override
  List<Object?> get props => [];
}

class PrintersInitial extends PrintersState {}

class PrintersLoaded extends PrintersState {
  final String selectedDeviceId;
  final String selectedDeviceName;

  const PrintersLoaded({
    required this.selectedDeviceId,
    required this.selectedDeviceName,
  });

  @override
  List<Object?> get props => [selectedDeviceId, selectedDeviceName];
}

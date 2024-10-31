part of 'cubit.dart';

abstract class PrintersEvent extends Equatable {
  const PrintersEvent();

  @override
  List<Object?> get props => [];
}

class PrinterSelected extends PrintersEvent {
  final BluetoothDevice selectedDevice;

  const PrinterSelected(this.selectedDevice);

  @override
  List<Object?> get props => [selectedDevice];
}

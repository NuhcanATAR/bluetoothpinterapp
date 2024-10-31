import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

@immutable
class AppStart {
  const AppStart._();

  static Future<void> initStartApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory(),
    );
    HydratedBloc.storage = storage;
  }
}

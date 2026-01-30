
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingCubit extends Cubit<bool> {
  LoadingCubit() : super(false);

  void emitSetValue(bool value) => emit(value);
}

// class LoadVerifCubit extends Cubit<bool> {
//   LoadVerifCubit() : super(false);
//
//   void emitSetValue(bool value) => emit(value);
// }
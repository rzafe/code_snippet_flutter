import 'package:bloc/bloc.dart';

import '../../data/model/philippine_location.dart';

class UserProfileIDCubit extends Cubit<String> {
  UserProfileIDCubit() : super('');

  void emitSetValue(String state) => emit(state);
}

class UserProfileMobileNumberCubit extends Cubit<String> {
  UserProfileMobileNumberCubit() : super('');

  void emitSetValue(String state) => emit(state);
}


class LoginRememberMeCubit extends Cubit<bool> {
  LoginRememberMeCubit() : super(false);

  void emitIsCheck(bool isCheck) => emit(_setIsCheck(isCheck));

  bool _setIsCheck(bool isCheck) {
    if (isCheck) {
      return false;
    } else {
      return true;
    }
  }
}

class RegionListCubit extends Cubit<List<PHLocation>?> {
  RegionListCubit() : super([]);

  void emitSetValue(List<PHLocation>? state) => emit(state);
}

class ProvinceListCubit extends Cubit<List<PHLocation>?> {
  ProvinceListCubit() : super([]);

  void emitSetValue(List<PHLocation>? state) => emit(state);
}

class DistrictListCubit extends Cubit<List<PHLocation>?> {
  DistrictListCubit() : super([]);

  void emitSetValue(List<PHLocation>? state) => emit(state);
}

class CityListCubit extends Cubit<List<PHLocation>?> {
  CityListCubit() : super([]);

  void emitSetValue(List<PHLocation>? state) => emit(state);
}

class BarangayListCubit extends Cubit<List<PHLocation>?> {
  BarangayListCubit() : super([]);

  void emitSetValue(List<PHLocation>? state) => emit(state);
}
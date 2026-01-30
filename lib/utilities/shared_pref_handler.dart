
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHandler {
  factory SharedPreferencesHandler() => _instance ??= SharedPreferencesHandler._();
  SharedPreferencesHandler._();
  static SharedPreferencesHandler? _instance;

  /// Removed Data -------------------------------------------------------------
  Future<bool> removeDataEncrypted(String key) async {
    final SharedPreferences encryptedSharedPrefs = await SharedPreferences.getInstance();
    return await encryptedSharedPrefs.remove(key);
  }

  Future<bool> clearAllDataEncrypted() async {
    final SharedPreferences encryptedSharedPrefs = await SharedPreferences.getInstance();
    return await encryptedSharedPrefs.clear();
  }

  /// Read and Save Data -------------------------------------------------------
  Future<String> readDataEncrypted(String key) async {
    final EncryptedSharedPreferences encryptedSharedPrefs = EncryptedSharedPreferences();
    return await encryptedSharedPrefs.getString(key);
  }

  Future<void> saveDataEncrypted(String key, dynamic value) async {
    final EncryptedSharedPreferences encryptedSharedPrefs = EncryptedSharedPreferences();
    await encryptedSharedPrefs.setString(key, value);
  }

  /// Read and Save Bool Data --------------------------------------------------
  Future<bool> readBoolDataEncrypted(String key) async {
    /// You can pass a custom SharedPreferences
    /// instance (e.g. A newer version of SharedPreferences)
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final EncryptedSharedPreferences encryptedSharedPrefs = EncryptedSharedPreferences(prefs: prefs);

    /// You can access the internal SharedPreferences instance
    /// to invoke methods not exposed by regular EncryptedSharedPreferences
    final SharedPreferences instance = await encryptedSharedPrefs.getInstance();

    return instance.getBool(key) ?? false;
  }

  Future<void> saveBoolDataEncrypted(String key, bool value) async {
    /// You can pass a custom SharedPreferences instance
    /// (e.g. A newer version of SharedPreferences)
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final EncryptedSharedPreferences encryptedSharedPrefs = EncryptedSharedPreferences(prefs: prefs);

    /// You can access the internal SharedPreferences instance
    /// to invoke methods not exposed by regular EncryptedSharedPreferences
    final SharedPreferences instance = await encryptedSharedPrefs.getInstance();

    instance.setBool(key, value);
  }

  /// Flutter Secure Storage ---------------------------------------------------
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  Future<void> writeSecureStorage({required String key, required dynamic value}) async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    await storage.write(key: key, value: value);
  }

  Future<String?> readSecureStorage({required String key}) async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    String? value = await storage.read(key: key);
    return value;
  }

}

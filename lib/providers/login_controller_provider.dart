import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/login_controller.dart';


final loginControllerProvider = Provider<LoginController>((ref) {
  return LoginController();
});
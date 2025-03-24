import 'package:dio/dio.dart';

import 'user_service.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://app.globalpconsulting.com.ng/api', // For Emulator, use 127.0.0.1 for real devices
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  final UserService _userService = UserService(); // Initialize UserService


    Future<Map<String, dynamic>> register({
      required String name,
      required String email,
      required String phone,
      required String password,
    }) async {
      try {
        Response response = await _dio.post(
          '/register',
          data: {
            'name': name,
            'email': email,
            'mobile_number': phone,
            'password': password,
          },
        );

        if (response.statusCode == 200) {
          await _userService.saveUserData(name); // Save user name after signup
        }

        print("Response Data: ${response.data}"); // ✅ Print API response

        return response.data;
      } catch (e) {
        if (e is DioException) {
          print("Dio Error: ${e.response?.data}"); // ✅ Print error response
          print("Dio Status Code: ${e.response?.statusCode}"); // ✅ Print status code
          return e.response?.data ?? {'error': 'Something went wrong. Please try again.'};
        } else {
          print("Unknown Error: $e"); // ✅ Print any other errors
          return {'error': 'Something went wrong. Please try again.'};
        }
      }
    }


  // New Function to Verify OTP
  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      Response response = await _dio.post(
        '/verify-otp',
        data: {
          'mobile_number': phone,
          'otp': otp,
        },
      );

      return response.data;
    } catch (e) {
      return {'error': 'Invalid OTP or server error'};
    }
  }

    Future<Map<String, dynamic>> login({
    required String phone,
    required String password,
    }) async {
      try {
        Response response = await _dio.post(
          '/login',
          data: {
            'mobile_number': phone,
            'password': password,
          },
        );

        if (response.statusCode == 200) {
          String name = response.data['user']['name']; // Extract user name
          await _userService.saveUserData(name); // Save user name after login
        }

        return response.data;
      } catch (e) {
        if (e is DioException) {
          return e.response?.data ?? {'error': 'Invalid credentials or server error'};
        } else {
          return {'error': 'Something went wrong. Please try again.'};
        }
      }
}
}



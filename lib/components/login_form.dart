import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_a_trip/components/alert.dart';
import 'package:go_a_trip/components/navigation.dart';
import 'package:go_a_trip/services/auth/login_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final LoginService _loginService = LoginService();
  final _tokenStorage = const FlutterSecureStorage();
  bool _isLoading = false;

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_validateInputs()) return;

    setState(() => _isLoading = true);

    try {
      final loginResponse = await _loginService.loginRequest(
        _idController.text.trim(),
        _pwController.text.trim(),
      );

      await _saveTokens(loginResponse);

      if (!mounted) return;
      _navigateToHome();
    } catch (e) {
      if (!mounted) return;
      _handleLoginError(e);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  bool _validateInputs() {
    if (_idController.text.trim().isEmpty ||
        _pwController.text.trim().isEmpty) {
      alert(context, '모든 필드를 입력해주세요.', 'INFO');
      return false;
    }
    return true;
  }

  Future<void> _saveTokens(dynamic loginResponse) async {
    await _tokenStorage.write(
      key: 'accessToken',
      value: loginResponse.accessToken,
    );
    await _tokenStorage.write(
      key: 'refreshToken',
      value: loginResponse.refreshToken,
    );
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Navigation()),
    );
  }

  void _handleLoginError(dynamic error) {
    final errorCode = error.toString().split(": ")[1];
    switch (errorCode) {
      case '404':
        alert(context, '유저를 찾을 수 없습니다.', 'ERROR');
        break;
      case '401':
        alert(context, '비밀번호가 올바르지 않습니다.', 'ERROR');
        break;
      default:
        alert(context, '로그인 중 오류가 발생했습니다.', 'ERROR');
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String placeholder,
    bool isPassword = false,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: CupertinoTextField(
          controller: controller,
          placeholder: placeholder,
          decoration: const BoxDecoration(),
          obscureText: isPassword,
          enabled: !_isLoading,
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      child: InkWell(
        onTap: _isLoading ? null : _handleLogin,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: _isLoading ? Colors.grey[200] : Colors.grey[300],
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Center(
            child: _isLoading
                ? const CupertinoActivityIndicator()
                : const Text(
                    '로그인',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildTextField(
          controller: _idController,
          placeholder: '아이디를 입력해주세요',
        ),
        _buildTextField(
          controller: _pwController,
          placeholder: '비밀번호를 입력해주세요',
          isPassword: true,
        ),
        _buildLoginButton(),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_a_trip/components/alert.dart';
import 'package:go_a_trip/components/header.dart';
import 'package:go_a_trip/components/navigation.dart';
import 'package:go_a_trip/services/board/write_board.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreen();
}

class _WriteScreen extends State<WriteScreen> {
  bool _isLoading = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  final WriteBoardService _writeBoardService = WriteBoardService();

  @override
  void dispose() {
    _titleController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    if (_titleController.text.trim().isEmpty ||
        _detailController.text.trim().isEmpty) {
      alert(context, '모든 필드를 입력해주세요.', 'INFO');
      return false;
    }
    return true;
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Navigation()),
    );
  }

  void _handleWriteError(dynamic error) {
    final errorCode = error.toString().split(": ")[1];
    switch (errorCode) {
      case '401':
        alert(context, '토큰이 만료되었습니다. 다시 로그인해주세요.', 'ERROR');
        break;
      default:
        alert(context, '게시 중 오류가 발생했습니다.', 'ERROR');
    }
  }

  Future<void> _handleWrite() async {
    if (!_validateInputs()) return;

    setState(() => _isLoading = true);

    try {
      await _writeBoardService.writeRequest(
        _titleController.text.trim(),
        _detailController.text.trim(),
      );

      if (!mounted) return;
      _navigateToHome();
    } catch (e) {
      if (!mounted) return;
      _handleWriteError(e);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
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

  Widget _buildWriteButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      child: InkWell(
        onTap: _isLoading ? null : _handleWrite,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: _isLoading ? Colors.grey[200] : Colors.grey[300],
          ),
          padding: const EdgeInsets.all(12),
          child: Center(
            child: _isLoading
                ? const CupertinoActivityIndicator()
                : const Text(
                    '게시',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Header(title: '글쓰기'),
                Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTextField(
                              controller: _titleController,
                              placeholder: '제목을 입력해주세요.'),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: TextField(
                                controller: _detailController,
                                decoration: InputDecoration(
                                  hintText: '내용을 입력해주세요.',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(8),
                                ),
                                enabled: !_isLoading,
                                maxLines: 10,
                                minLines: 10,
                              ),
                            ),
                          ),
                          _buildWriteButton(),
                          const SizedBox(
                            height: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

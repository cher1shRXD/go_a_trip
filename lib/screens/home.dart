import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_a_trip/components/board_card.dart';
import 'package:go_a_trip/components/header.dart';
import 'package:go_a_trip/services/api_service.dart';
import 'package:go_a_trip/models/board_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BoardService _boardService = BoardService();
  List<Board> _boards = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadBoards();
  }

  Future<void> _loadBoards() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final boards = await _boardService.getBoards();
      log('Fetched ${boards.length} boards'); // 데이터 확인용 로그
      setState(() {
        _boards = boards;
      });
    } catch (e) {
      log('Error in _loadBoards: $e'); // 에러 확인용 로그
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Header(title: 'Go a Trip'),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _loadBoards,
                child: _buildContent(),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // TODO: 글쓰기 화면으로 이동
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading && _boards.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '오류가 발생했습니다: $_error',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadBoards,
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }

    if (_boards.isEmpty) {
      return const Center(
        child: Text('게시글이 없습니다.'),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _boards.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final Board board = _boards[index];
        return BoardCard(board: board);
      },
    );
  }
}

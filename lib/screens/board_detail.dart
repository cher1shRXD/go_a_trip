import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_a_trip/models/board_model.dart';
import 'package:go_a_trip/models/user_model.dart';
import 'package:go_a_trip/services/board/get_board_detail.dart';

class BoardDetailScreen extends StatefulWidget {
  const BoardDetailScreen({super.key, required this.id});
  final int id;

  @override
  State<BoardDetailScreen> createState() => _BoardDetailScreenState();
}

class _BoardDetailScreenState extends State<BoardDetailScreen> {
  Board _boards = Board(
      id: 0,
      title: '로딩중...',
      detail: '로딩중...',
      createdAt: '로딩중...',
      category: '로딩중...',
      likesCount: 0,
      author: User(id: 0, username: ''),
      likes: []);
  final GetBoardDetailService instance = GetBoardDetailService();

  @override
  void initState() {
    super.initState();
    _loadBoards();
  }

  Future<void> _loadBoards() async {
    try {
      final boards = await instance.boardDetailRequest(widget.id);
      log('Fetched ${boards.title} content');
      setState(() {
        _boards = boards;
      });
    } catch (e) {
      log('Error in _loadBoards: $e');
      setState(() {
        Navigator.pop(context);
      });
    }
  }

  Future<void> _onRefresh() async {
    await _loadBoards();
  }

  String _formatDate(String date) {
    List<String> splited = date.split('/');
    if (splited.length == 3) {
      return '${splited[2]}년 ${splited[0]}월 ${splited[1]}일';
    }
    return date;
  }

  Widget _buildRefreshIndicator(List<Widget> children) {
    if (Platform.isIOS) {
      return CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: _onRefresh,
          ),
          SliverList(
            delegate: SliverChildListDelegate(children),
          ),
        ],
      );
    } else {
      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: children,
        ),
      );
    }
  }

  Widget _buildGoBack() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listItem = <Widget>[
      Text(
        _boards.title,
        style: const TextStyle(fontSize: 28),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '작성자: ${_boards.author.username}',
            style: const TextStyle(color: Colors.grey),
          ),
          Text(
            '작성일: ${_formatDate(_boards.createdAt)}',
            style: const TextStyle(color: Colors.grey),
          )
        ],
      ),
      const SizedBox(
        height: 12,
      ),
      Text(_boards.detail),
    ];

    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              _buildGoBack(),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: _buildRefreshIndicator(listItem)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

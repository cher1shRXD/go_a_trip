import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_a_trip/components/board_item.dart';
import 'package:go_a_trip/components/header.dart';
import 'package:go_a_trip/components/navigation.dart';
import 'package:go_a_trip/models/board_model.dart';
import 'package:go_a_trip/services/board/get_board_list.dart';

class AllBoardScreen extends StatefulWidget {
  const AllBoardScreen({super.key});

  @override
  State<AllBoardScreen> createState() => _AllBoardScreen();
}

class _AllBoardScreen extends State<AllBoardScreen> {
  bool _isLoading = false;
  String? _error;
  List<Board> _boards = [];
  final NavigateController controller = Get.find<NavigateController>();
  final GetBoardListService instance = GetBoardListService();

  @override
  void initState() {
    super.initState();
    _loadBoards();
  }

  Future<void> _loadBoards() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final boards = await instance.boardListRequest();
      log('Fetched ${boards.length} boards');

      if (!mounted) return;

      setState(() {
        _boards = boards;
      });
    } catch (e) {
      log('Error in _loadBoards: $e');

      if (!mounted) return;

      setState(() {
        _error = e.toString();
      });
    } finally {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _onRefresh() async {
    if (!mounted) return;
    await _loadBoards();
  }

  Widget _buildRefreshIndicator(List<Widget> children) {
    if (Platform.isIOS) {
      return CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: _onRefresh,
          ),
          SliverSafeArea(
            sliver: SliverList(
              delegate: SliverChildListDelegate(children),
            ),
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

  Widget _buildBoardList() {
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $_error'),
            ElevatedButton(
              onPressed: _loadBoards,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_boards.isEmpty && !_isLoading) {
      return Center(
        child: Text('글이 없습니다.', style: TextStyle(color: Colors.grey[300])),
      );
    }

    return Column(
      children: _boards
          .map((board) => BoardItem(
                title: board.title,
                author: board.author.username,
                id: board.id,
                date: board.createdAt,
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listItem = [
      if (_isLoading)
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: CircularProgressIndicator()),
        ),
      _buildBoardList(),
    ];

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Header(title: '전체 글'),
            Expanded(
              child: _buildRefreshIndicator(listItem),
            ),
          ],
        ),
      ),
    );
  }
}

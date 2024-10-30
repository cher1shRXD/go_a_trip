import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:get/get.dart';
import 'package:go_a_trip/components/header.dart';
import 'package:go_a_trip/components/navigation.dart';
import 'package:go_a_trip/models/board_model.dart';
import 'package:go_a_trip/services/board/get_board_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  String? _error;
  List<Board> _boards = [];
  final NavigateController controller = Get.find<NavigateController>();
  final GetBoardService instance = GetBoardService();

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
      final boards = await instance.boardListRequest();
      log('Fetched ${boards.length} boards');
      setState(() {
        _boards = boards;
      });
    } catch (e) {
      log('Error in _loadBoards: $e');
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _onRefresh() async {
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

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () => controller.selectedIndex.value = 3,
      child: Container(
        width: double.infinity,
        height: 40,
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: Colors.grey[200]!,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '무엇이 궁금하신가요?',
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
              Icon(
                Icons.search,
                color: Colors.grey[500],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBoardList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

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

    if (_boards.isEmpty) {
      return const Center(
        child: Text('No boards available'),
      );
    }

    return Column(
      children: _boards
          .map(
            (board) => ListTile(
              title: Text(board.title),
              subtitle: Text(board.detail.length > 16
                  ? '${board.detail.substring(0, 16)}...'
                  : board.detail),
              onTap: () {
                // Handle board item tap
              },
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listItems = [
      _buildSearchBar(),
      _buildBoardList(),
    ];

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Header(title: 'GAON mobile'),
            Expanded(
              child: _buildRefreshIndicator(listItems),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_a_trip/models/board_model.dart';

class BoardCard extends StatelessWidget {
  final Board board;

  const BoardCard({
    super.key,
    required this.board,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          // TODO: 상세 화면으로 이동
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                board.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                board.detail,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '작성일: ${_formatDate(board.createdAt)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String dateStr) {
    final date = DateTime.parse(dateStr);
    return '${date.year}/${date.month}/${date.day} ${date.hour}:${date.minute}';
  }
}

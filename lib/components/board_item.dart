import 'dart:developer';

import 'package:flutter/material.dart';

class BoardItem extends StatefulWidget {
  const BoardItem(
      {super.key,
      required this.title,
      required this.author,
      required this.id,
      required this.date});
  final String title;
  final String author;
  final int id;
  final String date;

  @override
  State<BoardItem> createState() => _BoardItemState();
}

class _BoardItemState extends State<BoardItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log(widget.id.toString());
      },
      child: Container(
          width: double.infinity,
          height: 72,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      '${widget.author} - ${widget.date}',
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w100,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

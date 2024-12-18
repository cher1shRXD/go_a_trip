import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  bool isLoading = false;

  Widget _buildTextField({
    required TextEditingController controller,
    required String placeholder,
  }) {
    void onSearch() {
      setState(() {
        isLoading = true;
      });

      log(_searchTextController.text);

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
      });
    }

    return Container(
      width: double.infinity,
      height: 40,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200]!,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        children: [
          Expanded(
            child: CupertinoTextField(
              controller: controller,
              placeholder: placeholder,
              style: const TextStyle(fontSize: 12),
              decoration: const BoxDecoration(),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              autofocus: true,
              enabled: !isLoading,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: isLoading ? null : onSearch,
              child: Icon(Icons.search,
                  color: isLoading ? Colors.grey[500] : Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        Container(
          color: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTextField(
                    controller: _searchTextController,
                    placeholder: '어디로 가고 싶으신가요?')
              ],
            ),
          ),
        ),
        Expanded(child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ))
      ]),
    );
  }
}

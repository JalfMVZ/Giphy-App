import 'package:flutter/material.dart';

class PaginationBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  const PaginationBar({
    Key? key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalPages, (index) {
          final pageNumber = index + 1;
          return InkWell(
            onTap: () {
              onPageChanged(pageNumber);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: pageNumber == currentPage
                    ? Colors.blue
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                pageNumber.toString(),
                style: TextStyle(
                  color: pageNumber == currentPage ? Colors.red : Colors.black,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

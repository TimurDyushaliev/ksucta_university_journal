import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    required ValueKey? key,
    required this.title,
    required this.onDelete,
    required this.onTap,
    this.displayTrailing = true,
    this.color,
  }) : super(key: key);

  final String title;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final bool displayTrailing;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Dismissible(
        key: ValueKey(key),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          onDelete();
        },
        background: Container(
          color: Colors.grey[400],
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Icon(
                Icons.delete,
                color: Colors.grey[800],
              ),
            ),
          ),
        ),
        child: ListTile(
          onTap: onTap,
          title: Text(title),
          trailing: Visibility(
            visible: displayTrailing,
            child: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}

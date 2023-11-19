import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Function onViewAllPressed;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onViewAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          TextButton(
            onPressed: () {
              onViewAllPressed();
            },
            child: const Text('View all'),
          ),
        ],
      ),
    );
  }
}

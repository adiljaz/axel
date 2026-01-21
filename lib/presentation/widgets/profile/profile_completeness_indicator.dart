// presentation/widgets/profile/profile_completeness_indicator.dart
import 'package:flutter/material.dart';

class ProfileCompletenessIndicator extends StatelessWidget {
  final double completeness;

  const ProfileCompletenessIndicator({
    super.key,
    required this.completeness,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Profile Completeness',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '${completeness.toStringAsFixed(0)}%',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: completeness / 100,
            minHeight: 10,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
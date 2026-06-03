import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class FeatureTile extends StatelessWidget {
  const FeatureTile({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    required this.scale,
  });

  final String iconAsset;
  final String title;
  final String subtitle;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8 * scale),
      padding: EdgeInsets.symmetric(
        horizontal: 10 * scale,
        vertical: 10 * scale,
      ),
      decoration: BoxDecoration(
        color: AppColors.featureTile,
        borderRadius: BorderRadius.circular(14 * scale),
      ),
      child: Row(
        children: [
          Container(
            width: 42 * scale,
            height: 42 * scale,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10 * scale),
              color: AppColors.featureIconBackground,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10 * scale),
              child: Image.asset(
                iconAsset,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          SizedBox(width: 10 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w700,
                    height: 1.12,
                  ),
                ),
                SizedBox(height: 3 * scale),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11.5 * scale,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

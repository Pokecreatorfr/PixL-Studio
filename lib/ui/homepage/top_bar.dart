import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pixlstudio/defines/colors.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.secondary,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/logo.svg',
            height: 30,
          ),
          IconButton(
              onPressed: () {
                // open settings
              },
              icon: const Icon(Icons.settings, color: Colors.white, size: 30)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PostogramAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PostogramAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Image.asset(
        'assets/images/logo.png',
        width: 140,
        color: Theme.of(context).colorScheme.primary,
      ),
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(
              'assets/icons/more.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
            )),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 96);
}

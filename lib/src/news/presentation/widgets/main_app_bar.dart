import 'package:circle_flags/circle_flags.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:share_plus/share_plus.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showCountrySelector;
  final String? countryCode;
  final String? contentShare;
  final Function(String code)? onCountrySelected;

  const MainAppBar({
    super.key,
    required this.onCountrySelected,
    required this.countryCode,
    required this.showCountrySelector,
    this.contentShare,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              const Text('WorldIn'),
              Text(
                'News'.tr,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
      centerTitle: false,
      elevation: 0.0,
      leading: showCountrySelector ? const Icon(Iconsax.search_normal_1) : null,
      actions: [
        if (showCountrySelector)
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  CircleFlag(
                    countryCode!,
                    size: 24,
                  ),
                ],
              ),
            ),
            onTap: () {
              showCountryPicker(
                context: context,
                showPhoneCode: false,
                onSelect: (Country country) {
                  onCountrySelected!(country.countryCode);
                },
              );
            },
          ),
        if (!showCountrySelector)
          GestureDetector(
            onTap: () async {
              final result = await Share.shareWithResult(contentShare!);
              if (result.status == ShareResultStatus.success) {}
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.share),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:circle_flags/circle_flags.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:iconsax/iconsax.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? countryCode;
  final Function(String code)? onCountrySelected;

  const MainAppBar({
    super.key,
    required this.onCountrySelected,
    required this.countryCode,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      centerTitle: true,
      elevation: 0.0,
      leading: countryCode != null ? const Icon(Iconsax.search_normal_1) : null,
      actions: [
        if (countryCode != null)
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
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

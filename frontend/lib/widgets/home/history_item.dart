import 'package:crytojay/config/extension/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CryptoItem extends ConsumerWidget {
  const CryptoItem({
    required this.label,
    required this.tapCrypto,
    required this.tapDate,
    required this.color,
    super.key,
  });
  final String label;
  final VoidCallback tapCrypto;
  final VoidCallback tapDate;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ElevatedButton(
        onPressed: tapCrypto,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colorScheme.onBackground.withOpacity(0.6),
          foregroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: context.colorScheme.outline,
              width: 0.5,
            ),
          ),
          padding: const EdgeInsets.all(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: Center(
                  child: Icon(
                Icons.monetization_on,
                color: Colors.black,
              )),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodyMedium!.copyWith(
                  color:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.95),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                IconlyLight.star,
                color: context.colorScheme.onSecondary,
              ),
              onPressed: tapDate,
            ),
            
            IconButton(
              icon: Icon(
                IconlyLight.calendar,
                color: context.colorScheme.onSecondary,
              ),
              onPressed: tapDate,
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:novelist_app_ver2/src/widgets/unsplash_picker_dialog.dart';

class AssetPickerDialog extends StatelessWidget {
  const AssetPickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change Cover'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(LucideIcons.search, color: Colors.purpleAccent),
              title: const Text('Search on the Web'),
              onTap: () async {
                // Pop the current dialog first
                Navigator.of(context).pop();
                // Show the Unsplash picker dialog and wait for a result
                final result = await showDialog<String>(
                  context: context,
                  builder: (context) => const UnsplashPickerDialog(),
                );

                if (result != null) {
                  // If a result was returned, you can use it here.
                  // For now, we just print it.
                  print('Selected image from Unsplash: $result');
                  // TODO: Pass this result back to the ProjectScreen to update the project cover
                }
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.imageUp, color: Colors.blueAccent),
              title: const Text('Upload from Device'),
              onTap: () {
                // TODO: Implement image upload
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.shapes, color: Colors.greenAccent),
              title: const Text('Choose Icon'),
              onTap: () {
                // TODO: Implement icon picker
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.smile, color: Colors.amberAccent),
              title: const Text('Choose Emoji'),
              onTap: () {
                // TODO: Implement emoji picker
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/signup_notifier.dart';

class UploadImageActionSheet extends ConsumerWidget {
  const UploadImageActionSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasimage =
        ref.watch(signupProvider.select((value) => value.file != null));
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          onPressed: () async {
            await ref.read(signupProvider.notifier).setCameraImage();
            Navigator.of(context).pop();
          },
          child: const Text('Camera'),
        ),
        CupertinoActionSheetAction(
          onPressed: () async {
            await ref.read(signupProvider.notifier).setGalleryImage();
            Navigator.of(context).pop();
          },
          child: const Text('Gallery'),
        ),
        if (hasimage)
          CupertinoActionSheetAction(
            onPressed: () {
              ref.read(signupProvider.notifier).removeImage();
              Navigator.of(context).pop();
            },
            child: const Text('Remove Image'),
            isDestructiveAction: true,
          ),
      ],
    );
  }
}

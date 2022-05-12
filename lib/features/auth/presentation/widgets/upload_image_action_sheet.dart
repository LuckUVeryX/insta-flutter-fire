import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/signup_notifier.dart';

class UploadImageActionSheet extends StatefulHookConsumerWidget {
  const UploadImageActionSheet({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UploadImageActionSheetState();
}

class _UploadImageActionSheetState
    extends ConsumerState<UploadImageActionSheet> {
  @override
  Widget build(BuildContext context) {
    final hasimage =
        ref.watch(signupProvider.select((value) => value.file != null));
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          onPressed: () async {
            await ref.read(signupProvider.notifier).setCameraImage();
            if (!mounted) return;
            Navigator.of(context).pop();
          },
          child: const Text('Camera'),
        ),
        CupertinoActionSheetAction(
          onPressed: () async {
            await ref.read(signupProvider.notifier).setGalleryImage();
            if (!mounted) return;
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
            isDestructiveAction: true,
            child: const Text('Remove Image'),
          ),
      ],
    );
  }
}

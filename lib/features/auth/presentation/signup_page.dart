import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/image_path.dart';
import '../models/models.dart';
import 'notifiers/signup_notifier.dart';
import 'widgets/widgets.dart';

class SignupPage extends HookWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final usernameController = useTextEditingController();
    final bioController = useTextEditingController();

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Consumer(builder: (context, ref, __) {
                    final image =
                        ref.watch(signupProvider.select((info) => info.file));

                    final exception = ref
                        .watch(signupProvider.select((info) => info.exception));

                    final isLoading = ref
                        .watch(signupProvider.select((info) => info.isLoading));

                    ref.listen<SignupInfo>(
                      signupProvider,
                      (previous, next) {
                        final exception = next.exception;
                        if (exception is! AuthException || !exception.isField) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(exception?.message ?? '')),
                          );
                        }
                      },
                    );

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 32.0),
                        SvgPicture.asset(
                          ImagePath.kInstagramLogo,
                          height: 64.0,
                          color: colorScheme.onBackground,
                        ),
                        const SizedBox(height: 32.0),
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundImage:
                                  image != null ? MemoryImage(image) : null,
                              child: image != null
                                  ? null
                                  : Icon(
                                      Icons.person,
                                      size: 80.0,
                                      color: colorScheme.surfaceVariant,
                                    ),
                              backgroundColor: colorScheme.onSurfaceVariant,
                            ),
                            Positioned(
                              bottom: -10,
                              right: 0,
                              child: IconButton(
                                onPressed: () {
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (_) =>
                                        const UploadImageActionSheet(),
                                  );
                                },
                                icon: const Icon(Icons.add_a_photo),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 32.0),
                        AuthTextField(
                          textInputType: TextInputType.text,
                          controller: usernameController,
                          hintText: 'Enter your username',
                          onChanged:
                              ref.read(signupProvider.notifier).setUsername,
                          errorText: exception is AuthUsernameException
                              ? exception.message
                              : null,
                        ),
                        AuthTextField(
                          textInputType: TextInputType.emailAddress,
                          controller: emailController,
                          hintText: 'Enter your email',
                          errorText: exception is AuthEmailException
                              ? exception.message
                              : null,
                          onChanged: ref.read(signupProvider.notifier).setEmail,
                        ),
                        AuthTextField(
                          textInputType: TextInputType.text,
                          controller: passwordController,
                          hintText: 'Enter your password',
                          obscureText: true,
                          errorText: exception is AuthPasswordException
                              ? exception.message
                              : null,
                          onChanged:
                              ref.read(signupProvider.notifier).setPassword,
                        ),
                        AuthTextField(
                          textInputType: TextInputType.text,
                          controller: bioController,
                          hintText: 'Enter your bio',
                          onChanged: ref.read(signupProvider.notifier).setBio,
                          textInputAction: TextInputAction.done,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: isLoading
                              ? const SizedBox(
                                  height: 28.0,
                                  child:
                                      Center(child: LinearProgressIndicator()),
                                )
                              : ElevatedButton(
                                  onPressed: exception != null
                                      ? null
                                      : ref
                                          .read(signupProvider.notifier)
                                          .signUpWithEmailPassword,
                                  child: const Text('Sign up'),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

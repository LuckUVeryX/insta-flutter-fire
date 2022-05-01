import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/image_path.dart';
import '../repositories/auth_repository.dart';
import 'notifiers/signup_notifier.dart';
import 'widgets/widgets.dart';

class SignupPage extends HookWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
                    final signupInfo = ref.watch(signupProvider);

                    final bool hasImage = signupInfo.file != null &&
                        signupInfo.file?.isNotEmpty == true;

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
                              backgroundImage: hasImage
                                  ? MemoryImage(signupInfo.file!)
                                  : null,
                              child: hasImage
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
                        ),
                        AuthTextField(
                          textInputType: TextInputType.text,
                          controller: bioController,
                          hintText: 'Enter your bio',
                          onChanged: ref.read(signupProvider.notifier).setBio,
                        ),
                        AuthTextField(
                          textInputType: TextInputType.emailAddress,
                          controller: emailController,
                          hintText: 'Enter your email',
                          errorText: signupInfo.exception
                                      is AuthExceptionEmailAlreadyInUse ||
                                  signupInfo.exception
                                      is AuthExceptionInvalidEmail
                              ? signupInfo.exception?.message
                              : null,
                          onChanged: ref.read(signupProvider.notifier).setEmail,
                        ),
                        AuthTextField(
                          textInputType: TextInputType.text,
                          controller: passwordController,
                          hintText: 'Enter your password',
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          errorText:
                              signupInfo.exception is AuthExceptionWeakPassword
                                  ? signupInfo.exception?.message
                                  : null,
                          onChanged:
                              ref.read(signupProvider.notifier).setPassword,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: ElevatedButton(
                            onPressed: ref
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
                        RichText(
                          text: TextSpan(
                            style: textTheme.bodyMedium,
                            children: [
                              const TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: 'Sign up.',
                                style: textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                            ],
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

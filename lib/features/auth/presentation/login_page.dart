import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../router/app_router.gr.dart';
import '../../../utils/image_path.dart';
import '../models/models.dart';
import 'notifiers/login_notifier.dart';
import 'widgets/auth_text_field.dart';

class LoginPage extends HookWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Consumer(builder: (_, ref, __) {
            final exception =
                ref.watch(loginProvider.select((value) => value.exception));

            ref.listen<LoginState>(loginProvider, (previous, next) {
              final exception = next.exception;
              if (exception != null && exception.isField == false) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(next.exception!.message!)),
                );
              }
            });
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                SvgPicture.asset(
                  ImagePath.kInstagramLogo,
                  height: 64.0,
                  color: colorScheme.onBackground,
                ),
                const SizedBox(height: 24.0),
                AuthTextField(
                  textInputType: TextInputType.emailAddress,
                  controller: emailController,
                  hintText: 'Enter your email',
                  errorText: exception is AuthEmailException
                      ? exception.message
                      : null,
                  onChanged: ref.read(loginProvider.notifier).setEmail,
                ),
                AuthTextField(
                  textInputType: TextInputType.text,
                  controller: passwordController,
                  hintText: 'Enter your password',
                  obscureText: true,
                  errorText: exception is AuthPasswordException
                      ? exception.message
                      : null,
                  onChanged: ref.read(loginProvider.notifier).setPassword,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Consumer(builder: (_, ref, __) {
                    final isLoading = ref.watch(
                        loginProvider.select((value) => value.isLoading));

                    return isLoading
                        ? const LinearProgressIndicator()
                        : ElevatedButton(
                            onPressed: ref
                                .read(loginProvider.notifier)
                                .loginUserWithEmailPassword,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                            child: const Text('Log in'),
                          );
                  }),
                ),
                const Spacer(),
              ],
            );
          }),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        width: double.infinity,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: textTheme.bodyMedium,
            children: [
              const TextSpan(text: "Don't have an account? "),
              TextSpan(
                text: 'Sign up.',
                style:
                    textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => context.router.push(const SignupRoute()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

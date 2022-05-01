import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/image_path.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset(
                ImagePath.kInstagramLogo,
                height: 64.0,
                color: colorScheme.onBackground,
              ),
              const SizedBox(height: 64.0),
              AuthTextField(
                textInputType: TextInputType.emailAddress,
                controller: emailController,
                hintText: 'Enter your email',
              ),
              const SizedBox(height: 24.0),
              AuthTextField(
                textInputType: TextInputType.text,
                controller: passwordController,
                hintText: 'Enter your password',
                obscureText: true,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Log in'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 2),
              RichText(
                text: TextSpan(
                  style: textTheme.bodyMedium,
                  children: [
                    const TextSpan(text: "Don't have an account? "),
                    TextSpan(
                      text: 'Sign up.',
                      style: textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

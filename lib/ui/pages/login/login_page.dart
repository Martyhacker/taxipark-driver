import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taxipark_driver/core/api/providers/auth_provider.dart';
import 'package:taxipark_driver/core/routes/routes.dart';
import 'package:taxipark_driver/core/utils/form_field_validator.dart';
import 'package:taxipark_driver/generated/locale_keys.g.dart';

import '../../../core/constants/constants.dart';
import '../../../core/style/palette.dart';
import '../../../core/style/shadows.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _tecPhone = TextEditingController();
  final _tecPassword = TextEditingController();
  void _onError() {
    ScaffoldMessenger.maybeOf(context)
        ?.showSnackBar(const SnackBar(content: Text("Error occured")));
  }

  void _onSuccess() {
    Navigator.pushReplacementNamed(context, Routes.home);
  }

  _login() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthProvider>().login(
          phoneNumber: _tecPhone.text,
          password: _tecPassword.text,
          onLogin: _onSuccess,
          onError: _onError);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LocaleKeys.authorization_login.tr(),
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                    color: Palette.lightGrey,
                    borderRadius: kDefaultBorderRadius,
                    boxShadow: Shadows.defaultShadow),
                child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.authorization_phone.tr(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          controller: _tecPhone,
                          validator: CustomFormFieldValidator().phoneValidator,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 8,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              filled: true,
                              counterText: '',
                              fillColor: Palette.white,
                              prefixText: "+993 ",
                              hintText: "62454994",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        const SizedBox(height: 30),
                        Text(LocaleKeys.authorization_password.tr(),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextFormField(
                          controller: _tecPassword,
                          validator: CustomFormFieldValidator().isNotEmpty,
                          obscureText: true,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              filled: true,
                              hintText: "********",
                              fillColor: Palette.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: () {
                  _login.call();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                      color: Palette.yellow,
                      borderRadius: kDefaultBorderRadius,
                      boxShadow: Shadows.defaultShadow),
                  child: Text(
                    LocaleKeys.authorization_login.tr(),
                    style: const TextStyle(color: Palette.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

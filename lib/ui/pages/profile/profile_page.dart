import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:taxipark_driver/core/api/providers/auth_provider.dart';
import 'package:taxipark_driver/core/constants/constants.dart';
import 'package:taxipark_driver/core/routes/routes.dart';
import 'package:taxipark_driver/core/style/icon_assets.dart';
import 'package:taxipark_driver/core/style/palette.dart';
import 'package:taxipark_driver/core/style/shadows.dart';
import 'package:taxipark_driver/core/utils/form_field_validator.dart';
import 'package:taxipark_driver/generated/locale_keys.g.dart';

import '../../widgets/default_appbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _tecUsername = TextEditingController();
  final _tecPhone = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    setState(() => isLoading = true);
    _fetchProfile.call();
  }

  _fetchProfile() {
    context.read<AuthProvider>().profile(onSuccess: () {
      _tecUsername.text = context.read<AuthProvider>().username;
      _tecPhone.text = context.read<AuthProvider>().phoneNumber;
      setState(() => isLoading = false);
    });
  }

  _onLogout() {
    context.read<AuthProvider>().logout(onSuccess: () {
      Navigator.pushReplacementNamed(context, Routes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(actions: [
        IconButton(
            onPressed: () {
              _onLogout.call();
            },
            icon: const Icon(Icons.logout, color: Colors.black))
      ], title: LocaleKeys.drawer_myAccount.tr()),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SvgPicture.asset(IconAssets.profile),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.all(25),
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
                              LocaleKeys.authorization_username.tr(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              controller: _tecUsername,
                              validator: CustomFormFieldValidator().isNotEmpty,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  filled: true,
                                  fillColor: Palette.white,
                                  hintText: "Kemal",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            const SizedBox(height: 40),
                            Text(
                              LocaleKeys.authorization_phone.tr(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              controller: _tecPhone,
                              readOnly: true,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  filled: true,
                                  fillColor: Palette.white,
                                  // prefixText: "+993 ",
                                  hintText: "62454994",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            const SizedBox(height: 30),
                          ],
                        )),
                  )
                ],
              ),
            ),
    );
  }
}

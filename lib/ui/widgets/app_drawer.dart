// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:taxipark_driver/core/style/image_assets.dart';
// import 'package:taxipark_driver/core/style/palette.dart';
// import 'package:taxipark_driver/generated/locale_keys.g.dart';
// import 'package:taxipark_driver/ui/pages/my_orders/my_orders_page.dart';
// import 'package:taxipark_driver/ui/pages/profile/profile_page.dart';

// class AppDrawer extends StatelessWidget {
//   const AppDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topRight: Radius.circular(15), bottomRight: Radius.circular(15))),
//       backgroundColor: Palette.grey,
//       child: ListView(
//         children: [
//           const DrawerHeader(
//               child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     Icons.account_circle_outlined,
//                     size: 46,
//                     color: Palette.white,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Kemal",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       Text(
//                         "+99362454994",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ],
//                   )
//                 ],
//               )
//             ],
//           )),
//           InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const ProfilePage()));
//               },
//               child: ListTile(
//                 title: Text(LocaleKeys.drawer_myAccount.tr()),
//                 textColor: Palette.white,
//               )),
//           InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const MyOrdersPage()));
//               },
//               child: ListTile(
//                 title: Text(
//                   LocaleKeys.drawer_orderHistory.tr(),
//                 ),
//                 textColor: Palette.white,
//               )),
//           const Divider(color: Colors.white),
//           ListTile(
//             title: Text(
//               LocaleKeys.drawer_rateCompany.tr(),
//             ),
//             textColor: Palette.white,
//           ),
//           ListTile(
//             title: Text(LocaleKeys.drawer_aboutUs.tr()),
//             textColor: Palette.white,
//           ),
//           ExpansionTile(
//             title: Text(
//               LocaleKeys.drawer_changeLanguage.tr(),
//             ),
//             textColor: Palette.white,
//             collapsedTextColor: Palette.white,
//             iconColor: Palette.white,
//             collapsedIconColor: Palette.white,
//             children: [
//               ListTile(
//                 onTap: () {
//                   context.setLocale(const Locale("tr", "TR"));
//                 },
//                 leading: Image.asset(
//                   ImageAssets.turkmenistan,
//                   width: 32,
//                 ),
//                 title: const Text("Turkmen"),
//                 textColor: Palette.white,
//               ),
//               ListTile(
//                 onTap: () {
//                   context.setLocale(const Locale("ru", "RU"));
//                 },
//                 leading: Image.asset(
//                   ImageAssets.russia,
//                   width: 32,
//                 ),
//                 title: const Text("Rus"),
//                 textColor: Palette.white,
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

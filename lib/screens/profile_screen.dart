import 'package:delivery/constract/image_string.dart';
import 'package:delivery/utils/user_preferences.dart';
import 'package:delivery/widgets/Edit_profile_button.dart';
import 'package:delivery/widgets/profile_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:delivery/model/user.dart';
import '../constract/color_string.dart';
import '../model/user.dart';
import '../widgets/profile_menu.dart';
import '../widgets/text_field_widget.dart';
import 'edit_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const screenRoute = 'profile_screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User1 user = UserPrefernces.myUser;
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AOUbackground,
        appBar: AppBar(
          backgroundColor: AOUAppBar,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(LineAwesomeIcons.arrow_circle_left)),
          title: Text('Profile', style: Theme.of(context).textTheme.headline4),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(
                          image: AssetImage(AOUlogo),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: const Icon(
                          LineAwesomeIcons.alternate_pencil,
                          size: 20,
                          color: AOUAppBar,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Name',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  'E-mail',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, EditProfileScreen.screenRoute);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AOUAppBar,
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: const Text(
                        'Edit profile',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                    //MyButton(title: 'Edit Profile', onPressed: () {}),
                    ),
                const SizedBox(
                  height: 30,
                ),
                // const Divider(),
                // const SizedBox(
                //   height: 10,
                // ),
                // ProfileMenuWidget(
                //   title: 'Setting',
                //   icon: LineAwesomeIcons.cog,
                //   onPress: () {},
                // ),
                // ProfileMenuWidget(
                //   title: 'Billing Details',
                //   icon: LineAwesomeIcons.wallet,
                //   onPress: () {},
                // ),
                // ProfileMenuWidget(
                //   title: 'User Managment',
                //   icon: LineAwesomeIcons.user_check,
                //   onPress: () {},
                // ),
                // const Divider(
                //   color: Colors.grey,
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // ProfileMenuWidget(
                //   title: 'Infotmation',
                //   icon: LineAwesomeIcons.info,
                //   onPress: () {},
                // ),
                ProfileMenuWidget(
                  title: 'Logout',
                  icon: LineAwesomeIcons.alternate_sign_out,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          ),
        ),
      );
}





//   Scaffold(
//         appBar: AppBar(
//           backgroundColor: AOUAppBar,
//           leading: IconButton(
//               onPressed: () {},
//               icon: const Icon(LineAwesomeIcons.arrow_circle_left)),
//           title: Text('Edit Profile',
//               style: Theme.of(context).textTheme.headline4),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(50),
//           child: ListView(
//             padding: EdgeInsets.symmetric(horizontal: 32),
//             physics: BouncingScrollPhysics(),
//             children: [
//               ProfileWidget(
//                   imagePath: user.imagePath,
//                   isEdit: true,
//                   onClicked: () async {}),
//               const SizedBox(
//                 height: 24,
//               ),
//               TextFieldWidget(
//                   label: 'Full Name',
//                   text: user.name,
//                   onChanged: (name) => user = user.copy(name: name)),
//               const SizedBox(
//                 height: 24,
//               ),
//               TextFieldWidget(
//                   label: 'Email',
//                   text: user.email,
//                   onChanged: (email) => user = user.copy(email: email)),
//               const SizedBox(
//                 height: 24,
//               ),
//               TextFieldWidget(
//                   label: 'Phone Number',
//                   text: user.phoneNumber,
//                   onChanged: (phoneNumber) =>
//                       user = user.copy(phoneNumber: phoneNumber)),
//               SizedBox(
//                 height: 24,
//               ),
//               ButtonWidget(
//                   text: 'Save',
//                   onClicked: () {
//                     UserPrefernces.setUser(user);
//                     Navigator.of(context).pop();
//                   })
//             ],
//           ),
//         ),
//       );
// }

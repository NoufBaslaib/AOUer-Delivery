import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/constract/color_string.dart';
import 'package:delivery/constract/image_string.dart';
import 'package:delivery/screens/profile_screen.dart';
import 'package:delivery/screens/update_profile_screen.dart';
import 'package:delivery/screens/welcome_screen.dart';
import 'package:delivery/utils/user_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:delivery/widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:delivery/model/user.dart';
import '../widgets/Edit_profile_button.dart';
import '../widgets/profile_menu.dart';
import '../widgets/profile_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:collection/collection.dart';
import 'dart:collection';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfileScreen extends StatefulWidget {
  static const screenRoute = 'edit_profile_screen';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  //const ProfileScreen({super.key});
  String? profilePic;
  TextEditingController name = TextEditingController();
  //TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // addData() async {
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   await firebaseFirestore.collection('users');
  // }

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (FirebaseAuth.instance.currentUser!.displayName == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('please comblete the profile first')));
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
          name.text = snapshot['name'];
          phone.text = snapshot['phone'];
          profilePic = snapshot['profilePic'];
        });
      }
    });
    super.initState();
  }
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AOUAppBar,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(LineAwesomeIcons.arrow_circle_left)),
        title: Text('Profile', style: Theme.of(context).textTheme.headline4),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        final XFile? pickImage = await ImagePicker().pickImage(
                            source: ImageSource.gallery, imageQuality: 50);

                        if (pickImage != null) {
                          setState(() {
                            profilePic = pickImage.path;
                          });
                        }
                      },
                      child: Container(
                        child: profilePic == null
                            ? CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.grey,
                                child: Image.asset(
                                  AOUlogo,
                                  height: 80,
                                  width: 80,
                                ),
                              )
                            : CircleAvatar(
                                radius: 70,
                                backgroundImage: FileImage(File(profilePic!)),
                              ),
                      ),
                    ),
                  ),
                  Text(
                  user.email!,
                  style: Theme.of(context).textTheme.headline6,
                ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: name,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: 'Name',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Enter your name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 26),
                  //   child: Container(
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 20),
                  //       child: TextFormField(
                  //           controller: email,
                  //           decoration: InputDecoration(
                  //             prefixIcon: Icon(Icons.email),
                  //             hintText: 'Email',
                  //             contentPadding: EdgeInsets.symmetric(
                  //                 vertical: 10, horizontal: 20),
                  //             border: OutlineInputBorder(
                  //               borderRadius: BorderRadius.all(
                  //                 Radius.circular(10),
                  //               ),
                  //             ),
                  //             enabledBorder: OutlineInputBorder(
                  //               borderSide:
                  //                   BorderSide(color: Colors.grey, width: 1),
                  //               borderRadius: BorderRadius.all(
                  //                 Radius.circular(10),
                  //               ),
                  //             ),
                  //           ),
                  //           validator: (v) {
                  //             if (v!.isEmpty) {
                  //               return 'Enter your Email';
                  //             }
                  //             return null;
                  //           }),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                            controller: phone,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone),
                              hintText: 'Phone number',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return 'Enter your phone number';
                              }
                              return null;
                            }),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: StadiumBorder(),
                        onPrimary: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 12)),
                    child: Text('Save'),
                    onPressed: () async {
                      //await addData();
                      if (formKey.currentState!.validate()) {
                        SystemChannels.textInput
                            .invokeListMethod('TextInput.hide');

                        profilePic == null
                            ? ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('select profile pic')))
                            : saveInfo();
                      }
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: StadiumBorder(),
                        onPrimary: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 12)),
                    child: Text('Sign Out'),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.canPop(context) ? Navigator.pop(context) : null;
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => WelcomeScreen()));
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? downloadUrl;
  Future<String?> uploadImage(File filepath, String? reference) async {
    try {
      final finalName =
          '${FirebaseAuth.instance.currentUser!.uid}${DateTime.now().second}';
      final Reference fbStorage =
          FirebaseStorage.instance.ref(reference).child(finalName);
      final UploadTask uploadTask = fbStorage.putFile(filepath);
      await uploadTask.whenComplete(() async {
        downloadUrl = await fbStorage.getDownloadURL();
      });

      return downloadUrl;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  saveInfo() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore.collection('users');
    uploadImage(File(profilePic!), 'profile').whenComplete(() {
      Map<String, dynamic> data = {
        'name': name.text,
        //'email': email.text,
        'phone': phone.text,
        'profilePic': downloadUrl
      };

      //when i need this information for checkout:
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(data)
          .whenComplete(() {
        FirebaseAuth.instance.currentUser!.updateDisplayName(name.text);
      });
    });
  }
}































































































































































































//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AOUbackground,
//       appBar: AppBar(
//         backgroundColor: AOUAppBar,
//         leading: IconButton(
//             onPressed: () {},
//             icon: const Icon(LineAwesomeIcons.arrow_circle_left)),
//         title: Text('Profile', style: Theme.of(context).textTheme.headline4),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   SizedBox(
//                     width: 120,
//                     height: 120,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(100),
//                       child: const Image(
//                         image: AssetImage(AOUlogo),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: Container(
//                       width: 35,
//                       height: 35,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100),
//                         color: Colors.grey.withOpacity(0.1),
//                       ),
//                       child: const Icon(
//                         LineAwesomeIcons.alternate_pencil,
//                         size: 20,
//                         color: AOUAppBar,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 'Name',
//                 style: Theme.of(context).textTheme.headlineSmall,
//               ),
//               Text(
//                 'E-mail',
//                 style: Theme.of(context).textTheme.headline6,
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                   width: 200,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(
//                           context, UpdateProfileScreen.screenRoute);
//                     },
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: AOUAppBar,
//                         side: BorderSide.none,
//                         shape: const StadiumBorder()),
//                     child: const Text(
//                       'Edit profile',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   )
//                   //MyButton(title: 'Edit Profile', onPressed: () {}),
//                   ),
//               const SizedBox(
//                 height: 30,
//               ),
//               // const Divider(),
//               // const SizedBox(
//               //   height: 10,
//               // ),
//               // ProfileMenuWidget(
//               //   title: 'Setting',
//               //   icon: LineAwesomeIcons.cog,
//               //   onPress: () {},
//               // ),
//               // ProfileMenuWidget(
//               //   title: 'Billing Details',
//               //   icon: LineAwesomeIcons.wallet,
//               //   onPress: () {},
//               // ),
//               // ProfileMenuWidget(
//               //   title: 'User Managment',
//               //   icon: LineAwesomeIcons.user_check,
//               //   onPress: () {},
//               // ),
//               // const Divider(
//               //   color: Colors.grey,
//               // ),
//               // const SizedBox(
//               //   height: 10,
//               // ),
//               // ProfileMenuWidget(
//               //   title: 'Infotmation',
//               //   icon: LineAwesomeIcons.info,
//               //   onPress: () {},
//               // ),
//               ProfileMenuWidget(
//                 title: 'Logout',
//                 icon: LineAwesomeIcons.alternate_sign_out,
//                 textColor: Colors.red,
//                 endIcon: false,
//                 onPress: () {
//                   FirebaseAuth.instance.signOut();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

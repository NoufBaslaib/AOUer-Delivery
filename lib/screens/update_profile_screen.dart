import 'package:delivery/screens/profile_screen.dart';
import 'package:delivery/widgets/my_button.dart';
import 'package:delivery/widgets/text_feiled_widget.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../constract/color_string.dart';
import '../constract/image_string.dart';

class UpdateProfileScreen extends StatelessWidget {
  static const String screenRoute = 'update_profile_screen';
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AOUbackground,
      appBar: AppBar(
        backgroundColor: AOUAppBar,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, ProfileScreen.screenRoute);
            },
            icon: const Icon(LineAwesomeIcons.arrow_circle_left)),
        title:
            Text('Edit Profile', style: Theme.of(context).textTheme.headline4),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const Image(
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
                      LineAwesomeIcons.camera,
                      size: 20,
                      color: AOUAppBar,
                    ),
                  ),
                )
              ]),
              const SizedBox(
                height: 50,
              ),
              Form(
                  child: Column(
                children: [
                  FillTextWidget(
                      title: 'Enter your Name',
                      icon: Icons.person,
                      onChanged: () {}),
                  FillTextWidget(
                      title: 'Enter your Email',
                      icon: Icons.email,
                      onChanged: () {}),
                  FillTextWidget(
                      title: 'Enter your number',
                      icon: Icons.phone,
                      onChanged: () {}),
                  FillTextWidget(
                      title: 'Enter your password',
                      icon: Icons.lock,
                      onChanged: () {}),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: MyButton(title: 'Edit profile', onPressed: () {}))
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

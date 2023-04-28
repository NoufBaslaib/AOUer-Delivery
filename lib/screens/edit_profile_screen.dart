import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/constract/color_string.dart';
import 'package:delivery/constract/image_string.dart';
import 'package:delivery/screens/choose_location_screen.dart';
import 'package:delivery/screens/recieve_order_page.dart';
import 'package:delivery/screens/registration_screen.dart';
import 'package:delivery/screens/type_order_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class EditProfileScreen extends StatefulWidget {
  var userType;

  EditProfileScreen({required this.userType});

  static const screenRoute = 'edit_profile_screen';
  String id = FirebaseAuth.instance.currentUser!.uid;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? profilePic;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  final JosKeys3 = GlobalKey<FormState>();

  void navigateToScreen() {
    print('Value of widget.userType:${widget.userType}');
    if (widget.userType == 'customer') {
      print('meow');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GoogleMapScreen(),
        ),
      );
      print('nouf');
    } else if (widget.userType == 'driver') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReceiveOrderPage(),
        ),
      );
    }
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
              key: JosKeys3,
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
                      if (JosKeys3.currentState!.validate()) {
                        SystemChannels.textInput
                            .invokeListMethod('TextInput.hide');

                        if (profilePic == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('select profile pic')));
                        } else {
                          saveInfo();
                          navigateToScreen();
                        }
                      }
                    },
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
                    child: Text('Sign Out'),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.canPop(context) ? Navigator.pop(context) : null;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => RegistrationScreen()));
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
    if (widget.userType == 'driver') {
      var collectionRef = FirebaseFirestore.instance.collection('drivers');
      var documentId = FirebaseAuth.instance.currentUser!.uid;
      var documentRef = collectionRef.doc(documentId);
      uploadImage(File(profilePic!), 'profile').whenComplete(() {
        documentRef.update({
          'name': name.text,
          'phone': phone.text,
          'id': widget.id,
          'profilePic': downloadUrl,
        });
      });
    } else if (widget.userType == 'customer') {
      var collectionRef = FirebaseFirestore.instance.collection('customers');
      var documentId = FirebaseAuth.instance.currentUser!.uid;
      var documentRef = collectionRef.doc(documentId);
      uploadImage(File(profilePic!), 'profile').whenComplete(() {
        documentRef.update({
          'name': name.text,
          'phone': phone.text,
          'id': widget.id,
          'profilePic': downloadUrl,
        });
      });
    }
    // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    // if(widget.userType == 'driver'){
    //   await firebaseFirestore.collection('drivers');
    //   uploadImage(File(profilePic!), 'profile').whenComplete(() {
    //     Map<String, dynamic> data = {
    //       'name': name.text,
    //       'email': user.email!,
    //       'phone': phone.text,
    //       'id' : widget.id,
    //       'profilePic': downloadUrl
    //     };
    //
    //     //when i need this information for checkout:
    //     FirebaseFirestore.instance
    //         .collection('drivers')
    //         .doc(FirebaseAuth.instance.currentUser!.uid)
    //         .set(data)
    //         .whenComplete(() {
    //       FirebaseAuth.instance.currentUser!.updateDisplayName(name.text);
    //     });
    //   });
  }
}

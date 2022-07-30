import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_profile_app/views/your_about_ui.dart';
import 'package:my_profile_app/views/your_email_ui.dart';
import 'package:my_profile_app/views/your_name_ui.dart';
import 'package:my_profile_app/views/your_phone_ui.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  TextEditingController yournameCtrl = TextEditingController(text: '');
  TextEditingController yourphoneCtrl = TextEditingController(text: '');
  TextEditingController youremailCtrl = TextEditingController(text: '');
  TextEditingController youraboutCtrl = TextEditingController(text: '');

  File? _image;
  getImageFromCameraAndSaveToSF() async {
    XFile? pickImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickImage != null) {
      setState(() {
        _image = File(pickImage.path);
      });
    }
  }

  getImageFromGalleryAndSaveToSF() async {
    XFile? pickImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      setState(() {
        _image = File(pickImage.path);
      });
    }

    Directory imageDir = await getApplicationDocumentsDirectory();
    String imagePath = imageDir.path;
    var imageName = basename (pickImage!.path);
    File localImage = await File(pickImage.path).copy('$imagePath/$imageName');

    SharedPreferences prefer = await SharedPreferences.getInstance();
    prefer.setString('yourimage', localImage.path);
  }

  check_and_show_data() async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    bool yournameKey = prefer.containsKey('yourname');
    bool yourphoneKey = prefer.containsKey('yourphone');
    bool youremailKey = prefer.containsKey('youremail');
    bool youraboutKey = prefer.containsKey('yourabout');
    bool yourimageKey = prefer.containsKey('yourimage');

    if (yournameKey == true) {
      setState(() {
        yournameCtrl.text = prefer.getString('yourname')!;
      });
    }

    if (yourphoneKey == true) {
      setState(() {
        yourphoneCtrl.text = prefer.getString('yourphone')!;
      });
    }

    if (youremailKey == true) {
      setState(() {
        youremailCtrl.text = prefer.getString('youremail')!;
      });
    }

    if (youraboutKey == true) {
      setState(() {
        youraboutCtrl.text = prefer.getString('yourabout')!;
      });
    }

    if (yourimageKey == true) {
      setState(() {
        _image = File(prefer.getString('yourabout')!);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    check_and_show_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 21, 0, 71),
        title: Text(
          'My Profile',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _image == null
                  ?Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.brown,
                        width: 1.0,
                      ),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/myprofile.png',
                        ),
                      ),
                    ),
                  )
                  :Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.brown,
                        width: 1.0,
                      ),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: FileImage(
                          _image!,
                        ),
                      fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      getImageFromCameraAndSaveToSF();
                    },
                    icon: Icon(
                      Icons.camera_alt_rounded,
                      size: MediaQuery.of(context).size.width * 0.07,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 30.0,
                  left: 30.0,
                ),
                child: TextField(
                  controller: yournameCtrl,
                  readOnly: true,
                  decoration: InputDecoration(
                    label: Text(
                      'Your Name : ',
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Your Name',
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => YourNameUI()),
                        ).then((value) {
                          check_and_show_data();
                        });
                      },
                      icon: Icon(
                        Icons.edit,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 30.0,
                  left: 30.0,
                ),
                child: TextField(
                  controller: yourphoneCtrl,
                  readOnly: true,
                  decoration: InputDecoration(
                    label: Text(
                      'Your Phone : ',
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Your Phone',
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => YourPhoneUI()),
                        ).then((value) {
                          check_and_show_data();
                        });
                      },
                      icon: Icon(
                        Icons.edit,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 30.0,
                  left: 30.0,
                ),
                child: TextField(
                  controller: youremailCtrl,
                  readOnly: true,
                  decoration: InputDecoration(
                    label: Text(
                      'Your Email : ',
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Your Email',
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => YourEmailUI()),
                        ).then((value) {
                          check_and_show_data();
                        });
                      },
                      icon: Icon(
                        Icons.edit,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 30.0,
                  left: 30.0,
                ),
                child: TextField(
                  controller: youraboutCtrl,
                  readOnly: true,
                  decoration: InputDecoration(
                    label: Text(
                      'Your About : ',
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Your About',
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => YourAboutUI()),
                        ).then((value) {
                          check_and_show_data();
                        });
                      },
                      icon: Icon(
                        Icons.edit,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

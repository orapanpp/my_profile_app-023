import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YourAboutUI extends StatefulWidget {
  const YourAboutUI({Key? key}) : super(key: key);

  @override
  State<YourAboutUI> createState() => _YourAboutUIState();
}

class _YourAboutUIState extends State<YourAboutUI> {
  TextEditingController aboutCtrl = TextEditingController(text: '');

Future addYourAboutToSF() async{
  SharedPreferences prefer = await SharedPreferences.getInstance();
  prefer.setString('yourabout', aboutCtrl.text);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Add/Edit Phone Number',
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
        ),
      ),
    ),
    body: Center(
      child: Column(
        children: [
          SizedBox (
              height: 25.0,
            ),
          Text(
            'แนะนำตัวของคุณ',
            style: GoogleFonts.itim(
              fontSize: 35.0,
              color: Colors.black,
            ),
          ),
           SizedBox (
              height: 25.0,
            ),
          Padding(
            padding: const EdgeInsets.only(
              left: 40.0,
              right: 40.0,
            ),
            child: TextField(
              controller: aboutCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'แนะนำตัว',
              hintStyle: TextStyle(
                color: Colors.grey
              ),
              ),
            ),
          ),
           SizedBox (
              height: 25.0,
            ),
            ElevatedButton(
              onPressed: () {
                if (aboutCtrl.text.trim().length == 0) {
                  showDialog(
                    context: context,
                    builder: (context){
                    return AlertDialog(
                      title: Text(
                        'คำเตือน',
                      ),
                    content: Text(
                      'กรุณาแนะนำตัวของคุณด้วย',
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'ตกลง'
                        ),
                        style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 150, 0, 142)
                      ),
                      ),
                    ],
                    );
                    },
                  );

                } else {
                addYourAboutToSF().then((value) {
                  Navigator.pop(context);
                });
                }
                },
              child: Text(
                'บันทึก',
                style: TextStyle(
                fontSize: 18.0
              ),
            ),
            ),
        ],
      ),
      ),
    );
  }
}
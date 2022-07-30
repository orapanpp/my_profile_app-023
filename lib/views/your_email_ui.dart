import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YourEmailUI extends StatefulWidget {
  const YourEmailUI({Key? key}) : super(key: key);

  @override
  State<YourEmailUI> createState() => _YourEmailUIState();
}

class _YourEmailUIState extends State<YourEmailUI> {
  TextEditingController EmailCtrl = TextEditingController(text: '');

Future addYourEmailToSF() async{
  SharedPreferences prefer = await SharedPreferences.getInstance();
  prefer.setString('youremail', EmailCtrl.text);
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
            'ป้อนอีเมลล์ของคุณ',
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
              controller: EmailCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'ป้อนอีเมลล์',
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
                if (EmailCtrl.text.trim().length == 0) {
                  showDialog(
                    context: context,
                    builder: (context){
                    return AlertDialog(
                      title: Text(
                        'คำเตือน',
                      ),
                    content: Text(
                      'กรุณาป้อนอีเมลล์ของคุณด้วย',
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
                addYourEmailToSF().then((value) {
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
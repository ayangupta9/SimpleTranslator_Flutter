// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translation/languages.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(
    MaterialApp(
      title: "TRANSLATION",
      home: Trans(),
    ),
  );
}

class Trans extends StatefulWidget {
  @override
  _TransState createState() => _TransState();
}

class _TransState extends State<Trans> {
  TextEditingController _textEditingController = TextEditingController();
  var translator = new GoogleTranslator();
  var result = "";
  var langlist = new LanguageList();
  var selectedLang;
  var dropDownLang;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: SafeArea(
          child: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            flexibleSpace: Center(
              child: Text(
                "TRANSLATOR",
                style: GoogleFonts.roboto(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 3.0,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.blueAccent,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 170.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(
                      top: 20.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Enter text here:",
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            IconButton(
                              color: Colors.black,
                              icon: Icon(Icons.close),
                              onPressed: () {
                                _textEditingController.clear();
                                setState(() {
                                  result = "";
                                });
                              },
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: 10.0,
                              left: 10.0,
                              right: 10.0,
                            ),
                            child: TextField(
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                              onChanged: (val) {
                                if (val.isEmpty || val == "") {
                                  setState(() {
                                    result = "";
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: 15,
                                  bottom: 11,
                                  top: 5,
                                  right: 15,
                                ),
                              ),
                              autocorrect: true,
                              maxLines: null,
                              maxLength: null,
                              controller: _textEditingController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      100.0,
                                    ),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.black,
                                ),
                              ),
                              onPressed: () {
                                translator
                                    .translate(_textEditingController.text,
                                        to: selectedLang)
                                    .then(
                                  (value) {
                                    setState(
                                      () {
                                        result = value.text;
                                      },
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "Translate",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                50.0,
                              ),
                              color: Colors.white,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: new DropdownButton(
                                hint: Text(
                                  "Select Language",
                                ),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                value: dropDownLang,
                                items: LanguageList.languages.values
                                    .map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(
                                    () {
                                      dropDownLang = val;
                                      selectedLang = LanguageList.languages.keys
                                          .firstWhere(
                                        (element) =>
                                            LanguageList.languages[element] ==
                                            val,
                                        orElse: () => 'auto',
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                      10.0,
                      5.0,
                      10.0,
                      10.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(
                      bottom: 20.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    // color: Colors.grey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(
                            20.0,
                            0.0,
                            20.0,
                            5.0,
                          ),
                          // color: Colors.red,
                          // height: 20.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  if (result != null) {
                                    Clipboard.setData(
                                        new ClipboardData(text: result));
                                    Fluttertoast.showToast(
                                      msg: "Copied to clipboard",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      textColor: Colors.blue,
                                      backgroundColor: Colors.black,
                                    );
                                  }
                                },
                                icon: Icon(
                                  Icons.copy,
                                ),
                              ),

                              // IconButton(
                              //   padding: EdgeInsets.all(0),
                              //   onPressed: () {},
                              //   icon: Icon(
                              //     Icons.volume_up_rounded,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                              child: Text(
                                result,
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

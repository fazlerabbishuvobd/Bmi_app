import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bmi_calculator_app/screens/home_page.dart';
import 'package:bmi_calculator_app/widgets/customDrawer.dart';
import 'package:bmi_calculator_app/widgets/custom_button.dart';
import 'package:bmi_calculator_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserInfoPage extends StatefulWidget {
  UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    _removeSharedPreferences();
    super.initState();
  }

  Future<void> _removeSharedPreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('userName');
    sharedPreferences.remove('userAge');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).welcome,style: customBodyText(Colors.white, 22, FontWeight.bold),),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu_outlined,
              color: IconTheme.of(context).color,
            )),
        backgroundColor: AppBarTheme.of(context).backgroundColor,
      ),

      body: Container(
        padding: const EdgeInsets.all(10),
        height: height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: height * 0.3,
                  width: width * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/hi.jpg'),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                AppLocalizations.of(context).welcomeMessage,
                style: customBodyText(Colors.black, 22, FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),

              // <----------------- TEXT FIELD ----------------------->
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: height * 0.3,
                width: width,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // <----------------- NAME TEXT FIELD ----------------------->
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(width: 2),
                              ),
                              labelText:
                                  AppLocalizations.of(context).textFieldName,
                              labelStyle: customBodyText(
                                  Colors.black, 16, FontWeight.bold),
                              hintText:
                                  AppLocalizations.of(context).textFieldName),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        // <----------------- AGE TEXT FIELD ----------------------->
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: _ageController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(width: 2),
                              ),
                              labelText:
                                  AppLocalizations.of(context).textFieldAge,
                              labelStyle: customBodyText(
                                  Colors.black, 16, FontWeight.bold),
                              hintText:
                                  AppLocalizations.of(context).textFieldAge),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              // <----------------- BUTTON ----------------------->
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // <----------------- CLEAR BUTTON ----------------------->
                  customButton(
                      onPressed: () {
                        _nameController.clear();
                        _ageController.clear();
                      },
                      buttonTxt: AppLocalizations.of(context).clearButton,
                      icons: Icons.clear_all,
                      color:Colors.red),

                  // <----------------- SUBMIT BUTTON ----------------------->
                  customButton(
                      color: Colors.deepPurple,
                      onPressed: () async {
                        if (_nameController.text != '' &&
                            _ageController.text != '') {
                          final sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setString(
                              'userName', '${_nameController.text}');
                          sharedPreferences.setString(
                              'userAge', '${_ageController.text}');

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.white,
                              content: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.deepPurple),
                                child: Text(
                                  AppLocalizations.of(context).snackbar,
                                  style: customBodyText(
                                      Colors.yellow, 16, FontWeight.bold),
                                ),
                              )));
                        }
                      },
                      buttonTxt: AppLocalizations.of(context).submitButton,
                      icons: Icons.send),
                ],
              )
            ],
          ),
        ),
      ),

      // <----------------- DRAWER ----------------------->
      drawer: customDrawer(context),
    );
  }
}

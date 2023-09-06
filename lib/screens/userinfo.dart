import 'package:bmi_calculator_app/screens/home_page.dart';
import 'package:bmi_calculator_app/widgets/customDrawer.dart';
import 'package:bmi_calculator_app/widgets/custom_button.dart';
import 'package:bmi_calculator_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

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
      appBar: _buildAppBar(context),

      body: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        height: height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.welcomeMessage,
                style: customBodyText(Colors.black, 22, FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),

              // <----------------- TEXT FIELD ----------------------->
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: height * 0.22,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNameTextField(context),
                    SizedBox(
                      height: height*0.02,
                    ),
                    
                    _buildAgeTextField(context),
                  ],
                ),
              ),
              SizedBox(
                height: height*0.03,
              ),

              // <----------------- BUTTON ----------------------->
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildClearButton(context),
                  _buildSubmitButton(context),
                ],
              ),
              SizedBox(height: height*0.05,),

              _buildSkipButton(height, width, context)
            ],
          ),
        ),
      ),

      // <----------------- DRAWER ----------------------->
      drawer: customDrawer(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.welcome,style: customBodyText(Colors.white, 22, FontWeight.bold),),
      centerTitle: true,
      leading: IconButton(
          onPressed: (){
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu_outlined, color: IconTheme.of(context).color,)
      ),
      backgroundColor: AppBarTheme.of(context).backgroundColor,
    );
  }

  Widget _buildSkipButton(double height, double width, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: height*0.05,
      width: width*0.7,
      child: ElevatedButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(),));},
        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Skip"),
              Icon(Icons.arrow_forward)
            ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return customButton(
      color: Colors.deepPurple,
      onPressed: () async {
        if (_nameController.text != '' && _ageController.text != '') {
          /// Checking if Null then Show SnackBar otherWise Go to Next Page
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage()));
          
          /// Store UserName and Age
          final sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString('userName', _nameController.text);
          sharedPreferences.setString('userAge', _ageController.text);
          
        } else {
          ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar(context));
        }
      },
      buttonTxt: AppLocalizations.of(context)!.submitButton,
      icons: Icons.send);
  }

  Widget _buildClearButton(BuildContext context) {
    return customButton(
      onPressed: () {
        _nameController.clear();
        _ageController.clear();
      },
      buttonTxt: AppLocalizations.of(context)!.clearButton,
      icons: Icons.clear_all,
      color:Colors.red);
  }

  SnackBar _buildSnackBar(BuildContext context) {
    return SnackBar(
      backgroundColor: Colors.white,
      content: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.deepPurple),
        child: Text(AppLocalizations.of(context)!.snackbar,
          style: customBodyText(Colors.yellow, 16, FontWeight.bold),
        ),
      )
  );
  }

  Widget _buildAgeTextField(BuildContext context) {
    return TextField(
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
          labelText: AppLocalizations.of(context)!.textFieldAge,
          labelStyle: customBodyText(Colors.black, 16, FontWeight.bold),
          hintText: AppLocalizations.of(context)!.textFieldAge),
    );
  }

  Widget _buildNameTextField(BuildContext context) {
    return TextField(
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
          labelText: AppLocalizations.of(context)!.textFieldName,
          labelStyle: customBodyText(Colors.black, 16, FontWeight.bold),
          hintText: AppLocalizations.of(context)!.textFieldName),
    );
  }
}

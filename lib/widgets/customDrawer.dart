import 'package:bmi_calculator_app/contoller/language_provider.dart';
import 'package:bmi_calculator_app/contoller/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget customDrawer(BuildContext context) {
  return SafeArea(
    child: Drawer(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 80,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 50,
                ),
                title: Text('Fazle Rabbi'),
                subtitle: Text('frs.cse@gmail.com'),
              ),
            ),
            const Divider(),
            const Spacer(),
            // <----------------- Change Language & Theme ----------------------->
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // <----------------- Change Language ----------------------->
                const Divider(),
                Consumer<LanguageProvider>(
                  builder: (context, _languageProvider, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Change Language',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('English'),
                          Switch(
                              value: _languageProvider.value,
                              onChanged: (newValue) {
                                _languageProvider.switchVal(newValue);
                                _languageProvider.changeLanguage(newValue);
                              }),
                          Text('বাংলা'),
                        ],
                      )
                    ],
                  ),
                ),
                const Divider(),

                // <----------------- Theme Change ----------------------->
                Consumer<ThemeProvider>(
                  builder: (context, _themeProvider, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Theme Change',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      RadioListTile(
                          title: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Light  '),
                              Icon(
                                Icons.light_mode,
                                color: Colors.yellow,
                              )
                            ],
                          ),
                          value: ThemeMode.light,
                          groupValue: _themeProvider.themeMode,
                          onChanged: _themeProvider.changeTheme),
                      RadioListTile(
                          title: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Dark  '),
                              Icon(
                                Icons.dark_mode_outlined,
                                color: Colors.blueGrey,
                              )
                            ],
                          ),
                          value: ThemeMode.dark,
                          groupValue: _themeProvider.themeMode,
                          onChanged: _themeProvider.changeTheme),
                      RadioListTile(
                          title: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('System  '),
                              Icon(
                                Icons.system_security_update_good,
                                color: Colors.green,
                              )
                            ],
                          ),
                          value: ThemeMode.system,
                          groupValue: _themeProvider.themeMode,
                          onChanged: _themeProvider.changeTheme),
                    ],
                  ),
                ),
                const Divider(),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

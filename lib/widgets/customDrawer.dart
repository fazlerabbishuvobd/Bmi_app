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

            // Change Language & Theme
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Change Language
                const Divider(),
                Consumer<LanguageProvider>(
                  builder: (context, languageProvider, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Change Language', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('English'),
                          Switch(
                              value: languageProvider.value,
                              onChanged: (newValue) {
                                languageProvider.switchVal(newValue);
                                languageProvider.changeLanguage(newValue);
                              }),
                          const Text('বাংলা'),
                        ],
                      )
                    ],
                  ),
                ),
                const Divider(),

                // Change Theme
                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Theme Change',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      //Light
                      RadioListTile(
                          title: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Light  '),
                              Icon(Icons.light_mode,
                                color: Colors.yellow,
                              )
                            ],
                          ),
                          value: ThemeMode.light,
                          groupValue: themeProvider.themeMode,
                          onChanged: themeProvider.changeTheme),

                      //Dark
                      RadioListTile(
                          title: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Dark  '),
                              Icon(Icons.dark_mode_outlined,
                                color: Colors.blueGrey,)
                            ],
                          ),
                          value: ThemeMode.dark,
                          groupValue: themeProvider.themeMode,
                          onChanged: themeProvider.changeTheme),

                      //System
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
                          groupValue: themeProvider.themeMode,
                          onChanged: themeProvider.changeTheme),
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

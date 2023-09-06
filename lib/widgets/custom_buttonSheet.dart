import 'package:bmi_calculator_app/widgets/custom_button.dart';
import 'package:bmi_calculator_app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showBottomSheets(
    BuildContext context, VoidCallback onpressed1, VoidCallback onpressed2) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 150,
        // Bottom sheet content
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: SizedBox(
                    width: 50,
                    child: Divider(
                      height: 3,
                      color: Colors.grey,
                    )),
              ),
              Text(
                AppLocalizations.of(context)!.shareFile,
                style: customBodyText(Colors.black, 25, FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: customButton(
                          onPressed: onpressed1,
                          buttonTxt: AppLocalizations.of(context)!.textButton,
                          icons: Icons.text_fields_outlined,
                          color: Colors.amber,
                          height: 56)),
                  Expanded(
                      child: customButton(
                          onPressed: onpressed2,
                          buttonTxt: AppLocalizations.of(context)!.scButton,
                          icons: Icons.screenshot_outlined,
                          color: Colors.amber,
                          height: 56)),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

import 'package:credstream/core/colors.dart';
import 'package:credstream/screens/auth/signup.dart';
import 'package:flutter/material.dart';

class DobTextField extends StatelessWidget {
  const DobTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      showCursor: false,
      // enabled: false,
      keyboardType: TextInputType.none,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: kWhite),
      validator: (value) {
        return null;
      },
      onTap: () async {
        Signup.dob.value = (await showDatePicker(
            context: context,
            initialDate: DateTime(2002, 1, 1),
            firstDate: DateTime(1970, 1, 1), 
            lastDate: DateTime(2010, 1, 1)))!;
        Signup.dob.notifyListeners();
      },
      decoration: InputDecoration(
        label: Signup.dob.value.year != 1920
            ? Text(
                "${Signup.dob.value.day}/${Signup.dob.value.month}/${Signup.dob.value.year}",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: kWhite),
              )
            : Text(
                "Date of birth",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: kGrey400),
              ),
        prefixIcon: const Icon(
          Icons.date_range,
          color: kWhite,
        ),
        hintStyle:
            Theme.of(context).textTheme.bodyLarge!.copyWith(color: kGrey400),
      ),
    );
  }
}

class FormTextFormField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final int index;
  final TextEditingController controller;
 
  final ValueNotifier<bool> visible = ValueNotifier(false);

  FormTextFormField(
      {super.key,
      required this.hint,
      required this.icon,
      required this.index,
      required this.controller});
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ValueListenableBuilder(
        valueListenable: visible,
        builder: (context, value, child) {
          return TextFormField(
            controller: controller,
            obscureText: ((index == 2)&&(!visible.value)) ? true : false,
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(color: kWhite),
            validator: (value) {
              if (index == 0) {
                if (value == null || value.isEmpty) {
                  return "Enter your name";
                }
              } else if (index == 1) {
                if (value == null ||
                    !value.contains("@") && !value.contains(".com")) {
                  return "Enter valid email";
                }
              } else if (index == 2) {
                if (value!.length < 8) {
                  return "Password must have atleast 8 characters";
                } else if (!value.contains(RegExp(r'[@]|[#]|[$]|[%]|[&]'))) {
                  return "Password must have atleast 1 special character";
                }
              }
              return null;
            },
            decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: kWhite,
                ),
                hintText: hint,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: kGrey400),
                suffixIcon: index == 2
                    ? IconButton(
                        icon: const Icon(Icons.visibility),
                        color: kWhite,
                        onPressed: () {
                          visible.value = !visible.value;
                          visible.notifyListeners();
                        },
                      )
                    : const SizedBox.shrink()),
          );
        },
      ),
    );
  }
}

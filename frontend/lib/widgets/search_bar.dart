import 'package:crytojay/config/assets/color_manager.dart';
import 'package:flutter/material.dart';
class SearchInput extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final Function onChanged;
  final VoidCallback onIconTap;
  final VoidCallback onButtonTap;
  final IconData icondata;
  final String buttonText;
  final List questions;
  final bool showDropdown;
  const SearchInput(
      {super.key,
      required this.textController,
      required this.hintText,
      required this.onIconTap,
      this.icondata = Icons.search,
      required this.onChanged,
      this.showDropdown = false,
      this.questions = const [],
      required this.buttonText,
      required this.onButtonTap});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 300,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.black.withOpacity(.1)),
      ]),
      child: TextField(
        style: const TextStyle(color: Colors.black),
        autofillHints: const [AutofillHints.username],
        controller: widget.textController,
        onChanged: (value) {
          widget.onChanged(value);
        },
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: Icon(
            widget.icondata,
            size: 32,
            color: const Color(0xff020302),
          ),
          // suffixIcon: Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: ElevatedButton(
          //       onPressed: widget.onButtonTap,
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: ColorManager.primaryColor,
          //       ),
          //       child: Text(widget.buttonText,style: const TextStyle(color: ColorManager.white),)),
          // ),
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
      ),

      //   ],
      // ),
    );
  }
}

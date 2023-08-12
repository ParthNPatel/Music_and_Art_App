import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_and_art/constants/colors.dart';

class TextFieldLayout extends StatefulWidget {
  final String hintText;
  final String labelText;
  final Function? onChanged;
  final bool isPasswordField;
  final TextInputType? inputType;
  final bool isDescriptionField;
  final VoidCallback? onTap;
  final FocusNode? currentNode;
  final FocusNode? nextNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final double? height;
  final bool isEditable;
  final bool readOnly;
  final bool enabled;
  final bool needFormatter;
  final bool needBorder;
  final List<TextInputFormatter>? textInputFormatters;
  final int? maxLength;
  final String? Function(String?)? validator;

  TextFieldLayout(
      {Key? key,
      required this.hintText,
      this.onChanged,
      this.isPasswordField = false,
      this.inputType,
      this.isDescriptionField = false,
      this.onTap,
      this.prefixIcon,
      this.suffixIcon,
      this.controller,
      this.height,
      this.currentNode,
      this.nextNode,
      this.isEditable = false,
      this.readOnly = false,
      this.enabled = true,
      this.needFormatter = false,
      this.textInputFormatters,
      this.maxLength,
      this.needBorder = false,
      required this.labelText,
      this.validator})
      : super(key: key);

  @override
  State<TextFieldLayout> createState() => _TextFieldLayoutState();
}

class _TextFieldLayoutState extends State<TextFieldLayout> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.isPasswordField;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: textField(),
    );
  }

  IconButton passwordSuffixIcon() {
    return IconButton(
      icon: Icon(
        // Based on passwordVisible state choose the icon
        _obscureText ? Icons.visibility : Icons.visibility_off,
        color: AppColors.white,
        size: 20.sp,
      ),
      onPressed: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
    );
  }

  Widget textField() {
    return TextFormField(
      maxLength: widget.maxLength ?? 1000,
      enabled: widget.enabled,

      readOnly: widget.readOnly,
      focusNode: widget.currentNode,
      validator: widget.validator,
      // onSubmitted: (term) {
      //   widget.currentNode?.unfocus();
      //   FocusScope.of(context).requestFocus(widget.nextNode ?? null);
      // },
      inputFormatters: widget.needFormatter ? widget.textInputFormatters : null,
      controller: widget.controller,
      onTap: widget.onTap,
      minLines: 1,
      textInputAction:
          widget.nextNode == null ? TextInputAction.done : TextInputAction.next,
      enableSuggestions: false,
      maxLines: widget.isDescriptionField ? 8 : 1,
      keyboardType: widget.inputType,
      obscureText: _obscureText,
      decoration: InputDecoration(
        counterText: '',
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.white)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.white)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.white)),
        hintText: widget.hintText,
        hintStyle: TextStyle(
            color: AppColors.hintTextColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 15.sp),
        labelText: widget.labelText,
        labelStyle: TextStyle(
            color: AppColors.appYellow,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 20.sp),
        prefixIcon: widget.prefixIcon,
        contentPadding: EdgeInsets.fromLTRB(
          15.w,
          11.h,
          8.w,
          15.h,
        ),
        suffixIcon:
            widget.isPasswordField ? passwordSuffixIcon() : widget.suffixIcon,
      ),
      onChanged: (text) {
        if (widget.onChanged != null) widget.onChanged!(text);
      },
    );
  }
}

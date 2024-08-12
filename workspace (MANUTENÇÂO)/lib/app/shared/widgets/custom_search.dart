// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSearch extends StatefulWidget {
  final TextEditingController searchController;
  final Widget? preffixIconSearch;
  final String hintTextSearch;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  const CustomSearch({
    Key? key,
    required this.searchController,
    this.preffixIconSearch,
    required this.hintTextSearch,
    required this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = FocusNode();

    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    final double fullHdBreakpointWidth = 1340.00;
    final double fullHdBreakpointHeight = 769.00;

    return SizedBox(
      width: screenWidth < fullHdBreakpointWidth ? 900 : 900,
      child: TextFormField(
        controller: widget.searchController,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: Colors.white,
          contentPadding: EdgeInsets.only(
            left: 10,
          ),
          suffixIcon: widget.preffixIconSearch,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF77B7CC), width: 2.0),
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: widget.hintTextSearch,
          hintStyle: TextStyle(
              fontSize: screenHeight < fullHdBreakpointHeight ? 13 : 15),
          labelStyle: TextStyle(
              color:
                  myFocusNode.hasFocus ? Color(0xFF77B7CC) : Color(0xFF77B7CC)),
          filled: true,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}

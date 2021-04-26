import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  DropDownWidget(
      {this.title,
      this.items,
      this.itemCallBack,
      this.currentItem,
      this.hinText});

  final String title;
  final List<String> items;
  final ValueChanged<String> itemCallBack;
  final String currentItem;
  final String hinText;

  @override
  State<StatefulWidget> createState() => _DropdownState(currentItem);
}

class _DropdownState extends State<DropDownWidget> {
  _DropdownState(this.currentItem);

  List<DropdownMenuItem<String>> dropDownItems = [];
  String currentItem;

  @override
  void initState() {
    super.initState();
    for (var item in widget.items) {
      dropDownItems.add(DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ));
    }
  }

  @override
  void didUpdateWidget(covariant DropDownWidget oldWidget) {
    if (currentItem != widget.currentItem) {
      setState(() {
        currentItem = widget.currentItem;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 6),
            child: Text(
              widget.title,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 10,
                  color: Color(0x19000000),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                icon: Icon(Icons.arrow_downward),
                value: currentItem,
                isExpanded: true,
                items: dropDownItems,
                onChanged: (selectedItem) {
                  setState(() {
                    currentItem = selectedItem;
                    widget.itemCallBack(currentItem);
                  });
                },
                hint: Container(
                  child: Text(
                    widget.hinText,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:midowe_app/utils/constants.dart';

class SearchArea extends StatelessWidget {
  TextEditingController controller = new TextEditingController();

  onSearchTextChanged(String text) async {
    if (text.isEmpty) {
      return;
    }
    //NAVIGATE TO SEARCH VIEW
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: new Container(
          child: new ListTile(
            leading: Image(
              image: AssetImage("assets/images/logo.png"),
              height: 38,
            ),
            title: new Text(""),
            trailing: new IconButton(
              color: Constants.primaryColor,
              icon: new Icon(Icons.search),
              onPressed: () {
                controller.clear();
                onSearchTextChanged('');
              },
            ),
          ),
        ),
      ),
    );
  }
}

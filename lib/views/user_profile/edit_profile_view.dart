import 'package:flutter/material.dart';
import 'package:midowe_app/views/user_profile/profile_widget.dart';
import 'package:midowe_app/views/user_profile/textfield_widget.dart';

class EditProfileView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditProfileViewState();
  }
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: '',
            isEdit: true,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Full Name',
            text: '',
            onChanged: (name) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Email',
            text: '',
            onChanged: (email) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'About',
            text: '',
            maxLines: 5,
            onChanged: (about) {},
          ),
        ],
      ),
    );
  }
}

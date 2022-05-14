import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:midowe_app/models/user_model.dart';
import 'package:midowe_app/providers/user_provider.dart';

class CampaignAuthor extends StatefulWidget {
  final String? userId;

  const CampaignAuthor({Key? key,  this.userId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CampaignAuthorState();
  }
}

class _CampaignAuthorState extends State<CampaignAuthor> {
  final userProvider = GetIt.I.get<UserProvider>();
  late Future<User> user;

  @override
  void initState() {
    super.initState();
    this.user = userProvider.fetchUserById(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Row(
              children: [
                CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(snapshot.data!.picture)),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data!.name,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(snapshot.data!.headline),
                  ],
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }
}

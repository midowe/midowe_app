import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:midowe_app/components/home_header.dart';
import 'package:midowe_app/helpers/constants.dart';
import 'package:midowe_app/models/fundraiser.dart';
import 'package:midowe_app/providers/fundraiser_provider.dart';

class HomePageProfile extends StatefulWidget {
  final VoidCallback onLogout;

  const HomePageProfile({Key? key, required this.onLogout}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageProfileState();
  }
}

class _HomePageProfileState extends State<HomePageProfile> {
  final fundraiserProvider = GetIt.I.get<FundraiserProvider>();
  late Future<Fundraiser> fundraiser;
  late Auth0 auth0;

  @override
  void initState() {
    super.initState();
    this.auth0 = Auth0(Constants.AUTH0_DOMAIN, Constants.AUTH0_CLIENT_ID);
    fundraiser = fundraiserProvider.fetchFundraiserUsername(sessionUserSub);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
          HomeHeader(
            actionButton: TextButton(
              onPressed: () async {
                await auth0.webAuthentication().logout();
                this.widget.onLogout();
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(41, 40),
                alignment: Alignment.center,
                backgroundColor: Constants.secondaryColor4,
                foregroundColor: Constants.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              child: Icon(
                Icons.exit_to_app_outlined,
                color: Colors.black87,
              ),
            ),
          ),
          FutureBuilder<Fundraiser>(
            future: fundraiser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ProfileWidget(
                      imagePath: snapshot.data!.picture,
                      onClicked: () {},
                      isEdit: false,
                    ),
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data!.full_name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            snapshot.data!.headline,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextTitleDescripion(
                              title: "E-mail",
                              description: snapshot.data!.email),
                          TextTitleDescripion(
                              title: "Telefone",
                              description: snapshot.data!.phone),
                          TextTitleDescripion(
                              title: "Método de realocação",
                              description: snapshot.data!.reallocation_method),
                          TextTitleDescripion(
                              title: "Endereço de realocação",
                              description: snapshot.data!.reallocation_address),
                          TextTitleDescripion(
                              title: "Periodicidade", description: "-"), // TODO
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Text('${snapshot.error}'),
                );
              }
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: CircularProgressIndicator(),
                ),
              );
            },
          )
        ]));
  }
}

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Constants.primaryColor;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

class TextTitleDescripion extends StatelessWidget {
  final String title;
  final String description;

  const TextTitleDescripion(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        Text(
          description,
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../constants.dart';
import 'Social_Media_Icons.dart';
import 'button.dart';
import 'divider.dart';

class MyAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: row(context),
    );
  }

  Widget row(BuildContext context) {
    return Row(children: [blackIconTiles(context)]);
  }

  Widget blackIconTiles(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.6,
        color: complexDrawerBlack,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: complexDrawerBlueGrey,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  bottom: 50,
                ),
                child: ListTile(
                  leading: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  title: Text(
                    websiteName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: ListView(children: [
              MyButton(text: 'About Us', uRl: aboutUs),
              MyDivider(),
              MyButton(text: 'Contact Us', uRl: contactUS),
              MyDivider(),
              MyButton(text: 'Privacy Policy', uRl: privacyPolicy),
              MyDivider(),
            ])),
            SocialMedia(),
            accountTile()
          ],
        ));
  }

  Widget accountButton({bool usePadding = true, String? url}) {
    return Padding(
      padding: EdgeInsets.all(usePadding ? 8 : 0),
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: Colors.white70,
          image: DecorationImage(
            image: NetworkImage(url!),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  Widget accountTile() {
    return Container(
      color: complexDrawerBlueGrey,
      child: ListTile(
        leading: accountButton(usePadding: false, url: photoURL),
        title: Text(
          "M.SHAFIQUE",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          "Flutter Developer",
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}

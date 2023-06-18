import 'package:chithi/model/models.dart';
import 'package:chithi/theme/custom_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chithi/screens/screens.dart';

import 'package:chithi/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Base extends ConsumerStatefulWidget {
  const Base({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BaseState();
}

class _BaseState extends ConsumerState<Base> {
  // variables
  int _currentScreenPage = 0;
  final double _navProfileRadius = 12;

  @override
  Widget build(BuildContext context) {
    CustomTheme currentTheme = ref.watch(currentThemeProvider);
    bool isDark = currentTheme == CustomTheme.dark;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          // variables
          Map<String, dynamic>? usrDetMap = snapshot.data!.data();

          if (usrDetMap != null) {
            UserModel crntUsrModel = UserModel.fromMap(usrDetMap);

            List<Widget> screens = [
              Home(
                crntUserModel: crntUsrModel,
              ),
              const Search(),
              const Create(),
              Profile(
                crntUserModel: crntUsrModel,
              ),
            ];
            List<Widget> destinations = [
              const NavigationDestination(
                icon: Icon(
                  Icons.home,
                  color: navSelectedColor,
                ),
                label: "Home",
              ),
              const NavigationDestination(
                icon: Icon(Icons.search, color: navSelectedColor),
                label: "Search",
              ),
              const NavigationDestination(
                icon: Icon(
                  Icons.add,
                  color: navSelectedColor,
                ),
                label: "Create",
              ),
              NavigationDestination(
                icon: CircleAvatar(
                  radius: _navProfileRadius + 2,
                  backgroundColor: isDark ? Colors.grey : null,
                  child: CircleAvatar(
                    radius: _navProfileRadius,
                    backgroundImage: crntUsrModel.profilePicReady(),
                  ),
                ),
                label: "Profile",
              ),
            ];

            return Scaffold(
              body: IndexedStack(
                index: _currentScreenPage,
                children: screens,
              ),
              bottomNavigationBar: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: NavigationBar(
                  animationDuration: const Duration(milliseconds: 500),
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                  backgroundColor: isDark ? darkNavBGColor : navBGColor,
                  selectedIndex: _currentScreenPage,
                  destinations: destinations,
                  onDestinationSelected: (int newScreenIndex) {
                    if (newScreenIndex != _currentScreenPage) {
                      setState(() {
                        _currentScreenPage = newScreenIndex;
                      });
                    }
                  },
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

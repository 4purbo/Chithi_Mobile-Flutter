import 'package:chithi/model/models.dart';
import 'package:flutter/material.dart';

import 'package:chithi/theme/theme.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  // local varibles
  final double profileRadius = 50;

  Widget profilePhoto() {
    return CircleAvatar(
      radius: profileRadius,
      backgroundImage: userModel.profilePicReady(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // total area
        const SizedBox(
          height: 200,
        ),

        // bannerPic height
        Container(
          height: 150,
          width: double.infinity,
          color: userModel.bannerPic == null ? defaultBannerColor : null,
          child: userModel.bannerPic != null
              ? Image.network(
                  userModel.bannerPic!,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                  fit: BoxFit.cover,
                )
              : null,
        ),
        // profilePic Widget
        Positioned(
          bottom: 0,
          left: 10,
          child: Card(
            shape: const CircleBorder(),
            elevation: 10,

            // profilePhotoBorder
            child: CircleAvatar(
              radius: profileRadius + 2,
              backgroundColor: Colors.black,
              child: profilePhoto(),
            ),
          ),
        ),

        // followers and followings
        Positioned(
            bottom: 5,
            right: 20,
            child: FollowAndFollowings(
              followers: userModel.fans,
              followings: userModel.idols,
            ))
      ],
    );
  }
}

class FollowAndFollowings extends StatelessWidget {
  const FollowAndFollowings(
      {super.key, required this.followers, required this.followings});
  final List followers;
  final List followings;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Fans',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              followers.length.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 50,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Idols',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              followings.length.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        )
      ],
    );
  }
}

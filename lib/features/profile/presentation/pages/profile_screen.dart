import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_commerce_app/features/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:e_commerce_app/features/chat/presentation/manager/chat_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_router.dart';
import '../../../../core/services/service_locator_get_it.dart';


import 'package:flutter_svg/svg.dart';


import 'package:flutter_svg/flutter_svg.dart';

import '../../../../generated/assets.dart';
import '../../../auth/presentation/cubit/auth_state.dart';
import '../../../chat/presentation/manager/chat_state.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: Icon(Icons.account_circle),
              press: () =>
              {
                GoRouter.of(context).push(myAccountPath),

              },
            ),
            ProfileMenu(
              text: "Notifications",
              icon: Icon(Icons.notifications_active),
              press: () {
                GoRouter.of(context).push(notificationPath);
              },
            ),
            ProfileMenu(
              text: "Chat",
              icon: Icon(Icons.chat),
              press: () async {
                await getIt<AuthCubit>().checkAdminStatus();
                if(getIt<AuthCubit>().isAdmin==true){
                  GoRouter.of(context).push(adminChatPath);

                }else{
                  Stream<QuerySnapshot> messageStream=
                  FirebaseFirestore.instance.collection('chats')
                      .doc(await ChatRemoteDataSource().getDocumentIdOfChat(FirebaseAuth.instance.currentUser!.uid))
                      .collection("messages").orderBy("time",descending: true).snapshots();
                  GoRouter.of(context).push(chatPath ,extra:{
                    "messagesStream":messageStream,
                    "userIdToChatWith":"",
                  } );
                }

              },
            ),
            ProfileMenu(
              text: "Settings",
              icon: Icon(Icons.settings),
              press: () {
                GoRouter.of(context).push(settingsPath);
              },
            ),
            ProfileMenu(
              text: "Help Center",
              icon: Icon(Icons.help),
              press: () {
                GoRouter.of(context).push(helpCenterPath);
              },
            ),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is SignedOutSuccess) {
                  GoRouter.of(context).pushReplacement(loginPath);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Signed Out Successfully"),
                    ),
                  );
                }
                if (state is SignedOutFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              child: ProfileMenu(
                text: "Log Out",
                icon: Icon(Icons.logout),
                press: () {
                  getIt<AuthCubit>().signOutUser();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: getIt<AuthCubit>().theUserInformation?.imageUrl ==
                null ?
            const AssetImage(Assets.imagesStar1) as ImageProvider :
            NetworkImage(getIt<AuthCubit>().theUserInformation!.imageUrl!),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () {},
                child: SvgPicture.string(cameraIcon),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.text,
    required this.icon,
    this.press,
  });

  final String text;
  final Icon icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.fontSecondaryColor,
          padding: const EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            icon,
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF757575),
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF757575),
            ),
          ],
        ),
      ),
    );
  }
}

const cameraIcon =
'''<svg width="20" height="16" viewBox="0 0 20 16" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M10 12.0152C8.49151 12.0152 7.26415 10.8137 7.26415 9.33902C7.26415 7.86342 8.49151 6.6619 10 6.6619C11.5085 6.6619 12.7358 7.86342 12.7358 9.33902C12.7358 10.8137 11.5085 12.0152 10 12.0152ZM10 5.55543C7.86698 5.55543 6.13208 7.25251 6.13208 9.33902C6.13208 11.4246 7.86698 13.1217 10 13.1217C12.133 13.1217 13.8679 11.4246 13.8679 9.33902C13.8679 7.25251 12.133 5.55543 10 5.55543ZM18.8679 13.3967C18.8679 14.2226 18.1811 14.8935 17.3368 14.8935H2.66321C1.81887 14.8935 1.13208 14.2226 1.13208 13.3967V5.42346C1.13208 4.59845 1.81887 3.92664 2.66321 3.92664H4.75C5.42453 3.92664 6.03396 3.50952 6.26604 2.88753L6.81321 1.41746C6.88113 1.23198 7.06415 1.10739 7.26604 1.10739H12.734C12.9358 1.10739 13.1189 1.23198 13.1877 1.41839L13.734 2.88845C13.966 3.50952 14.5755 3.92664 15.25 3.92664H17.3368C18.1811 3.92664 18.8679 4.59845 18.8679 5.42346V13.3967ZM17.3368 2.82016H15.25C15.0491 2.82016 14.867 2.69466 14.7972 2.50917L14.2519 1.04003C14.0217 0.418041 13.4113 0 12.734 0H7.26604C6.58868 0 5.9783 0.418041 5.74906 1.0391L5.20283 2.50825C5.13302 2.69466 4.95094 2.82016 4.75 2.82016H2.66321C1.19434 2.82016 0 3.98846 0 5.42346V13.3967C0 14.8326 1.19434 16 2.66321 16H17.3368C18.8057 16 20 14.8326 20 13.3967V5.42346C20 3.98846 18.8057 2.82016 17.3368 2.82016Z" fill="#757575"/>
</svg>
''';

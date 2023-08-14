import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:music_and_art/constants/colors.dart';
import 'package:music_and_art/constants/strings.dart';
import 'package:music_and_art/constants/test_style.dart';
import 'package:music_and_art/core/routing/routes.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthViewModel extends GetxController {
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController loginEmail = TextEditingController();
  TextEditingController signPassword = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  TextEditingController signUserName = TextEditingController();
  TextEditingController signRePassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  bool setLoading = false;

  void setLoadingS(bool val) {
    setLoading = val;
    update();
  }

  Future facebookAuthMethod() async {
    try {
      final result = await FacebookAuth.instance
          .login(permissions: ['public_profile', 'email']);

      if (result.status == LoginStatus.success) {
        print('RESPONSE');
        OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        print('RESPONSE1');

        final userData = await FacebookAuth.instance.getUserData();

        print('RESPONSE2');

        try {
          /// any operation
        } catch (e) {}
      }
    } catch (error) {
      print('ERRORRRRRR $error');
    }
  }

  void navigateToSignupScreen() {
    Get.toNamed(Routes.signUpScreen);
  }

  void navigateToLoginScreen() {
    Get.toNamed(Routes.loginScreen);
  }

  void loginWithWithEmail(BuildContext context) {
    if (loginFormKey.currentState!.validate()) {
      setLoadingS(true);
      login(
          email: loginEmail.text,
          password: loginPassword.text,
          context: context);

      update();
    }
  }

  void navigateToInstallationScreen(BuildContext context) {
    if (formKey.currentState!.validate()) {
      setLoadingS(true);
      signUp(
        email: signUpEmail.text,
        password: signPassword.text,
        context: context,
      );

      update();
    }
  }

  bool checkBox1 = false;
  bool checkBox2 = false;
  updateCheckBox1Value(bool val) {
    checkBox1 = val;
    update();
  }

  updateCheckBox2Value(bool val) {
    checkBox2 = val;
    update();
  }

  void termsAndConditionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.sp),
              topLeft: Radius.circular(15.sp))),
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.white,
        ),
        child: GetBuilder<AuthViewModel>(
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppTextStyle.textBoldWeight400(
                    text: AuthenticationStrings.allgemeine,
                    fontSize: 24.sp,
                    maxLines: 3,
                    textAlign: TextAlign.center),
                SizedBox(height: 45.h),
                AppTextStyle.textBoldWeight400(
                    text: AuthenticationStrings.hiermit_explizit,
                    fontSize: 14.sp,
                    maxLines: 3,
                    textAlign: TextAlign.center),
                SizedBox(height: 45.h),
                Row(
                  children: [
                    Checkbox(
                      value: controller.checkBox1,
                      onChanged: (bool? value) {
                        controller.updateCheckBox1Value(value!);
                      },
                    ),
                    AppTextStyle.textBoldWeight400(
                        text: AuthenticationStrings.den_allgemeine,
                        fontSize: 14.sp,
                        textAlign: TextAlign.center),
                  ],
                ),
                SizedBox(height: 15.h),
                Row(
                  children: [
                    Checkbox(
                      value: controller.checkBox2,
                      onChanged: (value) {
                        controller.updateCheckBox2Value(value!);
                      },
                    ),
                    AppTextStyle.textBoldWeight400(
                        text: AuthenticationStrings.datenschutzrichtlinien,
                        fontSize: 14.sp,
                        textAlign: TextAlign.center),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  ///GOOGLE LOGIN

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authChanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firestore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'profilePhoto': user.photoURL,
          });
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      print('$e');
      res = false;
    }
    return res;
  }

  void signOut() async {
    try {
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  ///LOGIN WITH EMAIL/PASSWORD

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      {required BuildContext context, required String title}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
      ),
    );
  }

  Future<bool> signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      setLoadingS(false);
      signUpEmail.clear();
      signPassword.clear();
      signUserName.clear();
      signRePassword.clear();
      Get.toNamed(Routes.loginScreen);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        print('ERROR CREATE ON SIGN UP TIME == No Internet Connection.');
        showSnackBar(context: context, title: "No Internet Connection.");
      } else if (e.code == 'too-many-requests') {
        print(
            'ERROR CREATE ON SIGN UP TIME == Too many attempts please try later');
        showSnackBar(
            context: context, title: "Too many attempts please try later.");
      } else if (e.code == 'weak-password') {
        print(
            'ERROR CREATE ON SIGN UP TIME == The password provided is too weak.');
        showSnackBar(
            context: context, title: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        print(
            'ERROR CREATE ON SIGN UP TIME == The account already exists for that email.');
        showSnackBar(
            context: context,
            title: "The account already exists for that email.");
      } else if (e.code == 'invalid-email') {
        print(
            'ERROR CREATE ON SIGN UP TIME == The email address is not valid.');
        showSnackBar(
            context: context, title: "The email address is not valid.");
      } else if (e.code == 'weak-password') {
        print(
            'ERROR CREATE ON SIGN UP TIME == The password is not strong enough.');
        showSnackBar(
            context: context, title: "The password is not strong enough.");
      } else {
        print('ERROR CREATE ON SIGN IN TIME ==  Something went to Wrong.');
        showSnackBar(context: context, title: "Something went to wrong.");
      }
      setLoadingS(false);
      return false;
    }
  }

  Future<bool> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      setLoadingS(false);
      loginPassword.clear();
      loginEmail.clear();
      Get.toNamed(Routes.installationScreen);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        print('ERROR CREATE ON SIGN IN TIME == No Internet Connection.');

        showSnackBar(context: context, title: "No Internet Connection.");
      } else if (e.code == 'too-many-requests') {
        print(
            'ERROR CREATE ON SIGN IN TIME == Too many attempts please try later');
        showSnackBar(
            context: context, title: "Too many attempts please try later.");
      } else if (e.code == 'user-not-found') {
        print('ERROR CREATE ON SIGN IN TIME == No user found for that email.');

        showSnackBar(context: context, title: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print(
            'ERROR CREATE ON SIGN IN TIME == The password is invalid for the given email.');
        showSnackBar(
            context: context,
            title: "The password is invalid for the given email.");
      } else if (e.code == 'invalid-email') {
        print(
            'ERROR CREATE ON SIGN IN TIME == The email address is not valid.');
        showSnackBar(
            context: context, title: "The email address is not valid.");
      } else if (e.code == 'user-disabled') {
        print(
            'ERROR CREATE ON SIGN IN TIME ==  The user corresponding to the given email has been disabled.');
        showSnackBar(
            context: context,
            title:
                "The user corresponding to the given email has been disabled.");
      } else {
        print('ERROR CREATE ON SIGN IN TIME ==  Something went to Wrong.');
        showSnackBar(context: context, title: "Something went to wrong.");
      }
      setLoadingS(false);
      return false;
    }
  }
}

///DELETE/////
class InstagramConstant {
  static InstagramConstant? _instance;
  static InstagramConstant get instance {
    _instance ??= InstagramConstant._init();
    return _instance!;
  }

  InstagramConstant._init();

  static const String clientID = '718353975697969';
  static const String appSecret = '5497481e4a4ab34ae4fc2eeb4e6b7dba';
  static const String redirectUri = 'https://www.ekspar.com.tr/';
  static const String scope = 'user_profile,user_media';
  static const String responseType = 'code';
  final String url =
      'https://api.instagram.com/oauth/authorize?client_id=$clientID&redirect_uri=$redirectUri&scope=user_profile,user_media&response_type=$responseType';
}

class InstagramModel {
  List<String> userFields = ['id', 'username'];

  String? authorizationCode;
  String? accessToken;
  String? userID;
  String? username;

  void getAuthorizationCode(String url) {
    authorizationCode = url
        .replaceAll('${InstagramConstant.redirectUri}?code=', '')
        .replaceAll('#_', '');
  }

  Future<bool> getTokenAndUserID() async {
    var url = Uri.parse('https://api.instagram.com/oauth/access_token');
    final response = await http.post(url, body: {
      'client_id': InstagramConstant.clientID,
      'redirect_uri': InstagramConstant.redirectUri,
      'client_secret': InstagramConstant.appSecret,
      'code': authorizationCode,
      'grant_type': 'authorization_code'
    });
    accessToken = json.decode(response.body)['access_token'];
    print(accessToken);
    userID = json.decode(response.body)['user_id'].toString();
    return (accessToken != null && userID != null) ? true : false;
  }

  Future<bool> getUserProfile() async {
    final fields = userFields.join(',');
    final responseNode = await http.get(Uri.parse(
        'https://graph.instagram.com/$userID?fields=$fields&access_token=$accessToken'));
    var instaProfile = {
      'id': json.decode(responseNode.body)['id'].toString(),
      'username': json.decode(responseNode.body)['username'],
    };
    username = json.decode(responseNode.body)['username'];
    print('username: $username');
    return instaProfile.isEmpty ? true : false;
  }
}

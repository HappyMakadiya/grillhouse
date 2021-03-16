import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../home_screen.dart';
import '../user_info.dart';

class EmailVerificationScreen extends StatefulWidget {
  final UserInfoData userinfo;

  EmailVerificationScreen({
    @required this.userinfo,

  });
  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _confirmationCodeController = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();


  Future<void> _submitCode(BuildContext context) async {
    if (_formKey1.currentState.validate()) {
      final ProgressDialog pr = ProgressDialog(context,type: ProgressDialogType.Normal);
      pr.style(progressWidget: CupertinoActivityIndicator());

      final confirmationCode = _confirmationCodeController.text;

      await pr.show();
      try {
        final SignUpResult response = await Amplify.Auth.confirmSignUp(
          username: widget.userinfo.email,
          confirmationCode: confirmationCode,
        );
        if (response.isSignUpComplete) {
            await pr.hide();
            Navigator.of(context).pushReplacementNamed('/login_screen');
        }
      }catch (e) {
        await pr.hide();
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text((e as AuthException).message),
          ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Confirm your email"),
      ),
      body: Form(
        key: _formKey1,
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              Text(
                "An email confirmation code is sent to ${widget.userinfo.email}. Please type the code to confirm your email.",
                style: Theme.of(context).textTheme.headline6,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _confirmationCodeController,
                decoration: InputDecoration(labelText: "Confirmation Code"),
                validator: (value) => value.length != 6 ? "The confirmation code is invalid" : null,
              ),
              RaisedButton(
                onPressed: () => _submitCode(context),
                child: Text("CONFIRM"),
              ),
              FlatButton(
                onPressed: () async {
                  final ProgressDialog pr = ProgressDialog(context,type: ProgressDialogType.Normal);
                  pr.style(progressWidget: CupertinoActivityIndicator());
                  await pr.show();
                  await Amplify.Auth.resendSignUpCode(username: widget.userinfo.email);
                  await pr.hide();
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text("Verification Code is resend."),
                    ),
                  );
                },
                child: Text("Resend Code"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:my_notes/Services/phone_auth.dart';
import 'package:my_notes/Widgets/custom_button.dart';
import 'package:my_notes/Widgets/custom_text_field.dart';

class OTPConfirmationPage extends StatefulWidget {
  final String phoneNo;

  OTPConfirmationPage({Key key, this.phoneNo}) : super(key: key);

  @override
  _OTPConfirmationPageState createState() => _OTPConfirmationPageState();
}

class _OTPConfirmationPageState extends State<OTPConfirmationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String phoneNo;
  FocusNode _blankFocusNode = FocusNode();
  PhoneAuth phoneAuth;

  String _otp;

  @override
  void initState() {
    super.initState();
    phoneNo = widget.phoneNo;
    phoneAuth = PhoneAuth(phoneNo: widget.phoneNo);
    phoneAuth.verifyPhone(context);
  }

  String numberCountValidator(value, int requiredCount) {
    if (value.length < requiredCount || value.length > requiredCount) {
      return "Invalid";
    } else {
      _formKey.currentState.save();
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var heightPiece = MediaQuery.of(context).size.height / 10;
    var widthPiece = MediaQuery.of(context).size.width / 10;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.teal[400],
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(_blankFocusNode);
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(widthPiece / 2),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: EdgeInsets.only(top: heightPiece),
                  child: buildOTPsentText()),
              Padding(
                  padding: EdgeInsets.only(top: heightPiece / 2),
                  child: showRegisteredMobileNumber()),
              Padding(
                  padding: EdgeInsets.only(top: heightPiece),
                  child: buildEnterOTPText()),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: otpInputFieldConfig(),
              ),
              Padding(
                padding: EdgeInsets.only(top: heightPiece),
                child: Center(
                  child: CustomButton(
                    text: 'Proceed',
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        phoneAuth.signIn(context, smsOTP: _otp);
                      }
                    },
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    ));
  }

  CustomTextField otpInputFieldConfig() {
    return CustomTextField(
        hintText: 'Your otp here',
        maxLength: 6,
        inputType: TextInputType.number,
        onSaved: ((value) {
          _otp = value;
        }),
        validator: (value) => numberCountValidator(value, 6));
  }

  buildOTPsentText() {
    return Text(
      'Verify the otp sent to this number',
      style: TextStyle(fontSize: 22),
    );
  }

  showRegisteredMobileNumber() {
    return Text(widget.phoneNo,
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22));
  }

  buildEnterOTPText() {
    return Text('Enter OTP',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18));
  }
}

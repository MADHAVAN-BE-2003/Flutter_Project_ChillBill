import 'package:chill_bill/common/api_call.dart';
import 'package:chill_bill/common/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_application_1/pages/dashboard.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _username = TextEditingController();
  TextEditingController _pass = TextEditingController();
  bool _validateusername = false;
  bool _validatepass = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "WELCOME",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Image.asset('assets/images/imageLogin.png'),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        TextField(
                            controller: _username,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person_outline,
                                size: 20,
                              ),
                              hintText: 'Username',
                              errorText: _validateusername
                                  ? 'Username Can\'t Be Empty'
                                  : null,
                              contentPadding:
                                  const EdgeInsets.only(bottom: 8.0, top: 8.0),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            )),
                        TextField(
                            obscureText: true,
                            controller: _pass,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                size: 20,
                              ),
                              hintText: 'Password',
                              errorText: _validatepass
                                  ? 'Password Can\'t Be Empty'
                                  : null,
                              contentPadding:
                                  const EdgeInsets.only(bottom: 8.0, top: 8.0),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: [
                            Text(
                              "Forget Password ?",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextButton(
                      child: Text(
                        "LOGIN".toUpperCase(),
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(10)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xffF3AB0D)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                      ),
                      onPressed: () {
                        if (_username.text.length == 0) {
                          setState(() {
                            _validateusername = true;
                          });
                        } else {
                          setState(() {
                            _validateusername = false;
                          });
                        }
                        if (_pass.text.length == 0) {
                          setState(() {
                            _validatepass = true;
                          });
                        } else {
                          setState(() {
                            _validatepass = false;
                          });
                        }

                        if (_validateusername == false &&
                            _validatepass == false) {
                          _login();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (_username.text.isNotEmpty && _pass.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      Future.delayed(Duration(seconds: 1), () async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Processing Data...')),
        );
        final store = await SharedPreferences.getInstance();
        await login(_username.text, _pass.text).then((val) {
          // print(val[0]['data']);

          if (val[0]['valid']) {
            if (store.getBool('regularprint') == null) {
              store.setBool('regularprint', true);
            }
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => WalletAppClone()));

            // var subscription_at = val[0]['data']['subscription_at']
            //     ? val[0]['data']['subscription_at']
            //     : 0;
            print(val[0]['data']);
            store.setString('user_id', val[0]['data']['user_id']);
            store.setString('username', val[0]['data']['username']);
            store.setString('firstname', val[0]['data']['firstname']);
            store.setString('lastname', val[0]['data']['lastname']);
            store.setString('email', val[0]['data']['email']);
            store.setString('employe_count', val[0]['data']['employe_count']);
            store.setString('role', val[0]['data']['role']);
            store.setString(
                'billing_address', val[0]['data']['billing_address']);
            store.setString('billing_name', val[0]['data']['billing_name']);

            // store.setString('subscription_at',
            //     val[0]['data']['subscription_at'].toString());

            store.setString('subscription_at',
                val[0]['data']['subscription_at'].toString());
            store.setString('subscription_status',
                val[0]['data']['subscription_status'].toString());
            store.setString('subscription_start',
                val[0]['data']['subscription_start'].toString());
            store.setString('subscription_end',
                val[0]['data']['subscription_end'].toString());
            store.setString(
                'total_bill', val[0]['data']['total_bill'].toString());
            store.setString(
                'total_income', val[0]['data']['total_income'].toString());
            store.setString(
                'total_expenses', val[0]['data']['total_expenses'].toString());
            store.setString(
                'total_savings', val[0]['data']['total_savings'].toString());
            store.setString(
                'total_invoice', val[0]['data']['total_invoice'].toString());
            store.setString(
                'total_sms', val[0]['data']['total_sms'].toString());
            store.setString(
                'master_id', val[0]['data']['master_id'].toString());
            store.setString(
                'company_id', val[0]['data']['company_id'].toString());
            store.setString('company_allowed',
                val[0]['data']['company_allowed'].toString());
            store.setString(
                'company_name', val[0]['data']['company_name'].toString());
            store.setString('phone', val[0]['data']['phone'].toString());
            store.setString(
                'sms_status', val[0]['data']['sms_status'].toString());
            store.setString(
                'sms_expired', val[0]['data']['sms_expired'].toString());
            store.setString('gst', val[0]['data']['gst'].toString());
            store.setString(
                'fees_amount', val[0]['data']['fees_amount'].toString());

            store.setString('subscription_id',
                val[0]['data']['subscription_id'].toString());
            store.setString(
                'payment_id', val[0]['data']['payment_id'].toString());
            store.setString(
                'reffered_by', val[0]['data']['reffered_by'].toString());
            store.setString(
                'description', val[0]['data']['description'].toString());
            store.setString('customer_creation',
                val[0]['data']['customer_creation'].toString());
            store.setString('invoice_creation',
                val[0]['data']['invoice_creation'].toString());
            store.setString('purchase_creation',
                val[0]['data']['purchase_creation'].toString());

            store.setString(
                'item_creation', val[0]['data']['item_creation'].toString());
            store.setString('notification_status',
                val[0]['data']['notification_status'].toString());
            store.setString('customer_creation',
                val[0]['data']['customer_creation'].toString());
            store.setString('notification_id',
                val[0]['data']['notification_id'].toString());
            store.setBool('loginstatus', true);
            store.setBool('user', true);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login Failed')),
            );
          }

          // print("returnnnnnn");
        });

        // print("okayy");
        // for (int id = 0; id < dataAssisten.length; id++) {
        //   if (_username.text == dataAssisten[id]["UserName"] &&
        //       _pass.text == dataAssisten[id]["PassWord"]) {
        //     String fullname = dataAssisten[id]["FullName"];
        //     String username = dataAssisten[id]["UserName"];
        //     prefs.setBool('user', true);
        //     prefs.setString('username', username);
        //     prefs.setString('fullname', fullname);
        //     Navigator.pushReplacement(
        //         context, MaterialPageRoute(builder: (context) => Dashboard()));
        //   }
        // }
      });
    }
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tomato_diseases/detect.dart';

class Login extends StatefulWidget {

  @override
  State<Login> createState() => _Login();
}


  class _Login extends State<Login>{

    bool _obscureText = true;
  bool flag = false;
  static final  TextEditingController emailController = TextEditingController();
  late String editors = '';
  static final  TextEditingController passwordController = TextEditingController();
  var _text ;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

    String errorTextvalue = '';
    String errorTextPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only( top: 68.0,),
              width: 326,
              height: 54,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const <Widget>[
                          //SvgPicture.asset('assets/images/small_left.svg',color: const Color.fromRGBO(196, 196, 196, 1),),
                          //SizedBox(width: 16,),
                          Text("Welcome!",
                            style: TextStyle(color: Color.fromRGBO(25, 26, 25, 1),fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700, fontSize: 21, fontFamily: 'Nunito'),),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text("Sign Up",
                            style: TextStyle(color: Color.fromRGBO(237, 28, 36, 1),fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Nunito'),),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4,),
                  Container(
                    //padding: const EdgeInsets.only(left: 25,),
                    child: const Text("Sign in to continue",
                      style: TextStyle(color: Color.fromRGBO(196, 196, 196, 1),fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Nunito'),),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 40,),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Container(
              //margin: const EdgeInsets.only(left: 24.0,right: 24,),
              width: 327,
              //height: 168,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  const Text("Email Address",
                    style: TextStyle(color: Color.fromRGBO(196, 196, 196, 1),fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Nunito'),),
                  const SizedBox(height: 8,),
                  Row(
                    children:    [
                      Expanded(
                        child:  SizedBox(
                          width: 156,
                         // height: 48,
                          child: TextField(
                            onChanged: (value){

                            },
                            controller: emailController,
                            decoration: InputDecoration(
                              errorText: errorTextvalue.isEmpty ? null : 'Please input the correct email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelText: 'Email',
                              hintText: 'Enter Your EmailAddress',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  Password(),
                  const SizedBox(height: 8,),
              SizedBox(
                width: 327,
                //height: 48,
                child: TextField(
                  controller: passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    errorText: errorTextPassword.isEmpty ? null : 'Please your password must be greater than two',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(width: 3,)
                    ),
                    labelText: 'Password',
                    hintText: 'Input your Password',
                    //errorText: _errorText,
                    suffixIcon: IconButton(
                      icon: _obscureText ? const Icon(Icons.visibility_off, //change icon based on boolean value
                        color: Color.fromRGBO(196, 196, 196, 1),
                      ) : const Icon(Icons.visibility_outlined, //change icon based on boolean value
                        color: Color.fromRGBO(196, 196, 196, 1),
                      ),
                      onPressed: _toggle,
                    ),
                  ),
                  style: const TextStyle(color: Color.fromRGBO(196, 196, 196, 1),fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Nunito'),
                  onChanged: (value) => {
                    // setState(() {
                    //   _text = value;
                    //   print('Print value here 1111 ${value}');
                    //   print('Print _text here 1111 ${_text}');
                    // }),
                  },
                ),
              ),
                  //InputPassword(),

                ],
              ),
            ),
          ],
        ),
            const SizedBox(height: 16,),
            Container(
              margin: const EdgeInsets.only(left: 24.0,right: 24,),
              width: 327,
              height: 36,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children:  [
                  SizedBox(
                    width: 107,
                    height: 20,
                    child: InkWell(
                      onTap: (){
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ForgotPassword()),
                        // );
                      } ,
                      child: const Text("Forgot Password",
                        style: TextStyle(color: Color.fromRGBO(237, 28, 36, 1),fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Nunito'),),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40,),
            Container(
              margin: const EdgeInsets.only(left: 24.0,right: 24,),
              width: 327,
              height: 48,
              child: SizedBox(
                width: 327,
                height: 50,
                child: FlatButton(
                   shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text('Continue',
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),),
                  color: (passwordController.value.text.length > 2) ? const Color.fromRGBO(
                      1, 66, 150, 1) : const Color.fromRGBO(196, 196, 196, 1),
                  textColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      print('value here is ${emailController.value.text}');
                      print('value here is ${passwordController.value.text.length}');
                      if(passwordController.value.text.length <= 2) {
                        errorTextPassword = passwordController.value.text;
                      }else{
                        errorTextPassword = '';
                      }
                      if (!emailController.value.text.contains('@')) {
                        if(emailController.value.text.isNotEmpty) {
                          errorTextvalue = emailController.value.text;
                        }else{
                          errorTextvalue = 'Do not be empty';
                        }
                      }else {
                        errorTextvalue = '';
                      }
                      print(errorTextvalue.isEmpty);
                      print(errorTextvalue.isEmpty);
                      print(errorTextPassword.isEmpty);
                      if(errorTextvalue.isEmpty && errorTextPassword.isEmpty) {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Detect(XFile('')),),
                      );
                      }
                    });

                  },
                ),
              ),
              //Button(_InputPassword().changeText!),
            ),
            const SizedBox(height: 24,),
            Container(
              margin: const EdgeInsets.only(left: 24.0,right: 24,),
              width: 327,
              height: 48,
              child: RegisterGoogle(),
            ),
            // RegisterGoogle(),
          ],
        ),
        ),
    );
  }
}

class Password extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 91,
      height: 20,
      child: Text("Password",
        style: TextStyle(color: Color.fromRGBO(196, 196, 196, 1),fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Nunito'
        ),
      ),
    );
  }
}

class InputPassword extends StatefulWidget {

  //var passwordController;



  @override
  State<InputPassword> createState() => _InputPassword();
}

  class _InputPassword extends State<InputPassword>{
    final GlobalKey<_InputPassword> _refreshIndicatorKey =
    new GlobalKey<_InputPassword>();
    bool _obscureText = true;
    static final  TextEditingController passwordController = TextEditingController();
    var _text ;

    void _toggle() {
      setState(() {
        _obscureText = !_obscureText;
      });
    }

    @override
    void dispose() {
      super.dispose();
      passwordController.dispose();
    }


     String? get changeText {
      // at any time, we can get the text from _controller.value.text
      var text;

        text = passwordController.value.text;

      return text;
    }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327,
      height: 48,
      child: TextField(
        key: _refreshIndicatorKey,
        controller: passwordController,
        obscureText: _obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 3,)
          ),
          labelText: 'Password',
          hintText: 'Input your Password',
          //errorText: _errorText,
          suffixIcon: IconButton(
            icon: _obscureText ? const Icon(Icons.visibility_off, //change icon based on boolean value
              color: Color.fromRGBO(196, 196, 196, 1),
            ) : const Icon(Icons.visibility_outlined, //change icon based on boolean value
              color: Color.fromRGBO(196, 196, 196, 1),
            ),
            onPressed: _toggle,
          ),
        ),
        style: const TextStyle(color: Color.fromRGBO(196, 196, 196, 1),fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Nunito'),
        onChanged: (value) => {
        setState(() {
        _text = value;
        print('Print value here 1111 ${value}');
        print('Print _text here 1111 ${_text}');
        Button(_text);
        }),
      },
      ),
    );
  }
}

class Button extends StatefulWidget {
 String process;

  Button(this.process);
  @override
  State<Button> createState() => _Button();
}


class _Button extends State<Button> {

  final GlobalKey<_Button> _refreshIndicatorKey =
  new GlobalKey<_Button>();


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
     ValueNotifier<String> popup = ValueNotifier<String>(widget.process);
     setState(() {
       popup.value = widget.process;
     });
    print('Button plate ${widget.process}');
    return ValueListenableBuilder<String>(
        valueListenable: popup,
        builder: (context, value,_) {
         return  SizedBox(
            width: 327,
            height: 50,
            child: FlatButton(
              key: _refreshIndicatorKey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text('Continue',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),),
              color: (popup.value.length > 2) ? const Color.fromRGBO(
                  1, 66, 150, 1) : const Color.fromRGBO(196, 196, 196, 1),
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  popup.value = widget.process;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Detect(XFile('')),),
                );
              },
            ),
          );
        });
  }
}

class RegisterGoogle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327,
      height: 50,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(width: 1, style: BorderStyle.solid, color: Color.fromRGBO(223, 222, 228,1)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            SvgPicture.asset('assets/images/google.svg',),
            const SizedBox(width: 10,),
            const Text("Or continue with Google",
              style: TextStyle(color: Color.fromRGBO(196, 196, 196, 1),fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Nunito'
              ),
            ),
          ],
        ),
        textColor: Colors.blue,
        onPressed: () {},
      ),
    );
  }
}


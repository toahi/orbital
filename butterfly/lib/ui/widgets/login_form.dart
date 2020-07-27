
import 'package:butterfly/bloc/bloc.authentication/authentication_bloc.dart';
import 'package:butterfly/bloc/bloc.authentication/authentication_event.dart';
import 'package:butterfly/bloc/bloc.login/login_bloc.dart';
import 'package:butterfly/bloc/bloc.login/login_event.dart';
import 'package:butterfly/bloc/bloc.login/login_state.dart';
import 'package:butterfly/repositories/user_repository.dart';
import 'package:butterfly/ui/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({ @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;
  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;


  bool isLoginButtonEnabled (LoginState state){
    return isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context); // same as the respective line of code in the sign up form page

    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);

    super.initState();
  }

  void _onFormSubmitted(){
    _loginBloc.add(LoginWithCredentialsPressed(email: _emailController.text, password: _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return BlocListener<LoginBloc,LoginState>( //same as the respective lines of code on the sign up bloc
      listener: (BuildContext context, LoginState state){
        if(state.isFailure){
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                SnackBar(
                    content:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Login Failed"),
                        Icon(Icons.error),
                      ],
                    )
                )
            );
        }
        if(state.isSubmitting){
          print("isSubmitting");

          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                SnackBar(
                    content:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Logging in ..."),
                        CircularProgressIndicator(),
                      ],
                    )
                )
            );
        }
        if(state.isSuccess){
          print("Success");
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },


      child: BlocBuilder<LoginBloc,LoginState>( // does the same job as the lines in the signUp form respectively
        builder: (context, state){
          return SingleChildScrollView(
            scrollDirection: Axis.vertical ,
            child: Container(
              color: Colors.cyan[100],
              width: size.width,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child:Text("Butterfly",
                        style:TextStyle(fontSize: size.width*0.17, color: Colors.white, letterSpacing: 2.0,)
                    ),
                  ),
                  Container(
                    width: size.width*0.8,
                    child: Divider(
                      height: size.height*0.05, color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.height*0.02),
                    child: TextFormField(
                      controller: _emailController,
                      autovalidate: true,
                      validator: (_){
                        return !state.isEmailValid ? "Invalid Email" :null;
                      },
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: size.height *0.03
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1.0),
                        ),
                      ),

                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.height*0.02),
                    child: TextFormField(
                      controller: _passwordController,
                      autocorrect: false,
                      obscureText: true,
                      autovalidate: true,
                      validator: (_){
                        return !state.isPasswordValid ? "Invalid Password" :null;
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: size.height *0.03
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1.0),
                        ),
                      ),

                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(size.height*0.02),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: isLoginButtonEnabled(state) ? _onFormSubmitted : null,
                          child: Container(
                            width: size.width*0.8,
                            height: size.height*0.06,
                            decoration: BoxDecoration(
                              color: isLoginButtonEnabled(state)
                                  ? Colors.white
                                  : Colors.grey[400],
                              borderRadius: BorderRadius.circular(size.height*0.05),),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: size.height *0.025,
                                    color: Colors.cyan[500]
                                ),
                              ),

                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:(context){
                                  return SignUp(userRepository: _userRepository);
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up for New Account",
                            style: TextStyle(
                              fontSize: size.height * 0.025,
                              color: Colors.white,
                            ),
                          )
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onEmailChanged(){
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged(){
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

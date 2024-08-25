import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/Provider/authService.dart';
import 'package:todo_list_flutter/screens/home.dart';

class LoginRegisterScreen extends StatefulWidget {
  @override
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 280,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLogin ? 'SIGN IN' : 'SIGN UP',
                  style: const TextStyle(
                      fontSize: 33, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 50,
                ),
                if (!isLogin)
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                        hintText: 'Username', prefixIcon: Icon(Icons.person)),
                  ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: 'Email', prefixIcon: Icon(Icons.email)),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      hintText: 'Password', prefixIcon: Icon(Icons.password)),
                  obscureText: true,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(isLogin
                        ? "Don't have an account?"
                        : 'Have an account? '),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      child: Text(
                        isLogin ? "Register Here" : 'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.deepPurple.shade400),
                      ),
                      onTap: () => setState(() {
                        isLogin = !isLogin;
                      }),
                    )
                  ],
                ),
                SizedBox(height: 40),
                SizedBox(
                  height: 50,
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () async {
                      final authService =
                          Provider.of<AuthService>(context, listen: false);
                      String? result;
                      if (isLogin) {
                        result = await authService.loginWithEmailPassword(
                          _emailController.text,
                          _passwordController.text,
                        );
                      } else {
                        result = await authService.registerWithEmailPassword(
                          _emailController.text,
                          _passwordController.text,
                          _usernameController.text,
                        );
                      }

                      if (result != null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(result)));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Success!')));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHome(),
                            ));
                      }
                    },
                    child: Text(
                      isLogin ? 'LOGIN' : 'SIGN UP',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.zero, // Removes rounded corners
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

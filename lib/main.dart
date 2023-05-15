import 'package:flutter/material.dart';

void main() => runApp(LoginApp());

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: {
        '/forgot_password': (context) => ForgotPasswordPage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<Map<String, String>> accountList = [
    {'username': 'user1', 'password': 'password1'},
    {'username': 'user2', 'password': 'password2'},
    {'username': 'user3', 'password': 'password3'},
  ];
  String? selectedAccount;
  bool _rememberPassword = false;
  bool _passwordVisible = false;

  // Text editing controllers for username, password and create account fields
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController createUsernameController = TextEditingController();
  TextEditingController createPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // Key for form validation
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Validation function for the create account form
  String? _validateCreateAccountForm(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }
    if (value.length < 6) {
      return 'Username must be at least 6 characters long.';
    }
    if (accountList.any((account) => account['username'] == value)) {
      return 'This username is already taken.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF73AEF5),
                  Color(0xFF61A4F1),
                  Color(0xFF478DE0),
                  Color(0xFF478DE4),
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Username field
                          TextFormField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              labelStyle: TextStyle(
                                color: Colors
                                    .white, // Ubah warna label menjadi putih
                              ),
                            ),
                            style: TextStyle(
                              color: Colors
                                  .white, // Ubah warna teks output menjadi putih
                            ),
                          ),
                          SizedBox(height: 15.0),
                          // Password field
                          TextFormField(
                            controller: passwordController,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              suffixIcon: IconButton(
                                icon: _passwordVisible
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              labelStyle: TextStyle(
                                color: Colors
                                    .white, // Ubah warna label menjadi putih
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 10.0),
                          Theme(
                            data: Theme.of(context).copyWith(
                              unselectedWidgetColor:
                                  Colors.white, // Set checkbox color to white
                            ),
                            child: Row(
                              children: <Widget>[
                                Checkbox(
                                  value: _rememberPassword,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _rememberPassword = value ?? false;
                                    });
                                  },
                                ),
                                Text(
                                  'Remember Password',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Spacer(),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/forgot_password');
                                  },
                                  child: Text(
                                    'Forgot Password ?',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30.0),
                          FractionallySizedBox(
                            widthFactor: 0.8,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Color(0xFF527DAA),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 17.0),
                              ),
                              onPressed: () {
                                // Login button pressed
                                if (_formKey.currentState!.validate()) {
                                  if (selectedAccount != null) {
                                    String username = selectedAccount!;
                                    String password = passwordController.text;
                                    if (validateCredentials(
                                        username, password)) {
                                      print('Login successful: $username');
                                    } else {
                                      print('Invalid username or password');
                                    }
                                  }
                                }
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 17.0),
                          Text(
                            '- OR -',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 3.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () => print('Login with Facebook'),
                                  child: Container(
                                    height: 40.0,
                                    width: 60.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/facebook.png'),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.black26.withOpacity(0.1),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(
                                              0, 3), // mengatur posisi bayangan
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => print('Login with Google'),
                                  child: Container(
                                    height: 40.0,
                                    width: 60.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/google.png'),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0),
                          GestureDetector(
                            onTap: () {
                              // Navigate to the create account page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateAccountPage(),
                                ),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Still dont't have acc yet? Create account",
                                style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.solid,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      }),
    );
  }

  bool validateCredentials(String username, String password) {
    for (var account in accountList) {
      if (account['username'] == username && account['password'] == password) {
        return true;
      }
    }
    return false;
  }
}

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;

  ForgotPasswordPage({Key? key})
      : emailController = TextEditingController(),
        formKey = GlobalKey<FormState>(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.0),
                // Email field
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required.';
                    }
                    // You can add more validation rules for the email here if needed
                    return null;
                  },
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      String email = emailController.text;
                      // TODO: Add your forgot password logic here
                      print('Forgot password for email: $email');
                      Navigator.pop(context); // Go back to the login page
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Reset Password'),
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

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Map<String, String>> accountList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.0),
                // Username field
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                // Password field
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 15.0),
                // Confirm Password field
                TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    if (_validateCreateAccountForm()) {
                      String username = usernameController.text;
                      String password = passwordController.text;
                      String confirmPassword = confirmPasswordController.text;
                      if (password == confirmPassword) {
                        createAccount(username, password);
                        print('Account created: $username');
                        Navigator.pop(context); // Go back to the login page
                      } else {
                        print('Passwords do not match');
                      }
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Create Account'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validateCreateAccountForm() {
    return _formKey.currentState!.validate();
  }

  void createAccount(String username, String password) {
    accountList.add({'username': username, 'password': password});
  }
}

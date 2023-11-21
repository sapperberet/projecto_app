import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projecto_app/MainPage.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String? gender;

  bool isPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();

  void _togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Perform the Firebase authentication here

      // Example: Creating a user with FirebaseAuth
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        // Handle the successful creation of the user account
        print('User created: ${userCredential.user?.uid}');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(),
            ),
        );
            } catch (e) {
        // Handle errors during user creation
        print('Error creating user: $e');
      }
    }
  }
  String? selectedGender ;
  List<String> genderOptions = ['Male', 'Female', 'Ahmed Mostafa'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SingleChildScrollView(
        child:
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              height: 168,

              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('/Vector1upwave.png'),
                fit: BoxFit.fill,

              )),
            ),
            Container(
              // padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF243DC1),
                          Color(0xFF243DC1),
                          Color(0xFF3ABCE5),
                          Color(0xFF3ABCE5),
                        ],
                        tileMode: TileMode.mirror,
                      ).createShader(bounds);
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'Rounded Mplus 1c Bold',
                        fontSize: 50.0,
                        fontWeight: FontWeight.w700,
                        height: 74.0 / 50.0, // line-height / font-size
                        letterSpacing: 0.0,

                        color: Colors.white, // Assuming text color should be white
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   'Email',
                          //   style: TextStyle(fontSize: 16.0),
                          // ),
                          TextFormField(
                            controller: emailController,

                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value?.isEmpty ?? true || !value!.contains('@') ?? false) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(),
                              // suffixIcon: IconButton(
                              //   icon: Icon(
                              //     isPasswordVisible
                              //         ? Icons.visibility
                              //         : Icons.visibility_off,
                              //   ),
                              //   onPressed: _togglePasswordVisibility,
                              // ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          // Text(
                          //   'Password',
                          //   style: TextStyle(fontSize: 16.0),
                          // ),
                          TextFormField(

                            controller: passwordController,
                            obscureText: !isPasswordVisible,
                            validator: (value) {
                              if (value?.isEmpty ?? true || (value?.length ?? 0)  < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          // Text(
                          //   'Age',
                          //   style: TextStyle(fontSize: 16.0),
                          // ),
                          TextFormField(
                            controller: ageController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              int? age = int.tryParse(value!);
                              if (age == null || age < 1 || age > 130) {
                                return 'Please enter a valid age between 1 and 130';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Age",
                              border: OutlineInputBorder(),
                              // suffixIcon: IconButton(
                              //   icon: Icon(
                              //     isPasswordVisible
                              //         ? Icons.visibility
                              //         : Icons.visibility_off,
                              //   ),
                              //   onPressed: _togglePasswordVisibility,
                              // ),
                            ),
                          ),
                          SizedBox(height: 16.0),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Select Gender:',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: DropdownButton<String>(
                                  value: selectedGender,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedGender = newValue;
                                    });
                                  },
                                  items: genderOptions.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Selected Gender: $selectedGender',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.0),
                          Center(
                            child: ElevatedButton(
                              onPressed: _submitForm,
                              child: Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),




                  // Add a signup button or additional controls as needed

                ],
              ),),
            Positioned(
              bottom: 0,
              child : Container(height: 168,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(

                  image: DecorationImage(
                    alignment: Alignment.bottomCenter,
                    image: AssetImage('/Vector2downwave.png'),
                    fit: BoxFit.fill,

                  ))),),
          ]),

      ),
    );
  }
}

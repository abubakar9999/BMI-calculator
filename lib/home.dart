import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  bool _isObsecure = false;

  late Animation animation;
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));

    animationController.forward();
    animation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reset();
          animationController.forward();
        }
      });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _emailController.dispose();
    _passwordController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Colors.teal,
      body: Container(
        width: double.infinity,
        //  padding: EdgeInsets.all(25),
        child: Stack(
          children: [
            CachedNetworkImage(
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              alignment: FractionalOffset(animation.value, 0),
              imageUrl:
                  "https://cdn.pixabay.com/photo/2022/02/20/09/46/lama-7024125_960_720.jpg",
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (!value!.contains("@")) {
                        return "Invalid email Address";
                      }
                    },
                    decoration: InputDecoration(
                      errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red, width: 5)),

                      //suffixIcon: Icon(Icons.email),
                      suffix: Icon(Icons.email),
                      prefixIcon: Icon(Icons.email),
                      //prefix: Icon(Icons.email),

                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red, width: 1)),
                      enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Colors.yellow, width: 1)),
                      hintText: "Enter your email",
                      labelText: "Enter your email",
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.red),
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: _isObsecure,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your password";
                      }
                      if (value.length > 6) {
                        return " password is too long";
                      }
                      if (value.length < 3) {
                        return " password is too short";
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      //suffixIcon: Icon(Icons.email),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObsecure = !_isObsecure;
                          });
                        },
                        icon: Icon(_isObsecure
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      prefixIcon: Icon(Icons.password),
                      //prefix: Icon(Icons.email),

                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Colors.yellow, width: 1)),
                      hintText: "Enter your Password",
                      labelText: "Enter your Password",
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.red),
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        print("Okkkkkkkkkkkkkkkkkkkkkkkkkk");
                      } else {
                        print("Something wrong");
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 25),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      color: Colors.black,
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

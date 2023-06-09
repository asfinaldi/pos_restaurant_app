import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  Widget build(context, LoginController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      QTextField(
                        label: "Email",
                        hint: "Your email",
                        validator: Validator.email,
                        suffixIcon: Icons.email,
                        value: controller.email,
                        onChanged: (value) {
                          controller.email = value;
                        },
                      ),
                      QTextField(
                        label: "Password",
                        hint: "Your password",
                        obscure: true,
                        validator: Validator.required,
                        suffixIcon: Icons.password,
                        value: controller.password,
                        onChanged: (value) {
                          controller.password = value;
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 42,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.login),
                          label: const Text("Login"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                          onPressed: () => controller.doLogin(),
                        ),
                      ),

                      const SizedBox(
                      height: 20.0,
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 42,
                        child: ElevatedButton.icon(
                        icon: const Icon(Icons.login),
                        label: const Text("Login by Google"),
                        style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        ),
                        onPressed: () => controller.doGoogleLogin(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<LoginView> createState() => LoginController();
}

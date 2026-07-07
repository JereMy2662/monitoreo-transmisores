import 'package:aplicacion_transmisores/features/auth/presentation/register_screen.dart';
import 'package:aplicacion_transmisores/features/home/presentation/home_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();

  final passwordController =
      TextEditingController();

  bool loading = false;

  Future<void> login() async {

    try {

      setState(() {
        loading = true;
      });

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(

        email: emailController.text.trim(),

        password:
            passwordController.text.trim(),
      );

      if (!mounted) return;

Navigator.pushReplacement(
  context,

  MaterialPageRoute(
    builder: (_) => HomeScreen(
      loginTime: DateTime.now(),
    ),
  ),
);

    } on FirebaseAuthException catch (e) {

      String mensaje = "Error al iniciar sesión";

      if (e.code == 'invalid-credential') {
        mensaje = "Correo o contraseña incorrectos";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensaje)),
      );

    } finally {

      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {

            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),

              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),

                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom:
                        MediaQuery.of(context)
                            .viewInsets
                            .bottom,
                  ),

                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

Center(
  child: Image.asset(
    'assets/images/logo.png',

    width: 170,
  ),
),

                      const SizedBox(height: 20),

                      const Center(
                        child: Text(
                          "Iniciar sesión",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Correo",
                        style:
                            TextStyle(color: Colors.white),
                      ),

                      const SizedBox(height: 5),

                      TextField(
                        controller: emailController,

                        style: const TextStyle(
                          color: Colors.white,
                        ),

                        decoration: InputDecoration(
                          hintText:
                              "Ingresa tu correo",

                          hintStyle:
                              const TextStyle(
                            color: Colors.grey,
                          ),

                          filled: true,

                          fillColor:
                              const Color(0xFF1C1C3A),

                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                              10,
                            ),

                            borderSide:
                                BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        "Contraseña",
                        style:
                            TextStyle(color: Colors.white),
                      ),

                      const SizedBox(height: 5),

                      TextField(
                        controller:
                            passwordController,

                        obscureText: true,

                        style: const TextStyle(
                          color: Colors.white,
                        ),

                        decoration: InputDecoration(
                          hintText:
                              "Ingresa tu contraseña",

                          hintStyle:
                              const TextStyle(
                            color: Colors.grey,
                          ),

                          filled: true,

                          fillColor:
                              const Color(0xFF1C1C3A),

                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                              10,
                            ),

                            borderSide:
                                BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Align(
                        alignment:
                            Alignment.centerRight,

                        child: GestureDetector(
                          onTap: () {},

                          child: const Text(
                            "¿Olvidaste tu contraseña?",

                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed:
                            loading ? null : login,

                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.blue,

                          minimumSize:
                              const Size(
                            double.infinity,
                            50,
                          ),
                        ),

                        child: loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Iniciar sesión",

                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                      ),

                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [

                          const Text(
                            "No tienes una cuenta? ",

                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {

                              Navigator.push(
                                context,

                                MaterialPageRoute(
                                  builder: (_) =>
                                      const RegisterScreen(),
                                ),
                              );
                            },

                            child: const Text(
                              "Regístrate",

                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
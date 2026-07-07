import 'package:aplicacion_transmisores/features/auth/presentation/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final passwordController = TextEditingController();

  final repeatPasswordController = TextEditingController();

  bool loading = false;

  Future<void> register() async {

    if (nameController.text.trim().isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ingresa tu nombre"),
        ),
      );

      return;
    }

    if (passwordController.text !=
        repeatPasswordController.text) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Las contraseñas no coinciden"),
        ),
      );

      return;
    }

    try {

      setState(() {
        loading = true;
      });

      // REGISTRAR EN AUTH
      UserCredential userCredential =
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // GUARDAR EN FIRESTORE
      await FirebaseFirestore.instance
          .collection("usuarios")
          .doc(userCredential.user!.uid)
          .set({

        "nombre": nameController.text.trim(),

        "correo": emailController.text.trim(),

        "telefono": phoneController.text.trim(),

        "uid": userCredential.user!.uid,

        "fechaRegistro": DateTime.now(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Usuario registrado correctamente"),
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );

    } on FirebaseAuthException catch (e) {

      String mensaje = "Error al registrarse";

      if (e.code == 'email-already-in-use') {
        mensaje = "El correo ya está en uso";
      }

      if (e.code == 'weak-password') {
        mensaje = "La contraseña es muy débil";
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
                        MediaQuery.of(context).viewInsets.bottom,
                  ),

                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const SizedBox(height: 40),

                      const Center(
                        child: Text(
                          "Registrarse",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 45),

                      const Text(
                        "Nombre",
                        style:
                            TextStyle(color: Colors.white),
                      ),

                      const SizedBox(height: 5),

                      _input(
                        hint: "Ingresa tu nombre",
                        controller: nameController,
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        "Correo",
                        style:
                            TextStyle(color: Colors.white),
                      ),

                      const SizedBox(height: 5),

                      _input(
                        hint: "Ingresa tu correo",
                        controller: emailController,
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        "Teléfono",
                        style:
                            TextStyle(color: Colors.white),
                      ),

                      const SizedBox(height: 5),

                      _input(
                        hint: "Ingresa tu telefono",
                        controller: phoneController,
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        "Contraseña",
                        style:
                            TextStyle(color: Colors.white),
                      ),

                      const SizedBox(height: 5),

                      _input(
                        hint: "Ingresa tu contraseña",
                        isPassword: true,
                        controller: passwordController,
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        "Repite la contraseña",
                        style:
                            TextStyle(color: Colors.white),
                      ),

                      const SizedBox(height: 5),

                      _input(
                        hint:
                            "Ingresa tu contraseña nuevamente",
                        isPassword: true,
                        controller:
                            repeatPasswordController,
                      ),

                      const SizedBox(height: 25),

                      ElevatedButton(
                        onPressed:
                            loading ? null : register,

                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,

                          minimumSize: const Size(
                            double.infinity,
                            50,
                          ),
                        ),

                        child: loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Registrarse",
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
                            "¿Ya tienes una cuenta? ",
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
                                      const LoginScreen(),
                                ),
                              );
                            },

                            child: const Text(
                              "Inicia sesión",
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

  static Widget _input({
    required String hint,
    required TextEditingController controller,
    bool isPassword = false,
  }) {

    return TextField(
      controller: controller,

      obscureText: isPassword,

      style: const TextStyle(color: Colors.white),

      decoration: InputDecoration(
        hintText: hint,

        hintStyle: const TextStyle(
          color: Colors.grey,
        ),

        filled: true,

        fillColor: const Color(0xFF1C1C3A),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
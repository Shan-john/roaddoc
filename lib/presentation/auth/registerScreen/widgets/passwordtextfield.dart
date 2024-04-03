import 'package:flutter/material.dart';


class PasswordTextField extends StatefulWidget {
  final TextEditingController passwordcontroller;
  PasswordTextField({
    super.key,
    required this.passwordcontroller,
  });

  bool obscuretext = true;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60 , 
      decoration:  BoxDecoration(
       
          border: Border.all(color: Colors.black,width: 4),
          borderRadius: BorderRadius.all(Radius.circular(5))),
     // margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        cursorColor: const Color.fromARGB(255, 8, 8, 8),
        
        style: const TextStyle(color: Color.fromARGB(255, 10, 10, 10)),
        obscureText: widget.obscuretext,
        controller: widget.passwordcontroller,
        decoration: InputDecoration(
           border: InputBorder.none,
          // ink well to switch the visiblity to true and false
          suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  widget.obscuretext = !widget.obscuretext;
                });
              },
              child: widget.obscuretext == false
                  ? const Icon(Icons.remove_red_eye)
                  : const Icon(Icons.visibility_off)),
          hintText: "Password",
          hintStyle: const TextStyle(
              color: Color.fromARGB(151, 43, 43, 43), fontSize: 20),
        ),
      ),
    );
  }
}

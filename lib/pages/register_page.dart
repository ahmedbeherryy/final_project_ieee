import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'controller_page.dart';

class RegisterPage extends StatefulWidget {
    RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
   String? email;

   String? password;

   bool IsLoading =false;

   GlobalKey<FormState> formKey =GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: IsLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor ,
        body:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key:formKey ,
            child: ListView(
              children: [
                // Spacer(flex: 2,),
                SizedBox(height: 50,),
                Image.asset(KLogo,height: 200,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Scholar Chat',style:
                    TextStyle(fontSize: 32,color: Colors.white,fontFamily: 'Pacifico'),),
                  ],
                ),
                // Spacer(flex: 1,),
                SizedBox(height: 70,),
                const Row(
                  children: [
                    Text(
                      'REGISTER',style: TextStyle(
                        color: Colors.white,fontSize: 22),),
                  ],
                ),
                SizedBox(height: 20,),
                CustomFormTextField(
                  onChange:(data) //هستقبل استرينج
                  {
                    email=data;
                  },
                  hintText: 'Email',),
                SizedBox(height: 11,),
                CustomFormTextField(
                    onChange: (data)
                    {
                      password=data;
                    },
                    hintText: 'Password'),
                SizedBox(height: 20,),
                CustomButton(width: double.infinity,
                  buttomText: 'REGISTER',
                  onTap: ()async {
                if (formKey.currentState!.validate()) {
                  IsLoading=true;
                  setState(() {});
                  try{
                    await registerUser();
                    showSnackBar(context, 'Success');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ControllerPage(),));
                    //new screen
                  }on FirebaseAuthException catch(ex)
                  {
                    if (ex.code == 'weak-password') {
                      showSnackBar(context,'The password provided is too weak');
                    } else if (ex.code == 'email-already-in-use') {
                     showSnackBar(context, 'The account already exists for that email.');
                    }
                  }catch(ex)
                      {
                        showSnackBar(context, 'there was an error');
                      }
                      IsLoading=false;
                  setState(() {

                  });
                }else{

                }
                  },
                ),
                SizedBox(height: 9,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("I have an account? ",style:
                    TextStyle(color: Colors.white),),
                    GestureDetector(
                      onTap: ()
                      {
                        Navigator.pop(context);
                      },
                      child: Text('Login',style:
                      TextStyle(color: Colors.lightBlue),),
                    )

                  ],),
                // Spacer(flex: 3,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user =await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}

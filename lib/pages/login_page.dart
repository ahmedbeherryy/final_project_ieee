import 'package:final_project_ieee/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'controller_page.dart';

class LoginPage extends StatefulWidget {
   LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   bool IsLoading =false;

   GlobalKey<FormState> formKey =GlobalKey();

   String? email , password;

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
                Image.asset(KLogo,height: 200),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Controller App',style:
                    TextStyle(fontSize: 32,color: Colors.white,fontFamily: 'Pacifico'),),
                  ],
                ),
                // Spacer(flex: 1,),
                SizedBox(height: 70,),
                const Row(
                  children: [
                    Text(
                      'LOGIN',style: TextStyle(
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
                  buttomText: 'LOGIN',
                  onTap: ()async {
                    if (formKey.currentState!.validate()) {
                      IsLoading=true;
                      setState(() {});
                      try{
                        await loginUser();
                        showSnackBar(context, 'Success');
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ControllerPage(),));
                      }on FirebaseAuthException catch(ex)
                      {
                        if (ex.code == 'user-not-found') {
                          showSnackBar(context, 'No user found');
                        } else if (ex.code == 'wrong-password') {
                          showSnackBar(context, 'Wrong password');
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
                    Text("don't have an account? ",style:
                    TextStyle(color: Colors.white),),
                    GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(),));
                      },
                      child: Text('Register',style:
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

   Future<void> loginUser() async {
     UserCredential user =await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: email!, password: password!);
   }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffcad2c5),
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Color(0xff2b2d42),
        title: Text('Homepage'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Welcome To homepage...',style: GoogleFonts.habibi(fontSize: 25,),),
      ),
    );
  }
}

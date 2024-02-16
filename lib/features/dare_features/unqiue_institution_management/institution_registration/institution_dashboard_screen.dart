import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnflow/utils/pallete.dart';
import 'package:learnflow/utils/utils.dart';

class InstitutionDashboardScreen extends StatefulWidget {
  const InstitutionDashboardScreen({super.key});

  @override
  State<InstitutionDashboardScreen> createState() => _InstitutionDashboardScreenState();
}

class _InstitutionDashboardScreenState extends State<InstitutionDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Pallete().bgColor,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://lh3.googleusercontent.com/proxy/M203TuwuLhvA579cDT4QCt1vgGbR9qX8XlVOTQDrKmeMvGfd4_0t2La0sMhXBqxiAytFKn17F9A5xyP9LgdEy-xRFMO4i6hWjaPQ'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sacred Heart Convent School",style: GoogleFonts.poppins(color: Colors.white),),
                      Text("CODE: 1281341",style: GoogleFonts.roboto(color: Colors.white,),)
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20,),
            Center(
              child: Text("Welcome to the dashboard, admin!", style: GoogleFonts.poppins(color: Colors.black,fontSize: 17),),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 180,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const SizedBox(height: 30,),
                      Icon(
                        Icons.class_outlined,
                        size: 60,
                        color: Colors.white,
                      ),
                      const SizedBox(height:30,),
                      Center(
                        child: Text("Announcements!",style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12,),),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                 Container(
                  height: 180,
                  width: 130,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 65, 106, 172),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const SizedBox(height: 30,),
                      Icon(
                        Icons.home_work,
                        size: 60,
                        color: Colors.white,
                      ),
                      const SizedBox(height:30,),
                      Center(
                        child: Text("Home Work!",style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12,),),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                
              ],
            ),
            
            const SizedBox(height: 20,),
            Center(
                  child: Text("More features coming soon!\nWith V: 2.0 Students, faculty management\n, school details management, fees system\n, and sleep monitoring will be added too!",style: GoogleFonts.poppins(color: Colors.black, fontSize: 15,),),
                ),

                const SizedBox(height: 20,),
            Center(
                  child: Text("Made with 💖 by Team CodeCosmos!",style: GoogleFonts.poppins(color: Colors.purple, fontSize: 15,),),
                ),
          ],
        ),
      ),
    );
  }
}
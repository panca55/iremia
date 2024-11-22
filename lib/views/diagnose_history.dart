import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiagnoseHistory extends StatelessWidget {
  const DiagnoseHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Riwayat Diagnosa', style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),),
            const SizedBox(height: 14,),
            Expanded(
              child: ListView.separated(itemBuilder:(context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical:10),
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.25), offset: const Offset(0, 4), blurRadius: 10)
                            ],
                    gradient:const LinearGradient(colors: [
                      Color(0xFF40BFFF),
                      Color(0xFF56CCF2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight
                    )
                  ),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Diagnosa $index', style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: () {
                          
                        },
                        child: Container(
                          width: 82,
                          height:27,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.25), offset: const Offset(0, 4), blurRadius: 10)
                            ]
                          ),
                          child:Center(child: Text('Lihat', style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),)),
                        ),
                      )
                    ],
                  )
                );
              }, separatorBuilder:(context, index) => const SizedBox(height: 14,), itemCount: 3),
            )
          ],
        ),
      ),
    );
  }
}
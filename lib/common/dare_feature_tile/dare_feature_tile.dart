import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DareFeatureTile extends StatefulWidget {
  final String titleText;
  final String bannerImage;
  final String descriptionText;

  const DareFeatureTile(
      {super.key, required this.titleText, required this.descriptionText, required this.bannerImage});

  @override
  State<DareFeatureTile> createState() => _DareFeatureTileState();
}

class _DareFeatureTileState extends State<DareFeatureTile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.2,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[300],
        border: Border.all(width: 1, color: Colors.black),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0).copyWith(
                  top: 15,
                  left: 6,
                ),
                child: Container(
                  height: 120,
                  width: 140,
                  margin: const EdgeInsets.only(left: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                     widget.bannerImage,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.titleText,
                      style: GoogleFonts.alatsi(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 80,
                      child: Text(
                        widget.descriptionText,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:twithc_clone/utils/colors.dart';
import 'package:twithc_clone/utils/size.dart';

class GoLiveScreen extends StatefulWidget {
  const GoLiveScreen({super.key});

  @override
  State<GoLiveScreen> createState() => _GoLiveScreenState();
}

class _GoLiveScreenState extends State<GoLiveScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                dashPattern: const [10, 4],
                strokeCap: StrokeCap.round,
                color: buttonColor,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: buttonColor.withOpacity(.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.folder_open_rounded,
                        color: buttonColor,
                        size: 40,
                      ),
                      kHight10,
                      Text(
                        'Select your Thumbnail',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

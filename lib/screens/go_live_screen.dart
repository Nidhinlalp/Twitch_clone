import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:twithc_clone/resources/firestrore_methods.dart';
import 'package:twithc_clone/responsive/responsive.dart';
import 'package:twithc_clone/screens/brodcast_screen.dart';
import 'package:twithc_clone/utils/colors.dart';
import 'package:twithc_clone/utils/size.dart';
import 'package:twithc_clone/utils/utils.dart';
import 'package:twithc_clone/widgets/custom_button.dart';
import 'package:twithc_clone/widgets/custom_textfield.dart';

class GoLiveScreen extends StatefulWidget {
  const GoLiveScreen({super.key});

  @override
  State<GoLiveScreen> createState() => _GoLiveScreenState();
}

class _GoLiveScreenState extends State<GoLiveScreen> {
  final TextEditingController _titelController = TextEditingController();
  Uint8List? image;
  @override
  void dispose() {
    _titelController.dispose();
    super.dispose();
  }

  void goLive() async {
    String channelId = await FirestoreMethods().startLiveStream(
      context,
      _titelController.text,
      image,
    );
    if (channelId.isNotEmpty && context.mounted) {
      showSnackBar(context, 'Live has Start successfully');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BrodCastScreen(
            isBroadcaster: true,
            channelId: channelId,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Responsive(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Column(
                    children: [
                      image != null
                          ? Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.memory(
                                  image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              color: buttonColor,
                              child: GestureDetector(
                                onTap: () async {
                                  Uint8List? pickedImage = await pickImage();
                                  if (pickedImage != null) {
                                    setState(() {
                                      image = pickedImage;
                                    });
                                  }
                                },
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
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      kHight20,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Title',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: CustomTextField(
                              controller: _titelController,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: CustomButton(
                    text: 'Go Live',
                    onTap: goLive,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:poc_qr/Qr_Scanner/ocr_landing.dart';
import 'package:poc_qr/Qr_Scanner/qr_result.dart';
import 'package:poc_qr/bottom_bar_view.dart';
import 'package:poc_qr/dialogs/Image_Picker_dialog.dart';
import 'package:poc_qr/utils/app_theme.dart';
import 'package:poc_qr/utils/image_picker_util.dart';
import 'package:poc_qr/utils/tabIcon_data.dart';

class LandingPageScreen extends StatefulWidget {
  const LandingPageScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LandingPageScreenState createState() => _LandingPageScreenState();
}

class _LandingPageScreenState extends State<LandingPageScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  String imagePath = "";

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = QRResult(
      closeScanner: () {},
      image: imagePath,
      type: "image",
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () async {
            final selection =
                await showImagePickerDialog(context, closeClick: () {});
            await handleMediaSelection(selection);
          },
          changeIndex: (int index) {
            if (index == 0 || index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = QRResult(
                    closeScanner: () {},
                    image: "",
                    type: "image",
                  );
                });
              });
            } else if (index == 1 || index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = QRResult(
                    closeScanner: () {},
                    image: "",
                    type: "image",
                  );
                });
              });
            }
          },
        ),
      ],
    );
  }

  Future handleMediaSelection(
    selection,
  ) async {
    if (selection == null) return null;

    final file = selection == MediaSelection.gallery
        ? await ImagePickerUtil.pickImageFromGallery()
        : await ImagePickerUtil.pickImageFromCamera();

    if (file != null) {
      setState(() {
        imagePath = file.path;
        tabBody = QRResult(
          closeScanner: () {},
          image: imagePath,
          type: "image",
        );
      });
    }

    return null;
  }
}

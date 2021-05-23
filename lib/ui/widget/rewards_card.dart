import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wear_helmet/global/color.dart';
import 'package:wear_helmet/ui/layout/custom_dialog.dart';

class RewardsCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String desc;

  const RewardsCard(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.desc})
      : super(key: key);

  @override
  _RewardsCardState createState() => _RewardsCardState();
}

class _RewardsCardState extends State<RewardsCard> {
  late String image;

  @override
  void initState() {
    super.initState();
    getImage();
  }

  getImage() async {
    ListResult result = await FirebaseStorage.instance.ref().listAll();
    result.items.forEach((Reference ref) {
      print('Found file: $ref');
    });

    image = await FirebaseStorage.instance
        .ref('images/${widget.imageUrl}.png')
        .getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = new ScreenUtil();
    return Container(
      height: screenUtil.setHeight(130),
      width: screenUtil.setWidth(345),
      padding: EdgeInsets.all(screenUtil.setWidth(11)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Color(0xffe7e7e7)),
      ),
      child: Row(
        children: [
          Container(
            height: screenUtil.setHeight(108),
            width: screenUtil.setWidth(76),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: FutureBuilder(
              future: getImage(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData) {
                  return Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    alignment: Alignment.centerLeft,
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: screenUtil.setWidth(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.desc,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Spacer(),
                      Container(
                        width: screenUtil.setWidth(100),
                        height: screenUtil.setHeight(25),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                ThemeColors.primaryColorLight),
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: screenUtil.setWidth(74),
                              maxHeight: screenUtil.setHeight(25),
                            ),
                            child: Text(
                              'View More',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: ThemeColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          onPressed: () {
                            print(widget.name);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

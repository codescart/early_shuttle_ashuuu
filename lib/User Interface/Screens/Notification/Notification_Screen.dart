import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/Constant/global_call.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/ConstScreens/loadingScreen.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/smallTextStyle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:flutter/material.dart';
import '../../../API/Notification/Notification_Api.dart';
import '../../../Constant/assets.dart';
import '../../../Models/HomePage_Sections/Notification_Model.dart';
import '../../../main.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: ColorConstant.whiteColor,
          ),
        ),
        title: HeadingOne(
          fontWeight: FontWeight.w600,
          Title: "Notification",
        ),
      ),
      body: FutureBuilder<NotificationResponse?>(
        future: fetchNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingData();
          } else if (snapshot.hasError) {
            return Center(
              child: CustomContainer(
                color: ColorConstant.whiteColor,
                height: height,
                child: Image(
                  image: AssetImage(
                    Graphics.nonotify,
                  ),
                  width: widths / 2,
                ),
              ),
            );
          } else if (snapshot.data!.count==0) {
            return  Center(
              child: CustomContainer(
                color: ColorConstant.whiteColor,
                height: height,
                child: Image(
                  image: AssetImage(
                    Graphics.nonotify,
                  ),
                  width: widths / 2,
                ),
              ),
              // CircularProgressIndicator()
            );
          } else {
            final notificationResponse = snapshot.data!;
            final notifications = notificationResponse.notifications;
            return ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return CustomContainer(
                    margin: const EdgeInsets.all(10),
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      tileMode: TileMode.mirror,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        ColorConstant.gradientLightGreen,
                        ColorConstant.gradientLightblue
                      ],
                    ),
                    // padding: EdgeInsets.all(10),
                    child: ExpansionTile(
                      iconColor: ColorConstant.blueColor,
                      initiallyExpanded:index == 0?true:false,
                      tilePadding:
                          const EdgeInsets.only(left: 5, right: 5, bottom: 0),
                      leading: const Icon(Icons.notifications),
                      title: SubTitle_Text(
                        alignment: Alignment.centerLeft,
                        fontSize: 18,
                        textAlign: TextAlign.left,
                        Title: notification.header,
                      ),
                      trailing: Small_Text(
                        width: widths / 5,
                        textAlign: TextAlign.right,
                        Title: notification.updatedAt.substring(0, 10),
                      ),
                      children: [
                        ListTile(
                          subtitle: SubTitle_Text(
                            textAlign: TextAlign.left,
                            Title: notification.detail,
                          ),
                        )
                      ],
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}

// Notification Icon for Home Page
class NotificationIcon extends StatelessWidget {
  final String NotificationCount;
  NotificationIcon(this.NotificationCount);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const NotificationScreen()));
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            icon:
                const Icon(Icons.notifications, color: Colors.white, size: 28),
            onPressed: () {
              // Handle notification icon tap
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationScreen()));
            },
          ),
          Positioned(
            top: 5,
            right: 5,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                NotificationCount
                    .toString(), // Replace with your notification count
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: 50,
          )
        ],
      ),
    );
  }
}

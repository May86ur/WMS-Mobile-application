import 'package:flutter/material.dart';
import 'package:water_management_system/Operations/StateselectionOperation.dart';
import 'package:water_management_system/Utils/Permisstion.dart';

class NotificationAlarm extends StatefulWidget {
  const NotificationAlarm({super.key});

  @override
  State<NotificationAlarm> createState() => _NotificationAlarmState();
}

class _NotificationAlarmState extends State<NotificationAlarm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Notification Page'),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: getActiveAlarmData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something Went Wrong'),
                );
              } else if (snapshot.connectionState == 'waiting') {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                // Loop through each data item
                for (var data in snapshot.data!) {
                  PermissionHandler.showNotification(data.tagId ?? 0,
                      data.tagName ?? '', data.description ?? '');
                }

                // Add your ListView or other UI elements here (optional)
                return Container() /*ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          PermissionHandler.showNotification(
                              snapshot.data![index].description,
                              snapshot.data![index].lastUpdateTime);
                        },
                        tileColor: Colors.deepPurple[100],
                        title: Text(snapshot.data![index].description ?? ''),
                      ),
                    );
                  },
                )*/
                    ; // Replace with your desired UI
              } else {
                return const Center(
                  child: Text('unable to connect API'),
                );
              }
            },
          )
        ],
      ),
    );
  }
}

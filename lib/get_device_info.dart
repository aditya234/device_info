import 'package:flutter/material.dart';
import 'package:uuidtest/device_service.dart';
import 'package:uuidtest/firestore_service.dart';
import 'package:uuidtest/previous_devices.dart';

class GetDeviceInfo extends StatefulWidget {
  @override
  _GetDeviceInfoState createState() => _GetDeviceInfoState();
}

class _GetDeviceInfoState extends State<GetDeviceInfo> {
  Map<String, String> deviceData = {};
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: (isLoading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                (deviceData.isNotEmpty)
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Table(
                          border: TableBorder.all(
                            color: Colors.grey,
                          ),
                          children: _getTableRows(),
                        ),
                      )
                    : SizedBox(),
                InkWell(
                  onTap: () async {
                    if (!isLoading) {
                      setState(() {
                        isLoading = true;
                      });
                      deviceData['device_id'] = await DeviceService().deviceId;
                      final androidDeviceInfo =
                          await DeviceService().deviceModel;
                      deviceData['device_model'] = androidDeviceInfo.model;
                      deviceData['datetime'] = DateTime.now().toString();
                      await FirestoreService().createRecord(deviceData);
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(40),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      'Fetch Device Details',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => PreviousDevices()));
        },
        child: Icon(Icons.show_chart),
      ),
    );
  }

  _getTableRows() {
    List<TableRow> tableRows = [];
    tableRows.add(_createTableRow('Device Id', deviceData['device_id']));
    tableRows.add(_createTableRow('Device Model', deviceData['device_model']));
    tableRows.add(_createTableRow('DateTime', deviceData['datetime']));
    return tableRows;
  }

  _createTableRow(String title, String data) {
    return TableRow(
      children: [
        Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(title),
        )),
        Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(data),
        )),
      ],
    );
  }
}

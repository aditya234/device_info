import 'package:flutter/material.dart';
import 'package:uuidtest/firestore_service.dart';

class PreviousDevices extends StatefulWidget {
  @override
  _PreviousDevicesState createState() => _PreviousDevicesState();
}

class _PreviousDevicesState extends State<PreviousDevices> {
  List<Map> devices = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    FirestoreService().getRecords().then((deviceList) {
      isLoading = false;
      setState(() {
        devices = deviceList;
      });
    }).catchError((err) {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: (isLoading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: _getDeviceInfoTables(),
            ),
    );
  }

  _getDeviceInfoTables() {
    List<Widget> deviceInfoTables = [];
    devices.forEach((device) {
      deviceInfoTables.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: Table(
          border: TableBorder.all(
            color: Colors.grey,
          ),
          children: _getTableRows(device),
        ),
      ));
    });
    if (deviceInfoTables.isEmpty) {
      return [
        Center(
          child: Text('No devices recorded yet!'),
        ),
      ];
    }
    return deviceInfoTables;
  }

  _getTableRows(Map device) {
    List<TableRow> tableRows = [];
    tableRows.add(_createTableRow('Device Id', device['device_id']));
    tableRows.add(_createTableRow('Device Model', device['device_model']));
    tableRows.add(_createTableRow('DateTime', device['datetime']));
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

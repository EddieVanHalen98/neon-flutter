import 'package:flutter/material.dart';
import '../time.dart';
import '../main.dart';
import '../array.dart';
import '../cache_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../scheduled_notifcations.dart';

var edit = false; // Check if user is editing a cell and not adding, used to edit the hintText message

addDialog(context, currentHour, setState)  {
  String input = "";

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: new Text(
            'What\'s in store at ${getHours(currentHour).toLowerCase()}?'),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                cursorColor: Colors.orange,
                autofocus: true,
                decoration: new InputDecoration(hintText: edit == true ? cells[currentHour] : 'Revise Maths'),
                onChanged: (value) => input = value // Update the empty label array with the value they have entered
              ),
            )
          ],
        ),
        actions: <Widget>[ // usually buttons at the bottom of the dialog
          new FlatButton(
            textColor: Colors.grey,
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            textColor: primaryColor,
            child: new Text("Add"),
            onPressed: () {
              Navigator.of(context).pop();
              setState(() { // This should rerun the build widget and return the updated viewList
                cells[currentHour] = input == '' ? 'Empty' : input; // If they enter nothing then add empty again
                save(currentHour,  cells[currentHour]); // Save message and use the hour as the key
                print("CELLS ARE $cells");
                edit = false;
              });
            },
          ),
        ],
      );
    },
  );
}


editDialog(context, currentHourKey, setState) async  {
  final prefs = await SharedPreferences.getInstance();

  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return Container(

          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  trailing: new Icon(Icons.edit),
                  title: new Text('Edit'),
                  onTap: () {
                    Navigator.of(context).pop();
                    edit = true;
                    addDialog(context, currentHourKey, setState);
                  }
              ),
              new ListTile(
                  trailing: new Icon(Icons.delete),
                title: new Text('Clear'),
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() {
                        cells[currentHourKey] = 'Empty';
                        print('editing cell: $currentHourKey');
                        prefs.remove(currentHourKey.toString()); // Remove key from cache
                        keys.remove(currentHourKey.toString());
                    });
                  }
              ),
              new ListTile(
                  trailing: new Icon(Icons.timer),
                title: new Text('set reminder'),
                onTap: () {
                 Navigator.of(context).pop();
                 _setRemainderDialog(context, currentHourKey);
                  }
              ),
              new ListTile(
                  trailing: new Icon(Icons.cancel),
                title: new Text('cancel'),
                  onTap: () {
                    Navigator.of(context).pop();
                  }
              ),
            ],
          ),
        );
      }
  );
}


_setRemainderDialog(context, cellTime)  {
  // currentHour = cellTime
  // we pass the currentHour to get the corresponding cell

  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  title: new Text('60 Minutes'),
                  onTap: () {
                    scheduleNotification(cellTime, 60);
                    Navigator.of(context).pop();
                  }
              ),
              new ListTile(
                  title: new Text('30 Minutes'),
                  onTap: () {
                    scheduleNotification(cellTime, 30);
                    Navigator.of(context).pop();
                  }
              ),
              new ListTile(
                  title: new Text('15 Minutes'),
                  onTap: () {
                    scheduleNotification(cellTime, 15);
                    Navigator.of(context).pop();
                  }
              ),
              new ListTile(
                  title: new Text('5 Minutes'),
                  onTap: () {
                    scheduleNotification(cellTime, 5);
                    Navigator.of(context).pop();
                  }
              ),
              new ListTile(
                  title: new Text('cancel'),
                  onTap: () {
                    Navigator.of(context).pop();
                  }
              ),
            ],
          ),
        );
      }
  );
}
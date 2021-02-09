import 'dart:async';

import 'package:blogapp/zoom/meeting_screen.dart';

import 'package:flutter/material.dart';
import 'package:blogapp/zoom/start_meeting_screen.dart';
import 'package:flutter_icons/flutter_icons.dart';

class JoinWidget extends StatefulWidget {
  @override
  _JoinWidgetState createState() => _JoinWidgetState();
}

class _JoinWidgetState extends State<JoinWidget> {
  TextEditingController meetingIdController = TextEditingController()
    ..text = '84341987048';
  TextEditingController meetingPasswordController = TextEditingController()
    ..text = 'anabata';

  @override
  Widget build(BuildContext context) {
    // new page needs scaffolding!
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: ListView(
            children: <Widget>[
              Container(
                child: IconButton(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(0),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Ionicons.ios_arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                'Join meeting',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Visibility(
                  visible: false,
                  child: TextFormField(
                    controller: meetingIdController,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Visibility(
                  visible: false,
                  child: TextFormField(
                    controller: meetingPasswordController,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context) {
                    // The basic Material Design action button.
                    return RaisedButton(
                      // If onPressed is null, the button is disabled
                      // this is my goto temporary callback.
                      onPressed: () => joinMeeting(context),
                      child: Text('Join'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  joinMeeting(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MeetingWidget(
              meetingId: meetingIdController.text,
              meetingPassword: meetingPasswordController.text);
        },
      ),
    );
  }

  startMeeting(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return StartMeetingWidget(meetingId: meetingIdController.text);
        },
      ),
    );
  }
}

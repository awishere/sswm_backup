import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'dart:html' as html;
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:sswm_web/constraints/color.dart';
import 'package:sswm_web/widgets/appBar.dart';
import 'package:sswm_web/widgets/sidebar.dart';

import 'package:video_player/video_player.dart';

class ComplainDetails extends StatefulWidget {
  static String routeName = "/complain-detail";
  String complainID;
  String complainSubject;
  String complainDescription;
  String complainFullName;
  String extras;
  String complainAddress;
  String complainStatus;
  String userID;
  String vid;

  ComplainDetails(
      {this.complainID,
      this.complainSubject,
      this.complainDescription,
      this.complainFullName,
      this.complainAddress,
      this.extras,
      this.complainStatus,
      this.userID,
      this.vid});

  @override
  _ComplainDetailsState createState() => _ComplainDetailsState();
}

class _ComplainDetailsState extends State<ComplainDetails> {
  final List<String> action = ["Processing", "Accept", "Reject", "Completed"];
  String selectedAction = "Processing";
  int complainId;
  VideoPlayerController _controller;
  Uint8List vidbytes;

  _playvideo() async {
    vidbytes = base64.decode(widget.vid);
    final blob = html.Blob([vidbytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    _controller = VideoPlayerController.network(url)
      ..addListener(() => setState(() {
            videoPosition = _controller.value.position;
          }))
      ..initialize().then((_) => setState(() {
            videoLength = _controller.value.duration;
          }));
  }

  @override
  void initState() {
    super.initState();

    print(widget.complainID);
    print(widget.complainAddress);
    print(widget.complainDescription);
    print(widget.complainFullName);
    print(widget.complainSubject);
    print(widget.userID);
    _playvideo();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Duration videoLength;
  Duration videoPosition;
  double volume = 0.5;

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64.decode(widget.extras);
    String base64Image = base64Encode(bytes);
    String decodedFile = base64Encode(vidbytes);
    _onUpdateTap() async {
      final msg = jsonEncode({
        "id": int.parse("${widget.complainID}"),
        "fullName": "${widget.complainFullName}",
        "subject": "${widget.complainSubject}",
        "address": "${widget.complainAddress}",
        "description": "${widget.complainDescription}",
        "userID": int.parse("${widget.userID}"),
        "status": "$selectedAction",
        "extras": "$base64Image",
        "vid": "$decodedFile"
      });

      print(selectedAction);
      final response = await http.patch(
          Uri.parse(
              'https://localhost:5001/api/complains/${widget.complainID}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: msg);
      //setState(() {});
      if (response.statusCode == 204) {
        print("Response " + response.body);
        print('Updated');
        Navigator.pop(context);
      } else {
        print(response.body);
        print('error');
      }
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: appBar(
      //   height: height,
      //   width: width,
      //   context: context,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: height / 2.5,
              width: width,
              child: Image.asset(
                'assets/images/Karachi.jpg',
                filterQuality: FilterQuality.low,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              color: scaffoldColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //for user profile header
                  Container(
                    padding: EdgeInsets.only(left: 32, right: 32, top: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/profile_pic.jpeg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.complainFullName,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Roboto",
                                    fontSize: 36,
                                    fontWeight: FontWeight.w700)),
                            Text(widget.complainAddress,
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontFamily: "Roboto",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                          ],
                        )),
                        Icon(
                          Icons.sms,
                          color: Colors.amber,
                          size: 40,
                        )
                      ],
                    ),
                  ),

                  //Performance Bar
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: EdgeInsets.all(32),
                    color: Color(0xFF102733),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.amber,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  widget.complainID,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Roboto",
                                      fontSize: 24),
                                )
                              ],
                            ),
                            Text(
                              "Total Complains",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto",
                                  fontSize: 15),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.check_box,
                                  color: Colors.amber,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "10",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Roboto",
                                      fontSize: 24),
                                )
                              ],
                            ),
                            Text(
                              "Complains Completed",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto",
                                  fontSize: 15),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "4.8",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Roboto",
                                      fontSize: 24),
                                )
                              ],
                            ),
                            Text(
                              "Ratings",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto",
                                  fontSize: 15),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),

                  //Container For Complain Description
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: Column(
                        children: <Widget>[
                          Text("Complain Description",
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontFamily: "Roboto",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.complainDescription,
                            style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 15,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  //Container For Clients
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: Column(children: <Widget>[
                        Text(
                          "Video",
                          style: TextStyle(
                              color: Colors.amber,
                              fontFamily: "Roboto",
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        if (_controller.value.initialized) ...[
                          Column(
                            children: [
                              Container(
                                height: height / 3,
                                width: width / 2,
                                child: VideoPlayer(_controller),
                              ),
                              Container(
                                //height: height / 3,

                                width: width / 2.5,
                                child: VideoProgressIndicator(
                                  _controller,
                                  allowScrubbing: true,
                                  padding: EdgeInsets.all(10),
                                ),
                              ),
                              Container(
                                width: width / 2.5,
                                child: Row(
                                  children: <Widget>[
                                    IconButton(
                                      color: Colors.white,
                                      icon: Icon(_controller.value.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow),
                                      onPressed: () {
                                        setState(() {
                                          _controller.value.isPlaying
                                              ? _controller.pause()
                                              : _controller.play();
                                        });
                                      },
                                    ),
                                    Text(
                                      '${convertToMinutesSeconds(videoPosition)} / ${convertToMinutesSeconds(videoLength)}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(
                                      animatedVolumeIcon(volume),
                                      color: Colors.white,
                                    ),
                                    Slider(
                                      value: volume,
                                      min: 0,
                                      max: 1,
                                      onChanged: (_volume) => setState(() {
                                        volume = _volume;
                                        _controller.setVolume(_volume);
                                      }),
                                    ),
                                    Spacer(),
                                    IconButton(
                                        icon: Icon(
                                          Icons.loop,
                                          color: _controller.value.isLooping
                                              ? Colors.green
                                              : Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _controller.setLooping(
                                                !_controller.value.isLooping);
                                          });
                                        }),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: height / 40,
                            child: Text(
                              "Image",
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontFamily: "Roboto",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                              width: width / 6,
                              height: height / 3,
                              child: Image.memory(bytes)),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          //Container For Reviews
                          // Container(
                          //   padding: EdgeInsets.only(left: 32, right: 32),
                          //   child: Column(
                          //     children: <Widget>[
                          //       Text("Previous Complains",
                          //           style: TextStyle(
                          //               color: Colors.grey[800],
                          //               fontSize: 18,
                          //               fontFamily: "Roboto",
                          //               fontWeight: FontWeight.w700)),
                          //       Container(
                          //         width: MediaQuery.of(context).size.width - 64,
                          //         child: ListView.builder(
                          //           itemBuilder: (context, index) {
                          //             return Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.start,
                          //               children: <Widget>[
                          //                 Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.spaceBetween,
                          //                   children: <Widget>[
                          //                     Text(
                          //                       "Complain ${widget.complainID}",
                          //                       style: TextStyle(
                          //                           color: Colors.lightBlue,
                          //                           fontSize: 18,
                          //                           fontFamily: "Roboto",
                          //                           fontWeight: FontWeight.w700),
                          //                     ),
                          //                     Row(
                          //                       children: <Widget>[
                          //                         Icon(
                          //                           Icons.star,
                          //                           color: Colors.amberAccent,
                          //                         ),
                          //                         Icon(
                          //                           Icons.star,
                          //                           color: Colors.amberAccent,
                          //                         ),
                          //                         Icon(
                          //                           Icons.star,
                          //                           color: Colors.amberAccent,
                          //                         )
                          //                       ],
                          //                     ),
                          //                     SizedBox(
                          //                       height: 8,
                          //                     ),
                          //                     Text(
                          //                       "My complain was addressed immediately.",
                          //                       style: TextStyle(
                          //                           color: Colors.grey[800],
                          //                           fontSize: 14,
                          //                           fontFamily: "Roboto",
                          //                           fontWeight: FontWeight.w400),
                          //                     ),
                          //                     SizedBox(
                          //                       height: 16,
                          //                     ),
                          //                   ],
                          //                 )
                          //               ],
                          //             );
                          //           },
                          //           itemCount: 8,
                          //           shrinkWrap: true,
                          //           controller:
                          //               ScrollController(keepScrollOffset: false),
                          //         ),
                          //       )
                          //          ],
                          //     ),
                          //    )
                        ],
                      ]),
                    ),
                  )
                ],
              ),
            ),
            Text('Select an action against this complaint'),
            DropdownButton<String>(
              value: widget.complainStatus != null
                  ? widget.complainStatus
                  : selectedAction,
              onChanged: (value) {
                setState(() {
                  selectedAction = value;
                });
              },
              items: action.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
            ),
            Material(
              color: Colors.yellow,
              child: RaisedButton(
                child: Text(
                  'Update',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 33,
                      fontFamily: 'Muli-Bold'),
                ),
                onPressed: () async {
                  try {
                    _onUpdateTap();
                  } catch (e) {
                    print(e);
                  }
                },
                color: Colors.amber,
              ),
            ),
            SizedBox(
              height: 55,
            )
          ],
        ),
      ),
    );
  }

  String convertToMinutesSeconds(Duration duration) {
    final parsedMinutes = duration.inMinutes < 10
        ? '0${duration.inMinutes}'
        : duration.inMinutes.toString();

    final seconds = duration.inSeconds % 60;

    final parsedSeconds =
        seconds < 10 ? '0${seconds % 60}' : (seconds % 60).toString();
    return '$parsedMinutes:$parsedSeconds';
  }

  IconData animatedVolumeIcon(double volume) {
    if (volume == 0)
      return Icons.volume_mute;
    else if (volume < 0.5)
      return Icons.volume_down;
    else
      return Icons.volume_up;
  }
}

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:psychology_app/screens/call/start_call.dart';

class CallScreen extends StatefulWidget {
  final String channelName;


  const CallScreen({Key? key, required this.channelName}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  late RtcEngine _engine;
  bool loading = false;
  String appId = "90440a77eccf4cc39d071ee22cb3c088";
  List _remoteUids =[];

  double xPosition =0;
  double yPosition =0;

  bool muted =false;

  final String token = "007eJxTYEh5GxWz6VLPj4nctvvNuvVKfp1Lk6iLnfT2+/ysghXJDiYKDJYGJiYGiebmqcnJaSbJycaWKQbmhqmpRkbJScbJBhYWE0SrUhoCGRkWOFqwMDJAIIjPzpCSn1ySX2TIwAAA+y4g0Q==";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializationAgra();
  }
  @override
  void dispose(){
    super.dispose();
    _engine.destroy();
  }

  Future<void> initializationAgra() async {
    setState(() {
      loading = true;
    });
    _engine = await RtcEngine.createWithContext(RtcEngineContext(appId));

    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.Communication);
    _engine.setEventHandler(RtcEngineEventHandler(

      joinChannelSuccess: (channel, uid, elapsed) {
        print("channel joined");
      },
      userJoined: (uid, elapsed) {
        print("user joined  $uid");
        setState(() {
          _remoteUids.add(uid);
        });

      },

      userOffline: (uid , elapsed){
        print('user off line $uid');
        setState(() {
          _remoteUids.remove(uid);

        });
      },

    ));


    //enter your Token
    await _engine.joinChannel(token, widget.channelName, null ,0).then((value){
      setState(() {
        loading = false;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:(loading) ?
      Center(
        child: CircularProgressIndicator(),
      ):Stack(
        children: [
          Center(
            child: renderRemotView(),
          ),

          Positioned(
              top: yPosition,
              left: xPosition,

              child: GestureDetector(
                onPanUpdate: (tapInfo){
                  setState(() {
                    xPosition += tapInfo.delta.dx;
                    yPosition += tapInfo.delta.dy;

                  });


                },
                child: Container(
                    width: 100,
                    height:130 ,
                    child: const RtcLocalView.SurfaceView()
                ),
              )

          ),

          _toolbar(),
        ],
      ),
    );
  }

  Widget renderRemotView(){
    if(_remoteUids.isNotEmpty){

      if(_remoteUids.length==1){
        return RtcRemoteView.SurfaceView(uid: _remoteUids[0],channelId:widget.channelName,);
        //   SizedBox(
        //   width: MediaQuery.of(context).size.width,
        //   height: MediaQuery.of(context).size.height,
        //   child: GridView.builder(gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        //       maxCrossAxisExtent: 200,
        //       childAspectRatio: 11/20,
        //       crossAxisSpacing: 5,
        //       mainAxisSpacing: 10
        //
        //   ),
        //
        //       itemBuilder: (BuildContext context , index){
        //         return Container(
        //           alignment: Alignment.center,
        //           decoration: BoxDecoration(
        //               color: Colors.amber,
        //               borderRadius: BorderRadius.circular(10)
        //           ),
        //           child: RtcRemoteView.SurfaceView(uid: _remoteUids[index],channelId: widget.channelName,),
        //         );
        //
        //       }),
        // );
        //RtcRemoteView.SurfaceView(uid: _remoteUids[0],channelId:widget.channelName,);
      }else if (_remoteUids.length==2){
        return Column(
          children: [
            RtcRemoteView.SurfaceView(uid: _remoteUids[1],channelId:widget.channelName,),
            RtcRemoteView.SurfaceView(uid: _remoteUids[2],channelId:widget.channelName,),
          ],
        );
      }else{
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: GridView.builder(gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 11/20,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10

          ),
              itemCount: _remoteUids.length,

              itemBuilder: (BuildContext context , index){
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: RtcRemoteView.SurfaceView(uid: _remoteUids[index],channelId: widget.channelName,),
                );

              }),
        );
      }

    }else{
      return Text('wating for other users to join');
    }
  }
  Widget _toolbar(){
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          RawMaterialButton(
            onPressed: (){
              _onToggleMute();
            },
            shape: CircleBorder(),
            padding: EdgeInsets.all(5),
            elevation: 2,
            fillColor: (muted)?Colors.blueAccent : Colors.white,
            child: Icon((muted)?Icons.mic_off : Icons.mic,
              color: (muted)?Colors.white:Colors.blueAccent,
              size: 40,
            ),

          ),
          RawMaterialButton(
            onPressed: (){
              _onCallEnd();
            },
            shape: CircleBorder(),
            padding: EdgeInsets.all(5),
            elevation: 2,
            fillColor: Colors.red,
            child: Icon(Icons.call_end,
              color: Colors.white,
              size: 40,
            ),

          ),
          RawMaterialButton(
            onPressed: (){
              _onSwitchCamera();
            },
            shape: CircleBorder(),
            padding: EdgeInsets.all(5),
            elevation: 2,
            fillColor: Colors.white,
            child: Icon(
              Icons.switch_camera_outlined,
              color: (muted)?Colors.white:Colors.blueAccent,
              size: 40,
            ),

          ),
        ],
      ),
    );
  }
  void _onToggleMute(){
    setState(() {
      muted=!muted;
    });
    _engine.muteLocalAudioStream(muted);
  }
  void  _onCallEnd(){
    _engine.leaveChannel().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>StartCall()));
    });
  }
  void _onSwitchCamera(){
    _engine.switchCamera();
  }
}

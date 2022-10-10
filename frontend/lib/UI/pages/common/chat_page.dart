import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/model.dart';
import '../../../model/objects/entity/message.dart';
import '../docent/docent_home_page.dart';
import '../student/student_home_page.dart';
import 'notifications_page.dart';



class ChatPage extends StatefulWidget {

  static const String route = '/Chat';



  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  bool _obtainedMessages = false;
  late String _senderEmail;
  late String _userEmail;
  late List<Message> _chatMessages;
  late String _text;
  late bool _isAStudent;
  final _textController = TextEditingController();

  @override
  void initState() {
    _getMessages();
    super.initState();
    if(mounted) Timer.periodic(
        Duration(seconds: (30)),
            (Timer t) {
          if(t.isActive && !mounted) t.cancel();
          if(mounted) _getMessages();
        });
  }

  @override
  Widget build(BuildContext context) {


    Map<String,dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    _senderEmail = args['senderEmail'];


    return (!_obtainedMessages)? Center(child:CircularProgressIndicator()): Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor:  Colors.red.shade900,
        centerTitle: true,
        title: Text(
          _senderEmail,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {
              String homePage = (_isAStudent)? StudentHomePage.route : DocentHomePage.route;
              Navigator.of(context).pushNamed(homePage);
            },
          ),
        ],
      ),
      body:GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.only(top: 15.0),
                    itemCount: _chatMessages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Message message = _chatMessages[index];
                      final bool isMe = (message.sender.email == _userEmail);
                      return _buildMessage(message, isMe);
                    },
                  ),
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }

  _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(
        top: 10,
        bottom: 8.0,
        left: 80.0,
        right: 10,
      )
          : EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 10,
      ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: isMe ? Colors.red.shade200 : Color(0xFFFFEFEE),
        borderRadius: isMe
            ? BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        )
            : BorderRadius.only(
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.messageTime,
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            message.text,
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg
      ],
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.5,color: Colors.black),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: _textController,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {
                _text = value;
              },
              onFieldSubmitted: (value) {
                _text = value;
                _sendMessage();
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Colors.red.shade900,
            onPressed: () {
              _sendMessage();
            },
          ),
        ],
      ),
    );
  }

  _sendMessage() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _userEmail = sharedPreferences.getString('email')!;
    Model.sharedInstance.sendMessage(_userEmail,_senderEmail,_text).then((value){
      _textController.clear();
      _getMessages();
    });
  }

  _getMessages() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _userEmail = sharedPreferences.getString('email')!;
    _isAStudent = sharedPreferences.getBool("isAStudent")!;
    Model.sharedInstance.showAllMessages(_userEmail,_senderEmail).then((result){
      setState((){
        _obtainedMessages = true;
        _chatMessages = result!;
      });
    });
  }
}
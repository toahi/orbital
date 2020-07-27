import 'package:butterfly/bloc/bloc.messages/messages_bloc.dart';
import 'package:butterfly/bloc/bloc.messages/messages_event.dart';
import 'package:butterfly/bloc/bloc.messages/messages_state.dart';
import 'package:butterfly/repositories/message_repository.dart';
import 'package:butterfly/ui/widgets/chat_widget.dart';
import 'package:butterfly/repositories/message_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Messages extends StatefulWidget {
  final String userId;

  Messages({this.userId});

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  MessageRepository _messagesRepository = MessageRepository();
  MessagesBloc _messageBloc;

  @override
  void initState() {
    _messageBloc = MessagesBloc(messageRepository: _messagesRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<MessagesBloc, MessagesState>(
      bloc: _messageBloc,
      builder: (BuildContext context, MessagesState state) {
        if (state is MessagesInitialState) {
          _messageBloc.add(ChatStreamEvent(currentUserId: widget.userId));
        }
        if (state is ChatLoadingState) {
          return Center(
            child: SpinKitPumpingHeart(
              color: Colors.cyan[200],
              size: size.width * 0.2,
            ),
          );
        }
        if (state is ChatLoadedState) {
          Stream<QuerySnapshot> chatStream = state.chatStream;

          return StreamBuilder<QuerySnapshot>(
            stream: chatStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("No data");
              }

              if (snapshot.data.documents.isNotEmpty) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitPumpingHeart(
                      color: Colors.cyan[200],
                      size: size.width * 0.2,
                    ),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChatWidget(
                        creationTime:
                        snapshot.data.documents[index].data['timestamp'],
                        userId: widget.userId,
                        selectedUserId:
                        snapshot.data.documents[index].documentID,
                      );
                    },
                  );
                }
              } else
                return Text(
                  " You don't have any conversations",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                );
            },
          );
        }
        return Container();
      },
    );
  }
}
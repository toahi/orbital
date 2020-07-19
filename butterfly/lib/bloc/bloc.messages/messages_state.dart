import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class MessagesState extends Equatable {
  const MessagesState();
  @override
  List<Object> get props => [];
}

class MessagesInitialState extends MessagesState {}

class ChatLoadingState extends MessagesState {}

class ChatLoadedState extends MessagesState {
  final Stream<QuerySnapshot> chatStream;

  ChatLoadedState({this.chatStream});

  @override
  List<Object> get props => [chatStream];
}
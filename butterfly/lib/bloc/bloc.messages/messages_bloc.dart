import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:butterfly/repositories/message_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  MessageRepository _messageRepository;

  MessagesBloc({@required MessageRepository messageRepository})
      : assert(messageRepository != null),
        _messageRepository = messageRepository;

  @override
  MessagesState get initialState => MessagesInitialState();

  @override
  Stream<MessagesState> mapEventToState(
      MessagesEvent event,
      ) async* {
    if (event is ChatStreamEvent) {
      yield* _mapStreamToState(currentUserId: event.currentUserId);
    }
  }

  Stream<MessagesState> _mapStreamToState({String currentUserId}) async* {
    yield ChatLoadingState();

    Stream<QuerySnapshot> chatStream =
    _messageRepository.getChats(userId: currentUserId);
    yield ChatLoadedState(chatStream: chatStream);
  }
}
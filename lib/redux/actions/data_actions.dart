import 'package:dio/dio.dart';
import 'package:xgenria/models/access_token.dart';

import 'base.dart';

base class DataAction extends XgenriaAction {
  final DataActionType type;

  DataAction({required this.type, super.payload});
}

enum DataActionType {


  ///requires a NetworkFetchPayload
  fetchImages,
  
  ///requires a NetworkFetchPayload
  fetchChats,
  notify,

  ///requires UpdatePayload<List<ImageData>> as payload
  updateFetchedImages,

  ///requires UpdatePayload<List<ChatData>> as payload
  updateFetchedChats,

  ///Marks a resource as dirtied. It requires UpdatePayload<DirtyResource>
  dirty,

  ///remove a DirtyResource from dirtied
  clean,


  ///reset this whole state
  reset,
}

///----------------------------------
///
///----------------------------------
class NetworkFetchPayload extends Payload {
  final Dio client;
  final AccessToken token;

  NetworkFetchPayload({
    super.onDone,
    super.onError,
    required this.client,
    required this.token,
  });
}


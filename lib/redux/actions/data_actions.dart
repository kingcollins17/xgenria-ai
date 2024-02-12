import 'package:dio/dio.dart';
import 'package:xgenria/models/access_token.dart';

import 'base.dart';

base class DataAction extends XgenriaAction {
  final DataActionType type;

  DataAction({required this.type, super.payload});
}

enum DataActionType {
  fetchImages,
  notify,

  ///requires UpdatePayload<List<ImageData>> as payload
  updateFetchedImages,

  ///Marks a resource as dirtied. It requires UpdatePayload<DirtyResource>
  dirty,

  ///
  clean,
}

///----------------------------------
///
///----------------------------------
class FetchImagePayload extends Payload {
  final Dio client;
  final AccessToken token;

  FetchImagePayload({
    super.onDone,
    super.onError,
    required this.client,
    required this.token,
  });
}


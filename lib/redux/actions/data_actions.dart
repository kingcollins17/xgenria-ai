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

  createImage,

  ///requires UpdatePayload<List<ImageData>> as payload
  updateFetchedImages,

  ///Marks a resource as dirtied. It requires UpdatePayload<DirtyResource>
  dirty,
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

class CreateImagePayload extends Payload {
  final Dio client;
  final AccessToken token;

  CreateImagePayload({
    super.onDone,
    super.onError,
    required this.client,
    required this.token,
  });
}

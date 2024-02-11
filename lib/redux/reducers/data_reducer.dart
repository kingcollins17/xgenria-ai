import 'package:redux/redux.dart';
import 'package:xgenria/redux/actions/base.dart';

import '../../models/image.dart';
import '../actions/data_actions.dart';

class DataState {
  //
  List<ImageData> images;
  String? message;
  bool isLoading;
  //
  ///The data that has been modified
  Set<DirtyResource>? dirtied;
  DataState({
    this.message,
    this.isLoading = false,
    this.images = const <ImageData>[],
    this.dirtied,
  });

  @override
  String toString() =>
      'DataState{images: $images, message: $message, isLoading: $isLoading}';
}

enum DirtyResource { images, chats, projects, documents }

final dataReducer = combineReducers<DataState>([
  imageDataReducer,
  _otherReducer,
]);

DataState imageDataReducer(DataState state, action) {
  if (action is DataAction) {
    switch (action.type) {
      case DataActionType.fetchImages:
        state
          ..isLoading = true
          ..message = "Fetching your Images";
        break;
      case DataActionType.updateFetchedImages:
        if (action.payload is UpdatePayload<List<ImageData>?>) {
          final pd = action.payload as UpdatePayload<List<ImageData>?>;

          state
            ..images = pd.data ?? []
            ..isLoading = false
            ..message = 'Images fetched';
        }
        break;

      case DataActionType.notify:
        if (action.payload is NotifyPayload) {
          final pd = action.payload as NotifyPayload;
          state.message = pd.notification;
        }
        break;
      default:
        break;
    }
  }
  return state;
}

DataState _otherReducer(DataState state, action) {
  if (action is DataAction) {
    switch (action.type) {
      case DataActionType.dirty:
        if (action.payload is UpdatePayload<DirtyResource>) {
          state.dirtied
              ?.add((action.payload as UpdatePayload<DirtyResource>).data);
        }
        break;
      default:
        break;
    }
  }
  return state;
}

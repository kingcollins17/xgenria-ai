import 'package:redux/redux.dart';
import 'package:xgenria/api/chat.dart';
import 'package:xgenria/api/image.dart';
import 'package:xgenria/redux/actions/base.dart';
import 'package:xgenria/redux/actions/data_actions.dart';
import 'package:xgenria/redux/core.dart';
import 'package:xgenria/redux/reducers/data_reducer.dart';

dynamic imageMiddleware(
    Store<XgenriaState> store, action, NextDispatcher next) {
  if (action is DataAction) {
    switch (action.type) {
      case DataActionType.fetchImages:
        if (action.payload is NetworkFetchPayload) {
          final pd = action.payload as NetworkFetchPayload;
          ImageAPI.images(pd.client, pd.token).then((value) {
            store.dispatch(
              DataAction(
                type: DataActionType.updateFetchedImages,
                payload: UpdatePayload(value),
              ),
            );
            if (pd.onDone != null) pd.onDone!(value as Object);
          }).catchError((err) => store.dispatch(DataAction(
              type: DataActionType.notify,
              payload: NotifyPayload(notification: err.toString()))));
        }
        break;
      default:
        break;
    }
  }
  next(action);
}

dynamic chatMiddleware(Store store, action, NextDispatcher next) {
  if (action is DataAction) {
    switch (action.type) {
      case DataActionType.fetchChats:
        if (action.payload is NetworkFetchPayload) {
          final pd = action.payload as NetworkFetchPayload;

          ///
          ChatAPI.chats(pd.client, pd.token).then((result) => result.status
              ? store.dispatch(DataAction(
                  type: DataActionType.updateFetchedChats,
                  payload: UpdatePayload(result.data),
                ))
              : store.dispatch(DataAction(
                  type: DataActionType.notify,
                  payload: NotifyPayload(notification: result.message),
                )));
        }
        break;
      default:
        break;
    }
  }
  next(action);
}

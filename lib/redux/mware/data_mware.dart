import 'package:redux/redux.dart';
import 'package:xgenria/api/image.dart';
import 'package:xgenria/redux/actions/base.dart';
import 'package:xgenria/redux/actions/data_actions.dart';

dynamic imageMiddleware(Store store, action, NextDispatcher next) {
  if (action is DataAction) {
    switch (action.type) {
      case DataActionType.fetchImages:
        if (action.payload is FetchImagePayload) {
          final pd = action.payload as FetchImagePayload;
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

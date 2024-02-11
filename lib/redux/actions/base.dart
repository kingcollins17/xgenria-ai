////

base class XgenriaAction {
  final Payload? payload;

  XgenriaAction({this.payload});
}

abstract class Payload {
  final void Function(Object)? onDone, onError;
  Payload({this.onDone, this.onError});
}


class NotifyPayload extends Payload {
  final String notification;

  NotifyPayload({super.onDone, super.onError, required this.notification});
}

class UpdatePayload<T> extends Payload {
  final T data;

  UpdatePayload(this.data);
}

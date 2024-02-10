base class XgenriaAction {
  final Payload? payload;

  XgenriaAction({this.payload});
}

abstract class Payload {
  final void Function(Object)? onDone, onError;
  Payload({this.onDone, this.onError});
}

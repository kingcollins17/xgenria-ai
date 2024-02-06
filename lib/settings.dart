import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 0)
class XgenriaSettings extends HiveObject {
  @HiveField(0)
  bool darkMode;

  XgenriaSettings({this.darkMode = true});
}

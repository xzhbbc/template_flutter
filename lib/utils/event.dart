import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

// 返回刷新页面
class EventBackFlash {
  String routeName;
  Map param;

  EventBackFlash(this.routeName, this.param);
}

// socket回调
class EventSocketCallBack {
  String handlerName;
  Map param;

  EventSocketCallBack(this.handlerName, this.param);
}
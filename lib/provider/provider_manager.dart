// import 'package:my_flutter_app/providers/data_info.dart';
import 'package:provider/provider.dart';
import 'package:template_flutter/view_model/global_model.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

/// 独立的model
List<SingleChildCloneableWidget> independentServices = [
  ChangeNotifierProvider<GlobalModel>(
    create: (context) => GlobalModel(),
  )
];

/// 需要依赖的model
List<SingleChildCloneableWidget> dependentServices = [];

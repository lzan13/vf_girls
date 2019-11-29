import 'package:provider/provider.dart';

import 'package:vf_library/view_model/locale_model.dart';
import 'package:vf_library/view_model/theme_model.dart';

List<SingleChildCloneableWidget> providers = [
  ChangeNotifierProvider<ThemeModel>(
    create: (context) => ThemeModel(),
  ),
  ChangeNotifierProvider<LocaleModel>(
    create: (context) => LocaleModel(),
  ),
];

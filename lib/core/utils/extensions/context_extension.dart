import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ContextExtension on BuildContext {
  T bloc<T extends BlocBase>() => BlocProvider.of<T>(this);
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);
  Size get querySize => MediaQuery.sizeOf(this);
}

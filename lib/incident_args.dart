import 'package:flutter/animation.dart';
import 'package:smart_view/model/case.dart';

class CaseArgs {
  Case cases;
  VoidCallback voidFunc;

  CaseArgs(this.cases, this.voidFunc);
}

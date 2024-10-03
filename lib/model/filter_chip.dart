import 'dart:ui';

class FilterChipModel {
  String label;
  bool isSelected;

  FilterChipModel(this.label, this.isSelected);
  @override
  toString() => 'Label: $label, isSelected: $isSelected';
}

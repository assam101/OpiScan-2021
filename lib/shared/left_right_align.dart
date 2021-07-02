import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

class LeftRightAlign extends MultiChildRenderObjectWidget {
  LeftRightAlign({
    Key key,
    @required Widget left,
    @required Widget right,
  }) : super(key: key, children: [left, right]);

  @override
  RenderLeftRightAlign createRenderObject(BuildContext context) {
    return RenderLeftRightAlign();
  }
}

class LeftRightAlignParentData extends ContainerBoxParentData<RenderBox> {}

class RenderLeftRightAlign extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, LeftRightAlignParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, LeftRightAlignParentData> {

  RenderLeftRightAlign({
    List<RenderBox> children,
  }) {
    addAll(children);
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! LeftRightAlignParentData)
      child.parentData = LeftRightAlignParentData();
  }

  @override
  void performLayout() {
    final BoxConstraints childConstraints = constraints.loosen();

    final RenderBox leftChild = firstChild;
    final RenderBox rightChild = lastChild;

    leftChild.layout(childConstraints, parentUsesSize: true);
    rightChild.layout(childConstraints, parentUsesSize: true);

    final LeftRightAlignParentData leftParentData = leftChild.parentData;
    final LeftRightAlignParentData rightParentData = rightChild.parentData;

    final bool wrapped =
        leftChild.size.width + rightChild.size.width > constraints.maxWidth;

    leftParentData.offset = Offset.zero;
    rightParentData.offset = Offset(
        constraints.maxWidth - rightChild.size.width,
        wrapped ? leftChild.size.height : 0);

    size = Size(
        constraints.maxWidth,
        wrapped
            ? leftChild.size.height + rightChild.size.height
            : math.max(leftChild.size.height, rightChild.size.height));
  }

  @override
  bool hitTestChildren(HitTestResult result, {Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }
}
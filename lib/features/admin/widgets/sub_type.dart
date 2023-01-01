import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:vida/features/admin/models/sub.dart';

class CategoryProducts extends StatelessWidget {
  final List<charts.Series<Sub, String>> seriesList;
  //final bool animate;
  const CategoryProducts({
    Key? key,
    required this.seriesList,
    //required this.animate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(
      seriesList,
      animate: false,
       defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.outside)]
    ));
  }
}

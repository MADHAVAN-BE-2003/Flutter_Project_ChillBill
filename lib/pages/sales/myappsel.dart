import 'package:flutter/material.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';

import './selectable_item.dart';
import './selection_app_bar.dart';

class MyAppsel extends StatefulWidget {
  const MyAppsel({Key? key}) : super(key: key);

  @override
  State<MyAppsel> createState() => _MyAppselState();
}

class _MyAppselState extends State<MyAppsel> {
  final controller = DragSelectGridViewController();

  @override
  void initState() {
    super.initState();
    controller.addListener(scheduleRebuild);
  }

  @override
  void dispose() {
    controller.removeListener(scheduleRebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SelectionAppBar(
        selection: controller.value,
        title: const Text('Grid Example'),
      ),
      body: DragSelectGridView(
        gridController: controller,
        padding: const EdgeInsets.all(8),
        itemCount: 90,
        itemBuilder: (context, index, selected) {
          return SelectableItem(
              index: index,
              color: Colors.blue,
              selected: selected,
              selection: controller.value.amount,
              prt_quantity: 0);
        },
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
      ),
    );
  }

  void scheduleRebuild() => setState(() {});
}

// class MyAppsel extends StatefulWidget {
//   @override
//   _MyAppselState createState() => _MyAppselState();
// }

// class _MyAppselState extends State<MyAppsel> {
//   final controller = DragSelectGridViewController();

//   @override
//   void initState() {
//     super.initState();
//     controller.addListener(scheduleRebuild);
//   }

//   @override
//   void dispose() {
//     controller.removeListener(scheduleRebuild);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: SelectionAppBar(
//         selection: controller.value,
//         title: const Text('Grid Example'),
//       ),
//       body: DragSelectGridView(
//         gridController: controller,
//         padding: const EdgeInsets.all(8),
//         itemCount: 90,
//         itemBuilder: (context, index, selected) {
//           return SelectableItem(
//             index: index,
//             color: Colors.blue,
//             selected: selected,
//           );
//         },
//         gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//           maxCrossAxisExtent: 150,
//           crossAxisSpacing: 8,
//           mainAxisSpacing: 8,
//         ),
//       ),
//     );
//   }

//   void scheduleRebuild() => setState(() {});
// }

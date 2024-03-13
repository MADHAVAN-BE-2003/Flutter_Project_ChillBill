import 'package:flutter/material.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';

import './selectable_item.dart';
import './selection_app_bar.dart';

class Productgrid extends StatefulWidget {
  const Productgrid({Key? key}) : super(key: key);

  @override
  State<Productgrid> createState() => _ProductgridState();
}

class _ProductgridState extends State<Productgrid> {
  final controller = DragSelectGridViewController();
  final controller1 = DragSelectGridViewController();

  @override
  void initState() {
    super.initState();
    controller.addListener(scheduleRebuild);
    controller1.addListener(scheduleRebuild);
  }

  @override
  void dispose() {
    controller.removeListener(scheduleRebuild);
    controller1.removeListener(scheduleRebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // appBar: SelectionAppBar(
      //   selection: controller.value,
      //   title: const Text('Grid Example'),
      // ),
      body: DefaultTabController(
          length: 5,
          child: Scaffold(
              appBar: AppBar(
                  key: const Key('selecting'),
                  titleSpacing: 0,
                  leading: const CloseButton(),
                  title: Text(
                      '${controller.value.amount + controller1.value.amount} items'),
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        text: 'GridView',
                      ),
                      Tab(
                        text: 'GridView.Count',
                      ),
                      Tab(
                        text: 'GridView.builder',
                      ),
                      Tab(
                        text: 'GridView.custom',
                      ),
                      Tab(
                        text: 'GridView.extent',
                      ),
                    ],
                    isScrollable: true,
                  )),
              body: TabBarView(children: [
                DragSelectGridView(
                  triggerSelectionOnTap: true,
                  gridController: controller,
                  padding: const EdgeInsets.all(8),
                  itemCount: 2,
                  itemBuilder: (context, index, selected) {
                    return SelectableItem(
                        index: index,
                        color: Colors.red,
                        selected: selected,
                        selection: controller.value.amount,
                        prt_quantity: 0);
                  },
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                ),
                // GridView(
                //   scrollDirection: Axis.vertical,
                //   controller: ScrollController(),
                //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                //       maxCrossAxisExtent: 200.0),
                //   children: List.generate(100, (index) {
                //     return Container(
                //       padding: EdgeInsets.all(20.0),
                //       child: Center(
                //         child: GridTile(
                //           footer: Text(
                //             'Item $index',
                //             textAlign: TextAlign.center,
                //           ),
                //           header: Text(
                //             'SubItem $index',
                //             textAlign: TextAlign.center,
                //           ),
                //           child: Icon(Icons.access_alarm,
                //               size: 40.0, color: Colors.white30),
                //         ),
                //       ),
                //       color: Colors.blue[400],
                //       margin: EdgeInsets.all(1.0),
                //     );
                //   }),
                // ),
                DragSelectGridView(
                  triggerSelectionOnTap: true,
                  gridController: controller1,
                  padding: const EdgeInsets.all(8),
                  itemCount: 2,
                  itemBuilder: (context, index, selected) {
                    return SelectableItem(
                        index: index,
                        color: Colors.red,
                        selected: selected,
                        selection: controller1.value.amount,
                        prt_quantity: 0);
                  },
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                ),
                // GridView.count(
                //     crossAxisCount: 2,
                //     children: List.generate(100, (index) {
                //       return Container(
                //         padding: EdgeInsets.all(20.0),
                //         child: Center(
                //           child: GridTile(
                //             footer: Text(
                //               'Item $index',
                //               textAlign: TextAlign.center,
                //             ),
                //             header: Text(
                //               'SubItem $index',
                //               textAlign: TextAlign.center,
                //             ),
                //             child: Icon(Icons.access_alarm,
                //                 size: 40.0, color: Colors.white30),
                //           ),
                //         ),
                //         color: Colors.blue[400],
                //         margin: EdgeInsets.all(1.0),
                //       );
                //     })),
                GridView.builder(
                  itemCount: 50,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    //if (index < 50)
                    return Container(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: GridTile(
                          footer: Text(
                            'Item $index',
                            textAlign: TextAlign.center,
                          ),
                          header: Text(
                            'SubItem $index',
                            textAlign: TextAlign.center,
                          ),
                          child: Icon(Icons.access_alarm,
                              size: 40.0, color: Colors.white30),
                        ),
                      ),
                      color: Colors.blue[400],
                      margin: EdgeInsets.all(1.0),
                    );
                  },
                ),
                GridView.custom(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    childrenDelegate:
                        SliverChildListDelegate(List.generate(100, (index) {
                      return Container(
                        padding: EdgeInsets.all(20.0),
                        child: Center(
                          child: GridTile(
                            footer: Text(
                              'Item $index',
                              textAlign: TextAlign.center,
                            ),
                            header: Text(
                              'SubItem $index',
                              textAlign: TextAlign.center,
                            ),
                            child: Icon(Icons.access_alarm,
                                size: 40.0, color: Colors.white30),
                          ),
                        ),
                        color: Colors.blue[400],
                        margin: EdgeInsets.all(1.0),
                      );
                    }))),
                GridView.extent(
                  maxCrossAxisExtent: 200.0,
                  children: List.generate(100, (index) {
                    return Container(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: GridTile(
                          footer: Text(
                            'Item $index',
                            textAlign: TextAlign.center,
                          ),
                          header: Text(
                            'SubItem $index',
                            textAlign: TextAlign.center,
                          ),
                          child: Icon(Icons.access_alarm,
                              size: 40.0, color: Colors.white30),
                        ),
                      ),
                      color: Colors.blue[400],
                      margin: EdgeInsets.all(1.0),
                    );
                  }),
                )
              ]))),
    );
  }

  void scheduleRebuild() => setState(() {});
}

// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
// import './Productgridkk.dart';

class GridItem extends StatefulWidget {
  // final Key ? key;
  // final Item item;
  // final ValueChanged<bool> isSelected;

  // GridItem({this.item, this.isSelected, this.key});

  const GridItem({
    Key? key,
    required this.item,
    required this.selectedlisted,
    required this.widgetNumbercrt,
    required this.selectedListids,
    required this.selectedListid_counts,
    required this.isSelected,
    required this.isRemoved,
  }) : super(key: key);

  final dynamic item;
  final dynamic selectedlisted;
  final int widgetNumbercrt;
  final dynamic selectedListids;
  final dynamic selectedListid_counts;
  final ValueChanged<bool> isSelected;
  final ValueChanged<bool> isRemoved;

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isSelected = false;
  bool isRemoved = false;
  // var opasity = isSelected ? 0.4 : 0.0;

  @override
  Widget build(BuildContext context) {
    // if (isSelected) {
    //   var opasity = 0.4;
    // } else {
    //   var opasity = 0.0;
    // }
    var current_id = '';
    var product_count = 0;
    var itmload = widget.item;
    var load_product_name = '';
    // print(itmload);
    itmload.forEach((key, value) {
      // print("Key : ${key} value ${value}");
      if (key == "id") {
        current_id = value;
      }
      if (key == "name") {
        load_product_name = value;
      }
      // print("Key : ${key} value ${value}");
    });
    // widget.selectedlisted[widget.widgetNumber];
    var crtthissel = isSelected;
    // widget.selectedlisted.forEach((key, value) {
    // print("Key : ${key} value ${value}");
    // if (key == "id") {
    //   var current_id = value;
    // }
    // print("Key : ${key} value ${value}");
    // });
    var values = widget.selectedListids;
    // values.contains(current_id);
    // values.contains(current_id);

    widget.selectedListid_counts.forEach((element) {
      // print(current_id);
      if (current_id == element['product_id']) {
        product_count = element['product_count'];
        crtthissel = true;
      }

      // if(values == element['product_id'])
    });

    // if (values.contains(current_id)) {
    //   crtthissel = true;
    //   // print(">>innn<<");
    //   // product_count = 1 +product_count;
    // } else {
    //   crtthissel = isSelected;
    //   // product_count = 1;
    // }

    // print(">>>><<>aa<>>");
    // print(widget.selectedListid_counts);
    // print(widget.selectedListids);
    // print(current_id);
    if (widget.selectedlisted != '') {
      // print(widget.selectedlisted[widget.widgetNumbercrt]);
    }
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !crtthissel;
          widget.isSelected(crtthissel ? false : true);
        });
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 0.0),
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              itmload['name'].toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 17.0,
                color: Color.fromARGB(255, 8, 58, 73),
                fontWeight: FontWeight.bold,
              ),
            ),
            AspectRatio(
              aspectRatio: 18.0 / 12.0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      // image: NetworkImage(
                      // "http://invoice.kingzquest.com/api/images/no-image.png"),
                      image: NetworkImage(itmload['image'].toString()),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Color.fromARGB(255, 7, 7, 7)
                              .withOpacity(crtthissel ? 0.4 : 0.0),
                          BlendMode.darken),
                    )),

                // child: Image.asset(
                //   'item.trailerImg1',
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5.0, 0.0, 4.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Text(
                  //   'item.name',
                  //   overflow: TextOverflow.ellipsis,
                  //   maxLines: 1,
                  //   style: TextStyle(
                  //     fontSize: 17.0,
                  //     color: Color(0xFFD73C29),
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // Text(
                  //   'item.category',
                  //   style: TextStyle(
                  //     color: Colors.black54,
                  //     fontSize: 9.0,
                  //   ),
                  // ),
                  SizedBox(
                    height: 8,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 4.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Price',
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "₹" + itmload['purchase_price'].toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 4.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Quantity',
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              product_count.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                          child: crtthissel
                              ? InkWell(
                                  child: Icon(
                                    Icons.close,
                                  ),
                                  onTap: () {
                                    // print("object");
                                    setState(() {
                                      isRemoved = !crtthissel;
                                      widget
                                          .isRemoved(crtthissel ? false : true);
                                    });
                                  },
                                )
                              : null

                          // ),
                          )
                      // const Spacer(),
                      // Align(
                      //   alignment: Alignment.bottomRight,
                      //   child: Icon(Icons.close),
                      // )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SelectableItem extends StatefulWidget {
  const SelectableItem({
    Key? key,
    required this.index,
    required this.color,
    required this.selected,
    required this.selection,
    required this.prt_quantity,
  }) : super(key: key);

  final int index;
  final MaterialColor color;
  final bool selected;
  final dynamic selection;
  final int prt_quantity;
  // this.selection = const Selection.empty(),

  @override
  _SelectableItemState createState() => _SelectableItemState();
}

class _SelectableItemState extends State<SelectableItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  var oldselect = false;
  var oldselect_ani = false;
  var qrty = 0;
  // late final qrty[widget.index] = 0;
  // late final insdexitem = widget.index + 1;

  @override
  void initState() {
    super.initState();

    // print(widget.prt_quantity);
    // qrty[insdexitem] = 0;
    setState(() {
      qrty = 0;
    });

    // print(qrty[widget.index]);
    _controller = AnimationController(
      value: widget.selected ? 1 : 0,
      duration: kThemeChangeDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0, end: 0.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
  }

  @override
  void didUpdateWidget(SelectableItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    // print(oldWidget);
    if (oldWidget.selected != widget.selected) {
      if (widget.selected) {
        _controller.forward();
      } else {
        if (oldWidget.selected) {
          // print("old true");
          oldselect = true;
          setState(() {
            qrty = 1 + qrty;
          });
          // _controller.forward();
          // _controller = AnimationController(
          //   value: 1,
          //   duration: kThemeChangeDuration,
          //   vsync: this,
          // );
          // _scaleAnimation =
          //     Tween<double>(begin: 0.2, end: 0.2) as Animation<double>;

          // var _controllersel = AnimationController(
          //   value: 1,
          //   duration: kThemeChangeDuration,
          //   vsync: this,
          // );

          // _scaleAnimation = Tween<double>(begin: 0, end: 0.2).animate(
          //   CurvedAnimation(
          //     parent: _controllersel,
          //     curve: Curves.ease,
          //   ),
          // );
          // _scaleAnimation.value = 1.2;
        } else {
          _controller.reverse();
        }
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

//  Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _scaleAnimation,
//       builder: (context, child) {
//         return Container(
//           child: Transform.scale(
//             scale: _scaleAnimation.value,
//             child: DecoratedBox(
//               child: child,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(2),
//                 color: calculateColor(),
//               ),
//             ),
//           ),
//         );
//       },
//       child: Container(
//         alignment: Alignment.center,
//         child: Text(
//           'Item\n#${widget.index}',
//           textAlign: TextAlign.center,
//           style: TextStyle(fontSize: 18, color: Colors.white),
//         ),
//       ),
//     );
//   }
  @override
  Widget build(BuildContext context) {
    // print("new.selected");
    // print(widget.selected);
    // print("old.selected");
    // print(widget.index);

    var insecx_val = widget.index;

    if (oldselect || widget.selected) {
      oldselect_ani = true;

      // if (oldselect) {
      if (qrty == 0) {
        setState(() {
          qrty = 1;
        });
      }
      // }

      // qrty = widget.prt_quantity + qrty;
    } else {
      // qrty[widget.index] = qrty[widget.index];
      oldselect_ani = false;
      // qrty = widget.prt_quantity;
    }

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        // print(context);
        // Card(
        //   color: Colors.transparent,
        //   elevation: 0,
        //   child: Container(
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(20),
        //         image: DecorationImage(
        //             image: AssetImage("assets/images/grocery-transparent.png"),
        //             fit: BoxFit.cover)),
        //     child: Transform.translate(
        //       offset: Offset(0, -70),
        //       child: Container(
        //         // padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
        //         margin: EdgeInsets.symmetric(horizontal: 0, vertical: 60),
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(10),
        //             color: Color.fromARGB(0, 48, 46, 46)),
        //         child: Container(
        //           alignment: Alignment.center,
        //           child: Text(
        //             'Item\n#${widget.index}',
        //             textAlign: TextAlign.center,
        //             style: TextStyle(
        //                 fontSize: 18, color: Color.fromARGB(255, 19, 18, 18)),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // );
        return InkWell(
          onTap: () {
            print("Click event on Container");
          },
          child: Container(
            // decoration: new BoxDecoration(
            //   boxShadow: [
            //     new BoxShadow(
            //       color: Colors.black,
            //       blurRadius: 20.0,
            //     ),
            //   ],
            // ),
            //   scale: _scaleAnimation.value,
            // onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => GridItemDetails(this.item),
            //     ),
            //   );
            // },
            child: Card(
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'grocery',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Color(0xFFD73C29),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 18.0 / 12.0,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/grocery-transparent.png"),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Color.fromARGB(255, 7, 7, 7)
                                    .withOpacity(_scaleAnimation.value),
                                BlendMode.darken),
                          )),

                      // child: Image.asset(
                      //   'item.trailerImg1',
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 2.0),
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
                                    "₹100",
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
                                    qrty.toString(),
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
                              child: oldselect_ani
                                  ? InkWell(
                                      child: Icon(
                                        Icons.close,
                                      ),
                                      onTap: () {
                                        print("object");
                                        _controller.reverse();
                                      },
                                    )
                                  : Align(
                                      alignment: Alignment.bottomRight,

                                      // child: MaterialButton(
                                      //   onPressed: () => {},
                                      // child: Icon(Icons.abc_sharp),
                                    ),

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
          ),
        );
      },
      // child: Container(
      //   alignment: Alignment.center,
      //   // decoration: BoxDecoration(
      //   //     color: Colors.blue,
      //   //     image: DecorationImage(
      //   //         image: AssetImage("assets/images/user_background.jpg"),
      //   //         fit: BoxFit.cover)),
      //   child: Text(
      //     'Item\n#${widget.index}',
      //     textAlign: TextAlign.center,
      //     style: TextStyle(fontSize: 18, color: Colors.white),
      //   ),
      // ),
    );
  }

  Color? calculateColor() {
    return Color.lerp(
      widget.color.shade500,
      widget.color.shade900,
      _controller.value,
    );
  }
}

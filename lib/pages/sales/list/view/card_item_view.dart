// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:chill_bill/pages/sales/list/model/card_model.dart';
import 'package:chill_bill/pages/sales/salesinvoice.dart';

// Widget okButton = TextButton(
//   child: Text("OK"),
//   onPressed: () => Navigator.pop(context, false),
// );

class CardItemView extends StatelessWidget {
  final CardModel card;
  // CardItemView(this.card);
  const CardItemView({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String expandedValue = '';
    String headerValue = '';
    String headerquentity = '';
    String headertax = '';
    String headerid = '';
    String headercode = '';
    String headertotal = '';
    String grandtotal = '';
    bool isExpanded;

    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 245, 243, 243),
          border: Border.all(color: Color.fromARGB(255, 23, 23, 24)),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: <Widget>[
          // Container(
          //   decoration: BoxDecoration(
          //       color: Colors.grey[100],
          //       borderRadius: BorderRadius.all(Radius.circular(18))),
          //   child: Icon(
          //     Icons.print,
          //     color: Colors.lightBlue[900],
          //   ),
          //   padding: EdgeInsets.all(10),
          // ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  card.client_name.trim().replaceFirst(RegExp('\n'), ' '),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[900]),
                ),
                Text(
                  card.invoicenumber,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[500]),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                "\₹" + card.grandTotal,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.lightGreen),
              ),
              Text(
                card.invoiceDate,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[500]),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          // Container(
          //   decoration: BoxDecoration(
          //       color: Colors.grey[100],
          //       borderRadius: BorderRadius.all(Radius.circular(18))),
          //   child: Icon(
          //     Icons.print,
          //     color: Colors.lightBlue[900],
          //   ),
          //   padding: EdgeInsets.all(10),
          // ),
          InkWell(
            customBorder: CircleBorder(),
            onTap: () async {
              Navigator.push(
                context,
                // MaterialPageRoute(builder: (context) => Additems()),
                MaterialPageRoute(
                    builder: (context) => Salesinvoice(
                        itemslistarray1: card.itemlistarray,
                        client: card.client,
                        client_name: card.client_name,
                        company_contact: card.company_contact)),
              );
            },
            child: Icon(
              Icons.print,
              color: Colors.lightBlue[900],
            ),
          ),
        ],
      ),
    );
    // return Card(
    //   margin: const EdgeInsets.only(bottom: 24.0),
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(15.0),
    //   ),
    //   elevation: 5,
    //   child: Column(
    //     children: [
    //       ListTile(
    //         title: Text(card.invoicenumber),
    //         onTap: () {
    //           // AlertDialog alert = AlertDialog(
    //           //   title: Text(card.username),
    //           //   content: Text('H=${card.height} / W=${card.width}'),
    //           //   actions: [
    //           //     TextButton(
    //           //       child: Text("OK"),
    //           //       onPressed: () => Navigator.pop(context, false),
    //           //     ),
    //           //   ],
    //           // );
    //           // showDialog(
    //           //   context: context,
    //           //   builder: (BuildContext context) {
    //           //     return alert;
    //           //   },
    //           // );
    //         },
    //         subtitle: Text(card.grandTotal),
    //         trailing: Wrap(
    //           spacing: 12, // space between two icons
    //           children: <Widget>[
    //             // IconButton(
    //             //   icon: Icon(Icons.edit),
    //             //   onPressed: () {},
    //             // ),
    //             IconButton(
    //               icon: Icon(Icons.delete),
    //               onPressed: () {},
    //             ),
    //           ],
    //         ),
    //         // trailing:  IconButton(
    //         //   icon: Icon(Icons.edit),
    //         //   onPressed: () {},
    //         // ),
    //       ),
    //     ],
    //   ),
    // );
  }

  // ListTile get _buildDescriptionItem {
  //   return ListTile(
  //     title: Text(card.author),
  //     onTap: () => Scaffold.of(context)
  //         .showSnackBar(SnackBar(content: Text(card.width.toString()))),
  //     subtitle: Text('H=${card.height} / W=${card.width}'),
  //     trailing: Wrap(
  //       spacing: 12, // space between two icons
  //       children: <Widget>[
  //         IconButton(
  //           icon: Icon(Icons.edit),
  //           onPressed: () {},
  //         ),
  //         IconButton(
  //           icon: Icon(Icons.delete),
  //           onPressed: () {},
  //         ),
  //       ],
  //     ),
  //     // trailing:  IconButton(
  //     //   icon: Icon(Icons.edit),
  //     //   onPressed: () {},
  //     // ),
  //   );
  // }

  SizedBox get _buildImageItem {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        // child: Image.network(
        //   card.downloadUrl,
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }
}

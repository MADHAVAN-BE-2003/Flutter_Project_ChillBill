import 'package:chill_bill/pages/master/list/model/card_model.dart';
import 'package:flutter/material.dart';

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
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          border: Border.all(color: Color.fromARGB(255, 23, 23, 24)),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: <Widget>[
          // Container(
          //   decoration: BoxDecoration(
          //       color: Colors.grey[100],
          //       borderRadius: BorderRadius.all(Radius.circular(18))),
          //   child: Icon(
          //     Icons.date_range,
          //     color: Colors.lightBlue[900],
          //   ),
          //   padding: EdgeInsets.all(12),
          // ),
          // SizedBox(
          //   width: 16,
          // ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  card.username,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[900]),
                ),
                Text(
                  card.email,
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
                card.phone,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 10, 83, 131)),
              ),
              Text(
                card.district,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[500]),
              ),
            ],
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
    //         title: Text(card.username),
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
    //         subtitle: Text(card.email),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventWidget extends StatefulWidget {
  const EventWidget({Key? key}) : super(key: key);

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  DateTime selectedDay = DateTime(2022, 07, 15);
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance.collection('users').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: dataStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {}
        if (snapshot.connectionState == ConnectionState.waiting) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        List dataDocs = [];
        snapshot.data?.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String, dynamic>;
          dataDocs.add(a);
          a['id'] = document.id;
        }).toList();
        return ListView.builder(
            shrinkWrap: true,
            itemCount: dataDocs.length,
            itemBuilder: (context, index) {
              if (selectedDay != dataDocs[index]['tarih']) {
                return Container(
                  margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.shade700,
                        width: 1,
                      )),
                  child: Container(
                    margin: const EdgeInsets.only(right: 5, left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              dataDocs[index]['başlık'].toString(),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(dataDocs[index]['tarih'].toString()),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          dataDocs[index]['açıklama'].toString(),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(dataDocs[index]['konum'].toString(),
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                );
              }
              return Container();
            });
      },
    );
  }
}
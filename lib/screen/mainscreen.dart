import 'package:car_bike_details/screen/addscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color.fromARGB(255, 90, 3, 101),
          label: const Text('     Add vehicles    '),
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddScreen(),
            ));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 90, 3, 101),
          title: const Center(child: Text('Vehicle list')),
        ),
        body: SafeArea(
          child: Container(
            color: Color.fromARGB(255, 216, 199, 243),
            child: Column(
              children: [
                const TabBar(
                  labelColor: Color.fromARGB(255, 90, 3, 101),
                  tabs: <Widget>[
                    Tab(
                      text: 'Bike',
                    ),
                    Tab(
                      text: 'Cars',
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(children: <Widget>[
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('bikelist')
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> streamsnapshot) {
                          if (!streamsnapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: streamsnapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot documentSnapshot =
                                    streamsnapshot.data!.docs[index];
                                return Card(
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Vehicle Number : ${documentSnapshot['vehicle_no']}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                'Brand :  ${documentSnapshot['vehicle_brand']}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                'Type : ${documentSnapshot['vehicle_type']}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                'Fueltype :${documentSnapshot['vehicle_fuel']}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 12,
                                        top: 12,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 223, 17, 2),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          height: 25,
                                          width: 25,
                                          child: GestureDetector(
                                            onTap: () {
                                              FirebaseFirestore.instance
                                                  .collection('bikelist')
                                                  .doc(documentSnapshot.id)
                                                  .delete();
                                            },
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        }),
                    Center(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('carlist')
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot> streamsnapshot) {
                            if (!streamsnapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return ListView.builder(
                                itemCount: streamsnapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final DocumentSnapshot documentSnapshot =
                                      streamsnapshot.data!.docs[index];
                                  return Card(
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Vehicle Number : ${documentSnapshot['vehicle_no']}',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  'Brand :  ${documentSnapshot['vehicle_brand']}',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  'Type : ${documentSnapshot['vehicle_type']}',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  'Fueltype :${documentSnapshot['vehicle_fuel']}',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 12,
                                          top: 12,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 223, 17, 2),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            height: 25,
                                            width: 25,
                                            child: GestureDetector(
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection('carlist')
                                                    .doc(documentSnapshot.id)
                                                    .delete();
                                              },
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          }),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

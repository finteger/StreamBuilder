Center(
              child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('guests') // 👈 Your desired collection name here
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }
              return ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Text(data['guest_name'],
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 18)),
                        title: Text(
                          data['message'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              background: Paint()
                                ..color = Color.fromARGB(255, 110, 201, 244)
                                ..strokeWidth = 30
                                ..style = PaintingStyle.stroke),
                          textAlign: TextAlign.center,
                        ),
                      ), // 👈 Your valid data here
                    );
                  }).toList());
            },
          ))
        ],
      ),

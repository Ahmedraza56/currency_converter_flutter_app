import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversion History'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('conversion_history')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          List<DocumentSnapshot> documents = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data =
                  documents[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(
                    'From: ${data['from_currency']} To: ${data['to_currency']}'),
                subtitle: Text(
                    'Amount: ${data['amount']} Converted: ${data['converted_amount']}'),
              );
            },
          );
        },
      ),
    );
  }
}

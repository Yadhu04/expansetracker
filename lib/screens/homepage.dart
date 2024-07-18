import 'package:expansetracker/provider/expanse_provider.dart';
import 'package:expansetracker/widgets/add_expanse.dart';
import 'package:expansetracker/widgets/expanse_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ExpanseProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(title: const Text('Expense tracker'), actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return const AddExpanse();
                    });
              },
              icon: const Icon(Icons.add))
        ]),
        body: data.registerdexpense.isEmpty
            ? const Center(
                child: Text('There is no expances ,Add some'),
              )
            : Column(
                children: [
                  Expanded(
                    child: Consumer<ExpanseProvider>(
                      builder: (context, value, child) => ListView.builder(
                        itemCount: data.registerdexpense.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: ValueKey(data.registerdexpense[index]),
                            onDismissed: (direction) {
                              // print(ValueKey(value));
                              data.removeExpanse(index, context);

                              print("print : ${data.registerdexpense}");
                            },
                            child: ExpanseCard(index: index),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ));
  }
}

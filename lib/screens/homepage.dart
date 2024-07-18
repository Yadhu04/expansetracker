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
    var data = Provider.of<ExpanseProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expense tracker'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: data.registerdexpense.length,
                itemBuilder: (context, index) {
                  return ExpanseCard(index: index);
                },
              ),
            ),
            Align(
                alignment: AlignmentDirectional.topEnd,
                child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return AddExpanse();
                        },
                      );
                    },
                    child: const Icon(Icons.add)))
          ],
        ));
  }
}

import 'package:expand_tracker/Componets/expense_summary.dart';
import 'package:expand_tracker/Componets/expense_tile.dart';
import 'package:expand_tracker/Data/expense_data.dart';
import 'package:expand_tracker/Models/Expense_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseRupeesController = TextEditingController();
  final newExpensePaisaController = TextEditingController();

  get expense => null;

  get index => null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Add New Expense'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                // new expense name
                children: [
                  TextField(
                    controller: newExpenseNameController,
                    decoration: const InputDecoration(hintText: "Expense Type"),
                  ),
                  // new Expense Amount
                  Row(
                    children: [
                      //ruppes show
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: newExpenseRupeesController,
                          decoration: const InputDecoration(hintText: "Rupees"),
                        ),
                      ),
                      // paisa show
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: newExpensePaisaController,
                          decoration: const InputDecoration(hintText: "Paisa"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: save,
                  child: Text('Save'),
                ),
                MaterialButton(
                  onPressed: cancel,
                  child: Text('Cancel'),
                )
              ],
            ));
  }

  //delete expense

  void deleteExpense(ExpensItem expensItem) {
    var expense2 = expense;
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense2);
  }

  // save method
  void save() {
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseRupeesController.text.isNotEmpty &&
        newExpensePaisaController.text.isNotEmpty) {
      String amount =
          '${newExpenseRupeesController.text}.${newExpensePaisaController.text}';
      // create a new Expense
      ExpensItem newExpense = ExpensItem(
          name: newExpenseNameController.text,
          amount: amount,
          dateTime: DateTime.now());

      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    }

    Navigator.pop(context);
    clear();
  }

  // cancel method

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseRupeesController.clear();
    newExpenseNameController.clear();
    newExpensePaisaController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.cyan.shade100,
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            backgroundColor: Colors.black,
            child: Icon(Icons.add),
          ),
          body: ListView(
            children: [
              //wewkly summary
              ExpenseSummary(startOfweek: value.startOfWeekDate()),

              const SizedBox(
                height: 20,
              ),

              //expense list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getAllExpenselist().length,
                itemBuilder: (context, index) => ExpenseTile(
                  name: value.getAllExpenselist()[index].name,
                  amount: value.getAllExpenselist()[index].amount,
                  dateTime: value.getAllExpenselist()[index].dateTime,
                  deleteTapped: (BuildContext) {
                    deleteTapped:
                    (p0) => deleteExpense(value.getAllExpenselist()[index]);
                  },
                ),
              ),
            ],
          )),
    );
  }
}

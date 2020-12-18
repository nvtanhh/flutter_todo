import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:todos/core/models/todo.dart';
import 'package:todos/core/providers/todo_provider.dart';
import 'package:todos/ui/widgets/todo_item.dart';

class TodosBody extends StatefulWidget {
  final int currentIndex;

  TodosBody(int this.currentIndex);

  @override
  _TodosBodyState createState() => _TodosBodyState();
}

enum VisibilityType { all, incomplete, completed }

class _TodosBodyState extends State<TodosBody> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController desciptionController = new TextEditingController();
  Size size;
  VisibilityType visibilityType;

  @override
  void initState() {
    super.initState();
    switch (widget.currentIndex) {
      case 0:
        visibilityType = VisibilityType.completed;
        break;
      case 1:
        visibilityType = VisibilityType.all;
        break;
      case 2:
        visibilityType = VisibilityType.incomplete;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            _appBarUI(),
            _summaryPart(),
            _listTotosUI(),
          ],
        ),
        floatingActionButton: _floadtingButton(),
      ),
    );
  }

  Widget _appBarUI() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 56,
      alignment: Alignment.center,
      child: Image.asset('assets/mtodo_logo.png'),
    );
  }

  Widget _summaryPart() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: size.width * 0.2,
                  child: CircularPercentIndicator(
                    radius: 22,
                    lineWidth: 3,
                    percent: .4,
                    backgroundColor: Colors.grey[300],
                    progressColor: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  "My Todos",
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.headline4.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.2,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text("2 of 7 tasks",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w500)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Divider(
                          color: Colors.grey[300],
                          height: 2,
                          thickness: 1,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _listTotosUI() {
    final userProvider = Provider.of<TodoProvider>(context);
    return Expanded(
      child: StreamBuilder(
        stream: userProvider.fetchAllTodoAsStream(),
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          if (snapshot.hasData && snapshot.data.length > 0) {
            return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 20),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) =>
                    TodoItem(snapshot.data[index]));
          } else {
            return Center(child: Text("No items"));
          }
        },
      ),
    );

    // return Expanded(
    //   child: Padding(
    //     padding: const EdgeInsets.only(top: 0),
    //     child: ListView.builder(
    //       physics: const AlwaysScrollableScrollPhysics(),
    //       padding: EdgeInsets.only(top: 20),
    //       itemCount: 10,
    //       itemBuilder: (BuildContext context, int index) {
    //         return TodoItem(index);
    //       },
    //     ),
    //   ),
    // );
  }

  Widget _floadtingButton() {
    return new Container(
      width: 50.0,
      height: 50.0,
      decoration: new BoxDecoration(
        // border: ,
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: new IconButton(
        icon: new Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: _showAddTodoDialog,
        iconSize: 30.0,
      ),
    );
  }

  _showAddTodoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new TextField(
                autofocus: true,
                decoration: InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor)),
                    labelText: "Title",
                    hintText: "",
                    contentPadding: EdgeInsets.only(
                        left: 16.0, top: 20.0, right: 16.0, bottom: 5.0)),
                controller: titleController,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                autofocus: false,
                maxLines: 4,
                decoration: InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor)),
                    labelText: "Desciption",
                    hintText: "",
                    contentPadding: EdgeInsets.only(
                        left: 16.0, top: 20.0, right: 16.0, bottom: 5.0)),
                controller: desciptionController,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
              )
            ],
          ),
          actions: <Widget>[
            ButtonTheme(
              //minWidth: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: RaisedButton(
                  elevation: 3.0,
                  onPressed: () {
                    // if (itemController.text.isNotEmpty &&
                    //     !widget.currentList.values
                    //         .contains(itemController.text.toString())) {
                    //   Firestore.instance
                    //       .collection(widget.user.uid)
                    //       .document(widget.currentList.keys.elementAt(widget.i))
                    //       .updateData({itemController.text.toString(): false});

                    //   itemController.clear();
                    //   Navigator.of(context).pop();
                    // }
                  },
                  child: Text('Add'),
                  color: Theme.of(context).primaryColor,
                  textColor: const Color(0xffffffff),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

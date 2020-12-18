import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todos/core/models/todo.dart';
import 'package:todos/ui/todo_detail.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;

  TodoItem(this.todo);

  @override
  _TodoItemState createState() => _TodoItemState();
}

// Here it is!
Size _textSize(String text, TextStyle style, BuildContext context) {
  final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      textDirection: TextDirection.ltr)
    ..layout();
  return textPainter.size;
}

class _TodoItemState extends State<TodoItem> {
  bool isDone;
  Size size;

  @override
  void initState() {
    super.initState();
    // isDone = (isDone = widget.index == 2 || widget.index == 4) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    Color doneColor = Theme.of(context).primaryColor;

    String title = "Làm bài tập về nhà";
    TextStyle titleTextStyle = TextStyle(
        fontSize: 18,
        color: isDone ? doneColor : Colors.black87,
        fontWeight: FontWeight.w600);

    final Size titleSize = _textSize(title, titleTextStyle, context);

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TodoDetail(),
              ));
        },
        child: Opacity(
          opacity: isDone ? 0.7 : 1,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.topCenter,
                        width: size.width * 0.2,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isDone = !isDone;
                            });
                          },
                          child: !isDone
                              ? Icon(
                                  Icons.check_box_outline_blank,
                                  color: Colors.grey[350],
                                  size: 22,
                                )
                              : Icon(
                                  Icons.check_box_outlined,
                                  color: Theme.of(context).accentColor,
                                  size: 22,
                                ),
                        )),
                    Flexible(
                      child: Stack(
                        children: [
                          // if (isDone)
                          //   Align(
                          //     alignment: Alignment.centerLeft,
                          //     child: Container(
                          //       width: titleSize.width,
                          //       margin: EdgeInsets.only(top: 4),
                          //       child: Row(
                          //         children: [
                          //           Expanded(
                          //             child: Divider(
                          //               thickness: 2,
                          //               color: doneColor,
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          Padding(
                            padding: const EdgeInsets.only(right: 18),
                            child: Text(
                              title,
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: isDone
                                  ? titleTextStyle.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      decorationThickness: 1.5)
                                  : titleTextStyle,
                            ),
                          ),
                        ],
                      ),
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
                            padding: const EdgeInsets.only(right: 18, top: 5),
                            child: Text(
                                "Add some descriptions Add some descriptions Add some descriptions Add some descriptionsAdd some descriptions Add some descriptions Add some descriptions Add some descriptions Add some descriptionss",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(color: Colors.grey[400])),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        new IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: _showDeleteDialog,
        ),
      ],
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text("Delete: "),
          content: Text(
            "Are you sure you want to delete this todo?",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            ButtonTheme(
              //minWidth: double.infinity,
              child: RaisedButton(
                elevation: 3.0,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('No'),
                color: Colors.grey[400],
                textColor: const Color(0xffffffff),
              ),
            ),
            ButtonTheme(
              //minWidth: double.infinity,
              child: RaisedButton(
                elevation: 3.0,
                onPressed: () {
                  // Firestore.instance
                  //     .collection(widget.user.uid)
                  //     .document(widget.currentList.keys.elementAt(widget.i))
                  //     .delete();
                  // Navigator.pop(context);
                  Navigator.of(context).pop();
                },
                child: Text('YES'),
                color: Colors.red,
                textColor: const Color(0xffffffff),
              ),
            ),
          ],
        );
      },
    );
  }
}

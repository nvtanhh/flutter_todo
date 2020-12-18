import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class TodoDetail extends StatefulWidget {
  @override
  _TodoDetailState createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  var _titleController = TextEditingController();
  var _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: sliverAppBar(context),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(18, 30, 18, 0),
          child: Column(
            children: [titleUI(), SizedBox(height: 20), descriptionUI()],
          ),
        ));
  }

  titleUI() {
    return TextField(
      enableSuggestions: false,
      controller: _titleController..text = "Lam bai tap ve nha",
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.text,
      cursorColor: Theme.of(context).primaryColor,
      // cursorHeight: 30,
      style: TextStyle(
          fontSize: 24,
          height: 1.2,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600),
      decoration: InputDecoration.collapsed(
        hintText: "Nhập tên bài hát",
        hintStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(.2)),
      ),
      maxLines: 1,
      onSubmitted: (value) {},
    );
  }

  descriptionUI() {
    return TextField(
      enableSuggestions: false,
      controller: _descriptionController..text = "Lam bai tap ve nha",
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.text,
      cursorColor: Theme.of(context).primaryColor,
      // cursorHeight: 30,
      style: TextStyle(fontSize: 16, height: 1.2, color: Colors.black87),
      decoration: InputDecoration.collapsed(
        hintText: "Nhập tên bài hát",
        hintStyle: TextStyle(
            fontSize: 16, height: 1.2, color: Colors.black.withOpacity(.2)),
      ),
      maxLines: 1,
      onSubmitted: (value) {},
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

  Widget sliverAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 18),
          child: InkWell(
            onTap: () {
              EasyLoading.showSuccess('Saved!');
              Future.delayed(new Duration(seconds: 1), () {
                Navigator.pop(context);
              });
            },
            child: Icon(
              Icons.save_rounded,
              size: 24,
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
      ],
      title: Text(
        'Todo detail',
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _floatingBtn() {
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
          Icons.save,
          color: Colors.white,
        ),
        onPressed: () {},
        iconSize: 30.0,
      ),
    );
  }
}

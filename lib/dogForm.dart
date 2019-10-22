import 'package:flutter/material.dart';
import 'bloc/DogBloc.dart';
import 'model/Dog.dart';

class DogForm extends StatefulWidget {
  final bool edit;
  final Dog dog;

  DogForm(this.edit, {this.dog}) : assert(edit == true || dog == null);

  @override
  _DogFormState createState() => _DogFormState();
}

class _DogFormState extends State<DogForm> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController ageEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DogBloc dogBloc = DogBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.edit == true) {
      nameEditingController.text = widget.dog.name;
      ageEditingController.text = widget.dog.age.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.edit ? "Edit Dog" : "Add Dog"),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlutterLogo(
                    size: 300,
                  ),
                  textFormField(nameEditingController, "Name", "Enter Name",
                      Icons.pets, widget.edit ? widget.dog.name : "s"),
                  textFormField(ageEditingController, "Age", "Enter Age",
                      Icons.cake, widget.edit ? widget.dog.age.toString() : "5"),
                  RaisedButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (!_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
                      } else if (widget.edit == true) {
                        dogBloc.updateDog(new Dog(
                            name: nameEditingController.text,
                            age: int.parse(ageEditingController.text),
                            id: widget.dog.id));
                        Navigator.pop(context);
                      } else {
                        await dogBloc.addDog(new Dog(
                            name: nameEditingController.text,
                            age: int.parse(ageEditingController.text)));
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }

  textFormField(TextEditingController t, String label, String hint,
      IconData iconData, String initialValue) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
        },
        controller: t,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            prefixIcon: Icon(iconData),
            hintText: hint,
            labelText: label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'bloc/DogBloc.dart';
import 'model/Dog.dart';
import 'dogForm.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DogBloc dogBloc = DogBloc();

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter SQLite"),
        actions: <Widget>[
          RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
              setState(() {});
            },
            child: Text(
              "Delete all",
              style: TextStyle(color: Colors.yellow),
            ),
          )
        ],
      ),
      body: StreamBuilder(
          stream: dogBloc.dogs,
          builder: (BuildContext context, AsyncSnapshot<List<Dog>> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.length != 0
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Dog item = snapshot.data[index];
                        return Dismissible(
                          key: UniqueKey(),
                          background: Container(color: Colors.red),
                          onDismissed: (direction) {
                            dogBloc.deleteDogById(item.id);
                          },
                          child: ListTile(
                            title: Text(item.name),
                            subtitle: Text(item.age.toString()),
                            leading:
                                CircleAvatar(child: Text(item.id.toString())),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DogForm(
                                        true,
                                        dog: item,
                                      )));
                            },
                          ),
                        );
                      },
                    )
                  : Container(
                      child: Center(
                      //this is used whenever there 0 Todo
                      //in the data base
                      child: Text("Start adding dogs"),
                    ));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => DogForm(false)));
          }),
    );
  }
}

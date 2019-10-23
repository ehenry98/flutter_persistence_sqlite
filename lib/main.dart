import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/DogBloc.dart';
import 'model/Dog.dart';
import 'dogForm.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        builder: (BuildContext context) => DogBloc(),
        child: MaterialApp(
          title: "Flutter Demo",
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: MyHomePage(),
        ),
    );
  }

}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final DogBloc dogBloc = BlocProvider.of<DogBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Flutter SQLite Dogs")),
      body: Container(
        child: StreamBuilder(
            stream: dogBloc.dogs,
            builder: (BuildContext context, AsyncSnapshot<List<Dog>> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data.length != 0
                    ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Dog item = snapshot.data[index];
                    return Dismissible(
                      key: new ObjectKey(item),
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
                              builder: (context) =>
                                  DogForm(
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
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => DogForm(false)));
          }),
    );
  }
}

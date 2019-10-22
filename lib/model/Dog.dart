class Dog {
  final int id;
  final String name;
  final int age;

  Dog({this.id, this.name, this.age});

  factory Dog.fromMap(Map<String, dynamic> data) => Dog(
    //This will be used to convert JSON objects that
    //are coming from querying the database and converting
    //it into a Todo object
    id: data['id'],
    name: data['name'],
    //Since sqlite doesn't have boolean type for true/false
    //we will 0 to denote that it is false
    //and 1 for true
    age: data['age'],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'age': this.age,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
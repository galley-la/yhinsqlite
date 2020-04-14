class ToDoModel {

  // Field 
  int id;
  String todo;

  // Method
  ToDoModel(this.id,this.todo);

  ToDoModel.fromMap(Map<String, dynamic> map){
    id = map['id'];
    todo = map['ToDo'];
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = Map();
    
    map['ToDo'] = todo;
    return map;
  } 
  
}
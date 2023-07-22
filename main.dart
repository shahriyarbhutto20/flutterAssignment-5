import 'dart:io';

void main() {
  login(users: users);
  showCategory(books);
}

List users = [
  {"id": 0, "account": 'librarian', "password": "1234"},
  {"id": 1, "account": 'student', "password": "1234"}
];

List books = [
  {
    'science': ['Physics', 'Chemistry', 'Bootny', 'Astronomy']
  },
  {
    'General': ['General A', 'General B', 'General C']
  }
];

List indexStudentRequest = [];

void login({List? users, Map? indexObj}) {
  print("********Welcome to the Library Management System********");
  print("********Please Enter Your Credentials********");
  print("********Enter Account Name***********");
  var account = stdin.readLineSync();
  print("********Enter Password*********");
  var password = stdin.readLineSync();
  for (int i = 0; i < users!.length; i++) {
    if (account == users[i]['account'] && password == users[i]['password']) {
      print("********You Are Successfully Logged In********");
      if (account == 'librarian') {
        if (indexObj == null) {
          ShowBooksAdmin(books);
          showCategory(books);
          return;
        }
        if (indexObj.isEmpty == false) {
          checkRequestToTeacher(indexObj);
        } else {
          showCategory(books);
        }
      }
      return;
    }
  }
  print("********Wrong Credentials********");
}

void showCategory(books) {
  print("*********************");
  print("*******Available Books*************");
  List objKeys = [];
  for (int i = 0; i < books.length; i++) {
    objKeys.add(books[i].keys);
  }
  for (int i = 0; i < objKeys.length; i++) {
    print("Press ${i} for ${objKeys[i]}");
  }
  String? choice = stdin.readLineSync();
  int index = int.parse(choice!);
  showBooks(books[index], index);
}

void showBooks(Map books, int index) {
  switch (index) {
    case 0:
      String category = "science";
      int indexValue = index;
      iterateBooks(books['science'], category, indexValue);
      break;
    case 1:
      String category = "General";
      int indexValue = index;
      iterateBooks(books['General'], category, indexValue);
      break;
    default:
      print("Invalid option selected.");
  }
}

void iterateBooks(List books, String category, int indexValue) {
  bool flag = true;
  while (flag) {
    for (int i = 0; i < books.length; i++) {
      print("Press ${i} ${books[i]}");
    }
    print("press 4 for Exit");
    print("press 5 for Logout");

    Map indexObj = {
      "index": indexValue,
      "category": category,
      "indexStudentRequest": indexStudentRequest
    };
    String? choice = stdin.readLineSync();

    if (choice == '4') {
      flag = false;
      return;
    }
    if (choice == '5') {
      int index = int.parse(choice!);
      login(users: users, indexObj: indexObj);
      flag = false;
      return;
    }

    int index = int.parse(choice!);
    indexStudentRequest.add(index);

    print(indexObj);
  }
}

void checkRequestToTeacher(Map indexObj) {
  print("Some Request has been made from student press y for yes n for no");
  int index = indexObj['index'];
  print(books[index][indexObj['category']]);
  print(indexObj['indexStudentRequest']);

  print(indexObj);
  String? choice = stdin.readLineSync();
  if (choice == 'y') {
    for (int i in indexObj['indexStudentRequest']) {
      books[index][indexObj['category']].removeAt(i);
      print(books[index][indexObj['category']]);
    }
    print("Request has been approved");
    showCategory(books);
  } else {
    print("Request has not been approved");
  }
}

// ######################## ADMIN ADD AND DELETE SECTION ######################

ShowBooksAdmin(books) {
  print('Want to Update book?  Y/N');
  String? update = stdin.readLineSync();
  if (update == 'y') {
    print('for Delete press 0');
    print('for Add press 1');
    String updateResponse = stdin.readLineSync()!;
    if (updateResponse == '0') {
      DeleteBooks(books);
    } else if (updateResponse == '1') {
      AddMainBooks(books);
    } else {
      print("Invalid option selected.");
    }
  } else if (update == 'n') {
    print('-------->>>>>>> Total Books Avialible : <<<<<---------');
    print('****************SCIENCE CATEGORY *********************');
    print(books[0]['science']);
    print('****************GENERAL CATEGORY *********************');
    print(books[1]['General']);
  } else {
    print("Invalid option selected.");
  }
}

// ######################## For DELETE ######################

DeleteBooks(books) {
  List objKeys = [];
  for (int i = 0; i < books.length; i++) {
    objKeys.add(books[i].keys);
  }
  for (int i = 0; i < objKeys.length; i++) {
    print("Press ${i} for ${objKeys[i]}");
  }
  String? choice = stdin.readLineSync();
  int index = int.parse(choice!);
  DelBooks(books[index], index);
}

DelBooks(Map books, int index) {
  switch (index) {
    case 0:
      iterateBooksForDel(books['science']);
      break;
    case 1:
      iterateBooksForDel(books['General']);
      break;
    default:
      print("Invalid option selected.");
  }
}

iterateBooksForDel(List books) {
  for (int i = 0; i < books.length; i++) {
    print("Press ${i} ${books[i]}");
  }
  String? choice = stdin.readLineSync();
  int index = int.parse(choice!);
  books.removeAt(index);
  print(books);
}

// ######################## For ADD ######################

AddMainBooks(books) {
  List objKeys = [];
  for (int i = 0; i < books.length; i++) {
    objKeys.add(books[i].keys);
  }
  for (int i = 0; i < objKeys.length; i++) {
    print("Press ${i} for ${objKeys[i]}");
  }
  String? choice = stdin.readLineSync();
  int index = int.parse(choice!);
  AddBooks(books[index], index);
}

AddBooks(Map books, int index) {
  switch (index) {
    case 0:
      iterateBooksForAdd(books['science']);
      break;
    case 1:
      iterateBooksForAdd(books['General']);
      break;
    default:
      print("Invalid option selected.");
  }
}

iterateBooksForAdd(List books) {
  for (int i = 0; i < books.length; i++) {
    print("Press ${i} ${books[i]}");
  }
  print("Write the Name of new book.");
  String? inputBook = stdin.readLineSync();
  books.add(inputBook);
  print(books);
}

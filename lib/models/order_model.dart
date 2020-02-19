import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableSQLite = 'orderTABLE';
final String column_id = 'id';
final String column_idOrder = 'IOrder';
final String column_Order = 'Order';
final String column_Prie = 'Price';

class OrderModel {
  // Field
  int id;
  String idOrder, order, price;

  // Method
  OrderModel({this.id, this.idOrder, this.order, this.price});

  Map<String, dynamic> toMap() {
    // tableSQLite = '123';
    return {};
  }
} // OrderModel

class OrderHelper {
  // Field
  Database database;

  // Method
  OrderHelper() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (Database database, int version) {
        return database.execute(
            'CREATE TABLE $tableSQLite($column_id INT PRIMARY KEY AUTOINCREMENT, $column_idOrder TEXT, $column_Order TEXT, $column_Prie TEXT)');
      },
      version: 1,
    );
  }

  Future<void> insertOrder(OrderModel orderModel) async {
    try {
      database.insert(
        tableSQLite,
        orderModel.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('eInsert = ${e.toString()}');
    }
  }
}

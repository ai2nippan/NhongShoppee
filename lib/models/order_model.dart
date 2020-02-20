import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String nameDatabaseFile = 'NhongShoppee.db';
final String tableSQLite = 'orderTABLE';
final String column_id = 'id';
final String column_idOrder = 'IOrder';
final String column_Order = 'OrderX';
final String column_Price = 'Price';

class OrderModel {
  // Field
  int id;
  String idOrder, order, price;

  // Method
  OrderModel({this.id, this.idOrder, this.order, this.price});

  Map<String, dynamic> toMap() {
    // tableSQLite = '123';
    return {
      column_idOrder: this.idOrder,
      column_Order: this.order,
      column_Price: this.price
    };
  }
} // OrderModel

class OrderHelper {
  // Field
  // Database database;

  // Method
  OrderHelper() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    // database = await openDatabase(join(await getDatabasesPath(), nameDatabaseFile),
    await openDatabase(join(await getDatabasesPath(), nameDatabaseFile),
        onCreate: (Database database, int version) {
      return database.execute(
          'CREATE TABLE $tableSQLite ($column_id INTEGER PRIMARY KEY AUTOINCREMENT, $column_idOrder TEXT, $column_Order TEXT, $column_Price TEXT)');
    }, version: 1);
  }

  Future<void> insertOrder(OrderModel orderModel) async {
 
    Database database = await openDatabase(join(await getDatabasesPath(), nameDatabaseFile));

    print('orderModel.toMap =====> ${orderModel.toMap()}');

    try {
      database.insert(
        tableSQLite,
        orderModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      // database.close();

    } catch (e) {
      // print('eInsert = ${e.toString()}');
      print('eInsert ====> ${e.toString()}');
    }
  }

  Future<List<OrderModel>> getAllSQLite() async {

    Database database = await openDatabase(join(await getDatabasesPath(),nameDatabaseFile));

    final List<Map<String, dynamic>> orders = await database.query(tableSQLite);

    // database.close();

    return List.generate(orders.length, (index) {
      return OrderModel(
        id: orders[index][column_id],
        idOrder: orders[index][column_idOrder],
        order: orders[index][column_Order],
        price: orders[index][column_Price],
      );
    });
  }
}

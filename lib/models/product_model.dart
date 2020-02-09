class ProductModel {

  // Field
  String id, category, nameFood, price, detail;


  // Constructor
  ProductModel(this.id, this.category, this.nameFood, this.detail);

  ProductModel.fromJSON(Map<String, dynamic> map){
    id = map['id'];
    category = map['Category'];
    nameFood = map['NameFood'];
    price = map['Price'];
    detail = map['Detail'];
  }

}
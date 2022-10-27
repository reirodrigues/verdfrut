import 'package:greenfrut/src/models/cart_item_model.dart';
import 'package:greenfrut/src/models/item_model.dart';
import 'package:greenfrut/src/models/order_model.dart';
import 'package:greenfrut/src/models/user_model.dart';

ItemModel apple = ItemModel(
  itemName: 'Maçã',
  imgUrl: 'assets/images/fruits/apple.png',
  unit: 'kg',
  price: 6.39,
  description: 'A melhor maçã da região, do campo direto para sua casa.',
);
ItemModel grape = ItemModel(
  itemName: 'Uva',
  imgUrl: 'assets/images/fruits/grape.png',
  unit: 'kg',
  price: 9.70,
  description: 'A melhor uva da região, do campo direto para sua casa.',
);
ItemModel guava = ItemModel(
  itemName: 'Goiaba',
  imgUrl: 'assets/images/fruits/guava.png',
  unit: 'kg',
  price: 7.59,
  description: 'A melhor maçã da região, do campo direto para sua casa.',
);
ItemModel kiwi = ItemModel(
  itemName: 'Kiwi',
  imgUrl: 'assets/images/fruits/kiwi.png',
  unit: 'un',
  price: 19.90,
  description: 'A melhor maçã da região, do campo direto para sua casa.',
);
ItemModel mango = ItemModel(
  itemName: 'Manga',
  imgUrl: 'assets/images/fruits/mango.png',
  unit: 'kg',
  price: 3.00,
  description: 'A melhor maçã da região, do campo direto para sua casa.',
);
ItemModel papaya = ItemModel(
  itemName: 'Mamão',
  imgUrl: 'assets/images/fruits/papaya.png',
  unit: 'kg',
  price: 5.12,
  description: 'A melhor maçã da região, do campo direto para sua casa.',
);

List<ItemModel> items = [
  apple,
  grape,
  guava,
  kiwi,
  mango,
  papaya,
];

List<String> categories = [
  'Frutas',
  'Grãos',
  'Verduras',
  'Temperos',
  'Cereais',
  'Carnes',
];

List<CartItemModel> cartItems = [
  CartItemModel(
    item: apple,
    quantity: 2,
  ),
  CartItemModel(
    item: papaya,
    quantity: 1,
  ),
  CartItemModel(
    item: kiwi,
    quantity: 4,
  ),
];

UserModel user = UserModel(
  name: 'Reinaldo',
  email: 'reyrodrigues13@gmail.com',
  phone: '81997035049',
  cpf: '12345678912',
  password: '123456',
);

List<OrderModel> orders = [
  OrderModel(
    copyAndPaste: 'dbad7h273hagh87dg23go8d7gi23gdi7g3di723gd7263g',
    createdDateTime: DateTime.parse(
      '2023-06-08 10:00:10.458',
    ),
    overdueDateTime: DateTime.parse(
      '2023-06-08 11:00:10.458',
    ),
    id: 'asd6a76da876sd',
    status: 'pending_payment',
    total: 11.0,
    items: [
      CartItemModel(
        item: apple,
        quantity: 2,
      ),
      CartItemModel(
        item: mango,
        quantity: 2,
      ),
      CartItemModel(
        item: kiwi,
        quantity: 2,
      ),
    ],
  ),
  OrderModel(
    copyAndPaste: 'dbad7h273hagh87dgdas67ds7sdasdf3di723gd7263g',
    createdDateTime: DateTime.parse(
      '2023-06-05 22:00:10.458',
    ),
    overdueDateTime: DateTime.parse(
      '2023-06-05 23:00:10.458',
    ),
    id: 'as6asd8asf',
    status: 'delivered',
    total: 11.0,
    items: [
      CartItemModel(
        item: apple,
        quantity: 2,
      ),
      CartItemModel(
        item: guava,
        quantity: 2,
      ),
    ],
  )
];

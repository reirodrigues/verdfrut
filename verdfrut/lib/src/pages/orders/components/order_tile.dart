import 'package:flutter/material.dart';
import 'package:greenfrut/src/config/custom_colors.dart';
import 'package:greenfrut/src/models/cart_item_model.dart';
import 'package:greenfrut/src/models/order_model.dart';
import 'package:greenfrut/src/pages/orders/components/order_status_widget.dart';
import 'package:greenfrut/src/pages/widgets/payment_dialog.dart';
import 'package:greenfrut/src/services/utils_services.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;
  final UtilsServices utilsServices = UtilsServices();

  OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          initiallyExpanded: order.status != 'delivered',
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pedido: ${order.id}',
                style: TextStyle(
                  color: CustomColors.customSwatchColor,
                ),
              ),
              Text(
                utilsServices.formateDateTime(order.createdDateTime),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  // --------------------------------------------------- List Product
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 150,
                      child: ListView(
                        children: order.items.map((element) {
                          return _OrderItemWidget(
                            utilsServices: utilsServices,
                            element: element,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  // --------------------------------------------------- divider

                  VerticalDivider(
                    color: Colors.grey.shade300,
                    thickness: 2,
                    width: 10,
                  ),

                  // --------------------------------------------------- order states

                  Expanded(
                    flex: 2,
                    child: OrderStatusWidget(
                      status: order.status,
                      isOverdue: order.overdueDateTime.isBefore(DateTime.now()),
                    ),
                  ),
                ],
              ),

              // --------------------------------------------------------- total
            ),
            Text.rich(
              TextSpan(
                style: const TextStyle(
                  fontSize: 20,
                ),
                children: [
                  const TextSpan(
                    text: 'Total ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: utilsServices.priceToCurrency(order.total),
                    style: const TextStyle(),
                  )
                ],
              ),
            ),

            // --------------------------------------------------------- payment
            Visibility(
              visible: order.status == 'pending_payment',
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return PaymentDialog(
                        order: order,
                      );
                    },
                  );
                },
                icon: Image.asset(
                  'assets/images/pix.png',
                  height: 18,
                ),
                label: const Text('Ver QR Code Pix'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    Key? key,
    required this.utilsServices,
    required this.element,
  }) : super(key: key);

  final UtilsServices utilsServices;

  final CartItemModel element;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${element.quantity} ${element.item.unit} ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              element.item.itemName,
            ),
          ),
          Text(
            utilsServices.priceToCurrency(element.totalPrice()),
          ),
        ],
      ),
    );
  }
}

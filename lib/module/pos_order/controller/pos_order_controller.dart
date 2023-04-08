import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import 'package:hyper_ui/service/order_service/order_service.dart';
import 'package:hyper_ui/service/product_service/product_service.dart';
import 'package:hyper_ui/state_util.dart';
import '../view/pos_order_view.dart';

class PosOrderController extends State<PosOrderView> implements MvcController {
  static late PosOrderController instance;
  late PosOrderView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  doDelete(String id) async {
    await ProductService().delete(id);
  }

  String search = "";
  updateSearch(String queary) {
    search = queary;
    setState(() {});
  }

  List productsList = [];
  getQty(item) {
    var index = productsList.indexWhere((i) => i["id"] == item["id"]);
    if (index > -1) {
      productsList[index]["qty"] ??= 0;
      return productsList[index]["qty"];
    }
    return 0;
  }

  increaseQty(item) {
    addProductIfNotFound(item);
    var index = productsList.indexWhere((i) => i["id"] == item["id"]);
    if (index > -1) {
      productsList[index]["qty"] ??= 0;
      productsList[index]["qty"]++;
    }
    setState(() {});
  }

  decreaseQty(item) {
    addProductIfNotFound(item);
    var index = productsList.indexWhere((i) => i["id"] == item["id"]);
    if (index > -1) {
      productsList[index]["qty"] ??= 0;
      productsList[index]["qty"]--;
    }
    setState(() {});
  }

  addProductIfNotFound(item) {
    var index = productsList.indexWhere((i) => i["id"] == item["id"]);
    if (index == -1) {
      item["qty"] = 0;
      productsList.add(item);
    }
  }

  double get total {
    double itemTotal = 0;
    for (var item in productsList) {
      itemTotal += item["qty"] * item["price"];
    }
    return itemTotal;
  }

  checkout() async {
    showLoading();
    await OrderService().create(
      tableNumber: widget.tableNumber,
      items: productsList,
      total: total,
      paymentMethod: "Cash",
      status: "Pending",
    );
    hideLoading();
    Get.offAll(const MainNavigationView());
    showInfoDialog("Your order is created");
  }
}

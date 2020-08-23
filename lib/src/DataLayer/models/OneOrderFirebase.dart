
import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
import 'package:foodgallery/src/DataLayer/models/OrderedItem.dart';

class OneOrderFirebase {

  CustomerInformation       oneCustomer;
  List<OrderedItem>         orderedItems;
  String                    orderBy;
  String                    paidStatus;
  String                    paidType;
  double                    totalPrice;
  String                    contact;
  String                    driverName;
  DateTime                  endDate;
  DateTime                  startDate;
  String                    formattedOrderPlacementDate;
  String                    formattedOrderPlacementDatesTimeOnly;
  String                    orderStatus;
  String                    tableNo;
  String                    orderType;
  String                    documentId;
  double                    deliveryCost;
  double                    tax; // 14% upon total Cost.
  double                    priceWithDelivery;
  int                       orderProductionTime;
  int                       tempPaymentIndex;

  OneOrderFirebase(
      {
        this.oneCustomer,
        this.orderedItems,
        this.orderBy,
        this.paidStatus,
        this.paidType,
        this.totalPrice,
        this.contact,
        this.driverName,
        this.endDate,
        this.startDate,
        this.formattedOrderPlacementDate,
        this.formattedOrderPlacementDatesTimeOnly,
        this.orderStatus,
        this.tableNo,
        this.orderType,
        this.documentId,
        this.deliveryCost,
        this.tax, // 14% upon total Cost.
        this.priceWithDelivery,
        this.orderProductionTime, //  int minutes3 =minutes2.ceil(); // no need to have double
        this.tempPaymentIndex,
      }
      );



}

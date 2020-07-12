
class OneOrderFirebase {

  Map<String,dynamic>       customerAddress;
  List<dynamic>             orderedItems;
  String                    orderBy;
  String                    paidStatus;
  String                    paidType;
  double                    totalPrice;
  String                    contact;
  String                    driverName;
  DateTime                  endDate;
  DateTime                  startDate;
  String                    orderStatus;
  String                    tableNo;
  String                    type;
  String                    documentId;

  OneOrderFirebase(
      {
        this.customerAddress,
        this.orderedItems,
        this.orderBy,
        this.paidStatus,
        this.paidType,
        this.totalPrice,
        this.contact,
        this.driverName,
        this.endDate,
        this.startDate,
        this.orderStatus,
        this.tableNo,
        this.type,
        this.documentId,
      }
      );



}

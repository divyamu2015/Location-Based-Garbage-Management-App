// To parse this JSON data, do
//
//     final userPymentHistoryModel = userPymentHistoryModelFromJson(jsonString);

import 'dart:convert';

List<UserPymentHistoryModel> userPymentHistoryModelFromJson(String str) => List<UserPymentHistoryModel>.from(json.decode(str).map((x) => UserPymentHistoryModel.fromJson(x)));

String userPymentHistoryModelToJson(List<UserPymentHistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserPymentHistoryModel {
    int id;
    String paymentOption;
    String status;
    String totalPrice;
    String cashStatus;
    dynamic transactionId;
    dynamic nameOfCard;
    dynamic cardNumber;
    dynamic expiryDate;
    dynamic cvv;
    int user;
    int wasteSubmission;

    UserPymentHistoryModel({
        required this.id,
        required this.paymentOption,
        required this.status,
        required this.totalPrice,
        required this.cashStatus,
        required this.transactionId,
        required this.nameOfCard,
        required this.cardNumber,
        required this.expiryDate,
        required this.cvv,
        required this.user,
        required this.wasteSubmission,
    });

    factory UserPymentHistoryModel.fromJson(Map<String, dynamic> json) => UserPymentHistoryModel(
        id: json["id"],
        paymentOption: json["payment_option"],
        status: json["status"],
        totalPrice: json["total_price"],
        cashStatus: json["cash_status"],
        transactionId: json["transaction_id"],
        nameOfCard: json["name_of_card"],
        cardNumber: json["card_number"],
        expiryDate: json["expiry_date"],
        cvv: json["cvv"],
        user: json["user"],
        wasteSubmission: json["waste_submission"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "payment_option": paymentOption,
        "status": status,
        "total_price": totalPrice,
        "cash_status": cashStatus,
        "transaction_id": transactionId,
        "name_of_card": nameOfCard,
        "card_number": cardNumber,
        "expiry_date": expiryDate,
        "cvv": cvv,
        "user": user,
        "waste_submission": wasteSubmission,
    };
}

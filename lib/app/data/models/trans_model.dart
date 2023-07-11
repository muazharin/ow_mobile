class GroupTrans {
  GroupTrans({
    this.name,
    this.riwayat,
  });

  String? name;
  List<TransModel>? riwayat;

  factory GroupTrans.fromJson(Map<String, dynamic> json) => GroupTrans(
        name: json["nama"],
        riwayat: List<TransModel>.from(
            json["riwayat"].map((x) => TransModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nama": name,
        "riwayat": List<dynamic>.from(riwayat!.map((x) => x.toJson())),
      };
}

class TransModel {
  int? transId;
  String? transType;
  String? transCategory;
  String? transDetail;
  int? transPrice;
  DateTime? transDate;
  bool? transIsSeen;
  TransUser? transUser;
  TransWallet? transWallet;

  TransModel({
    this.transId,
    this.transType,
    this.transCategory,
    this.transDetail,
    this.transPrice,
    this.transDate,
    this.transIsSeen,
    this.transUser,
    this.transWallet,
  });

  factory TransModel.fromJson(Map<String, dynamic> json) => TransModel(
        transId: json["trans_id"],
        transType: json["trans_type"],
        transCategory: json["trans_category"],
        transDetail: json["trans_detail"],
        transPrice: json["trans_price"],
        transDate: json["trans_date"] == null
            ? null
            : DateTime.parse(json["trans_date"]),
        transIsSeen: json["trans_is_seen"],
        transUser: json["trans_user"] == null
            ? null
            : TransUser.fromJson(json["trans_user"]),
        transWallet: json["trans_wallet"] == null
            ? null
            : TransWallet.fromJson(json["trans_wallet"]),
      );

  Map<String, dynamic> toJson() => {
        "trans_id": transId,
        "trans_type": transType,
        "trans_category": transCategory,
        "trans_detail": transDetail,
        "trans_price": transPrice,
        "trans_date": transDate?.toIso8601String(),
        "trans_is_seen": transIsSeen,
        "trans_user": transUser?.toJson(),
        "trans_wallet": transWallet?.toJson(),
      };
}

class TransUser {
  int? transUserId;
  String? transUserName;
  String? transUserEmail;
  String? transUserPhone;
  String? transUserPhoto;

  TransUser({
    this.transUserId,
    this.transUserName,
    this.transUserEmail,
    this.transUserPhone,
    this.transUserPhoto,
  });

  factory TransUser.fromJson(Map<String, dynamic> json) => TransUser(
        transUserId: json["trans_user_id"],
        transUserName: json["trans_user_name"],
        transUserEmail: json["trans_user_email"],
        transUserPhone: json["trans_user_phone"],
        transUserPhoto: json["trans_user_photo"],
      );

  Map<String, dynamic> toJson() => {
        "trans_user_id": transUserId,
        "trans_user_name": transUserName,
        "trans_user_email": transUserEmail,
        "trans_user_phone": transUserPhone,
        "trans_user_photo": transUserPhoto,
      };
}

class TransWallet {
  int? transWalletId;
  String? transWalletName;
  String? transWalletColor;

  TransWallet({
    this.transWalletId,
    this.transWalletName,
    this.transWalletColor,
  });

  factory TransWallet.fromJson(Map<String, dynamic> json) => TransWallet(
        transWalletId: json["trans_wallet_id"],
        transWalletName: json["trans_wallet_name"],
        transWalletColor: json["trans_wallet_color"],
      );

  Map<String, dynamic> toJson() => {
        "trans_wallet_id": transWalletId,
        "trans_wallet_name": transWalletName,
        "trans_wallet_color": transWalletColor,
      };
}

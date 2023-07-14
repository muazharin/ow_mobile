class TransDetailModel {
  int? transId;
  String? transType;
  String? transCategory;
  String? transDetail;
  int? transPrice;
  DateTime? transDate;
  bool? transIsSeen;
  TransUser? transUser;
  TransWallet? transWallet;
  List<TransFile>? transFile;

  TransDetailModel({
    this.transId,
    this.transType,
    this.transCategory,
    this.transDetail,
    this.transPrice,
    this.transDate,
    this.transIsSeen,
    this.transUser,
    this.transWallet,
    this.transFile,
  });

  factory TransDetailModel.fromJson(Map<String, dynamic> json) =>
      TransDetailModel(
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
        transFile: json["trans_file"] == null
            ? []
            : List<TransFile>.from(
                json["trans_file"]!.map((x) => TransFile.fromJson(x))),
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
        "trans_file": transFile == null
            ? []
            : List<dynamic>.from(transFile!.map((x) => x.toJson())),
      };
}

class TransFile {
  int? transFileId;
  String? transFileImage;

  TransFile({
    this.transFileId,
    this.transFileImage,
  });

  factory TransFile.fromJson(Map<String, dynamic> json) => TransFile(
        transFileId: json["trans_file_id"],
        transFileImage: json["trans_file_image"],
      );

  Map<String, dynamic> toJson() => {
        "trans_file_id": transFileId,
        "trans_file_image": transFileImage,
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

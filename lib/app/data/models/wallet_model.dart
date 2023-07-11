class WalletModel {
  int? walletId;
  String? walletName;
  int? walletMoney;
  String? walletColor;
  DateTime? walletCreatedAt;
  DateTime? walletUpdatedAt;
  bool? walletIsActive;

  WalletModel({
    this.walletId,
    this.walletName,
    this.walletMoney,
    this.walletColor,
    this.walletCreatedAt,
    this.walletUpdatedAt,
    this.walletIsActive = false,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        walletId: json["wallet_id"],
        walletName: json["wallet_name"],
        walletMoney: json["wallet_money"],
        walletColor: json["wallet_color"],
        walletCreatedAt: json["wallet_created_at"] == null
            ? null
            : DateTime.parse(json["wallet_created_at"]),
        walletUpdatedAt: json["wallet_updated_at"] == null
            ? null
            : DateTime.parse(json["wallet_updated_at"]),
        walletIsActive: json["wallet_is_active"],
      );

  Map<String, dynamic> toJson() => {
        "wallet_id": walletId,
        "wallet_name": walletName,
        "wallet_money": walletMoney,
        "wallet_color": walletColor,
        "wallet_created_at": walletCreatedAt?.toIso8601String(),
        "wallet_updated_at": walletUpdatedAt?.toIso8601String(),
        "wallet_is_active": walletIsActive,
      };
}

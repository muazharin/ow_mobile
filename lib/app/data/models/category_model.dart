class CategoryModel {
  int? categoryId;
  int? categoryWalletId;
  String? categoryTitle;
  String? categoryType;
  bool? categoryIsActive;

  CategoryModel({
    this.categoryId,
    this.categoryWalletId,
    this.categoryTitle,
    this.categoryType,
    this.categoryIsActive,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categoryId: json["category_id"],
        categoryWalletId: json["category_wallet_id"],
        categoryTitle: json["category_title"],
        categoryType: json["category_type"],
        categoryIsActive: json["category_is_active"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_wallet_id": categoryWalletId,
        "category_title": categoryTitle,
        "category_type": categoryType,
        "category_is_active": categoryIsActive,
      };
}

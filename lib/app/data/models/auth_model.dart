class AuthModel {
  dynamic userId;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userPhoto;
  String? userGender;
  DateTime? userTglLahir;
  String? userAddress;
  DateTime? userCreatedAt;
  DateTime? userUpdatedAt;

  AuthModel({
    this.userId,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.userPhoto,
    this.userGender,
    this.userTglLahir,
    this.userAddress,
    this.userCreatedAt,
    this.userUpdatedAt,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        userId: json["user_id"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        userPhone: json["user_phone"],
        userPhoto: json["user_photo"],
        userGender: json["user_gender"],
        userTglLahir: json["user_tgl_lahir"] == null
            ? null
            : DateTime.parse(json["user_tgl_lahir"]),
        userCreatedAt: json["user_created_at"] == null
            ? null
            : DateTime.parse(json["user_created_at"]),
        userUpdatedAt: json["user_updated_at"] == null
            ? null
            : DateTime.parse(json["user_updated_at"]),
        userAddress: json["user_address"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "user_email": userEmail,
        "user_phone": userPhone,
        "user_photo": userPhoto,
        "user_gender": userGender,
        "user_tgl_lahir":
            "${userTglLahir!.year.toString().padLeft(4, '0')}-${userTglLahir!.month.toString().padLeft(2, '0')}-${userTglLahir!.day.toString().padLeft(2, '0')}",
        "user_address": userAddress,
        "user_created_at":
            "${userCreatedAt!.year.toString().padLeft(4, '0')}-${userCreatedAt!.month.toString().padLeft(2, '0')}-${userCreatedAt!.day.toString().padLeft(2, '0')}",
        "user_updated_at":
            "${userUpdatedAt!.year.toString().padLeft(4, '0')}-${userUpdatedAt!.month.toString().padLeft(2, '0')}-${userUpdatedAt!.day.toString().padLeft(2, '0')}",
      };
}

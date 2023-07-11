class MemberModel {
  int? userId;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userPhoto;
  String? userGender;
  DateTime? userTglLahir;
  String? userAddress;
  String? userStatus;

  MemberModel({
    this.userId,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.userPhoto,
    this.userGender,
    this.userTglLahir,
    this.userAddress,
    this.userStatus,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        userId: json["user_id"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        userPhone: json["user_phone"],
        userPhoto: json["user_photo"],
        userGender: json["user_gender"],
        userTglLahir: json["user_tgl_lahir"] == null
            ? null
            : DateTime.parse(json["user_tgl_lahir"]),
        userAddress: json["user_address"],
        userStatus: json["user_status"],
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
        "user_status": userStatus,
      };
}

String? Function(String? v, String n)? valString = (v, n) {
  if (v!.isEmpty) {
    return "$n tidak boleh kosong";
  }
  return null;
};
String? Function(String? v, String n)? valNumber = (v, n) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = RegExp(patttern);
  if (v!.isEmpty) {
    return "$n tidak boleh kosong";
  } else if (!regExp.hasMatch(v)) {
    return "$n harus berupa angka";
  }
  return null;
};
String? Function(String? v, String n)? valEmail = (v, n) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(pattern);
  if (v!.isEmpty) {
    return "$n tidak boleh kosong";
  } else if (!regExp.hasMatch(v)) {
    return "$n tidak valid";
  }
  return null;
};

String? Function(String? v, String n)? valPassword = (v, n) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(pattern);
  if (v!.isEmpty) {
    return "$n tidak boleh kosong";
  } else if (!regExp.hasMatch(v)) {
    return "$n minimal 8 karakter dan paling tidak berisikan 1 huruf kecil, 1 kapital, 1 nomor and 1 spesial karakter ( ! @ # \$ & * ~ )";
  }
  return null;
};

String? Function(String? v, String? n, String? m)? valCPassword = (v, n, m) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(pattern);
  if (v!.isEmpty) {
    return "$n tidak boleh kosong";
  } else if (v != m) {
    return "$n tidak cocok";
  } else if (!regExp.hasMatch(v)) {
    return "$n minimal 8 karakter dan paling tidak berisikan 1 huruf kecil, 1 kapital, 1 nomor and 1 spesial karakter ( ! @ # \$ & * ~ )";
  }
  return null;
};

String? Function(String? v, String n)? valPhone = (v, n) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = RegExp(patttern);
  if (v!.isEmpty) {
    return "$n tidak boleh kosong";
  } else if (v.length < 10) {
    return "$n paling tidak harus 10 digit";
  } else if (!regExp.hasMatch(v)) {
    return "$n harus berupa angka";
  }
  return null;
};

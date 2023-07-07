String? Function(String? v, String n)? valString = (v, n) {
  if (v!.isEmpty) {
    return "$n cannot be empty";
  }
  return null;
};
String? Function(String? v, String n)? valNumber = (v, n) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = RegExp(patttern);
  if (v!.isEmpty) {
    return "$n cannot be empty";
  } else if (!regExp.hasMatch(v)) {
    return "$n must be number";
  }
  return null;
};
String? Function(String? v, String n)? valEmail = (v, n) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(pattern);
  if (v!.isEmpty) {
    return "$n cannot be empty";
  } else if (!regExp.hasMatch(v)) {
    return "$n is invalid";
  }
  return null;
};

String? Function(String? v, String n)? valPassword = (v, n) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(pattern);
  if (v!.isEmpty) {
    return "$n cannot be empty";
  } else if (!regExp.hasMatch(v)) {
    return "$n minimum 8 characters and have at least 1 lowercase letter, 1 uppercase letter, 1 number and 1 special character ( ! @ # \$ & * ~ )";
  }
  return null;
};

String? Function(String? v, String? n, String? m)? valCPassword = (v, n, m) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(pattern);
  if (v!.isEmpty) {
    return "$n cannot be empty";
  } else if (v != m) {
    return "$n doesn't match";
  } else if (!regExp.hasMatch(v)) {
    return "$n minimum 8 characters and have at least 1 lowercase letter, 1 uppercase letter, 1 number and 1 special character ( ! @ # \$ & * ~ )";
  }
  return null;
};

String? Function(String? v, String n)? valPhone = (v, n) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = RegExp(patttern);
  if (v!.isEmpty) {
    return "$n cannot be empty";
  } else if (v.length < 10) {
    return "$n must contain at least 10 digits";
  } else if (!regExp.hasMatch(v)) {
    return "$n must contains number";
  }
  return null;
};

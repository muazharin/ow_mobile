String phoneFormat(String no) {
  if (no[0] == "0") {
    return "+62${no.substring(1)}";
  } else {
    return no;
  }
}

String nameFormat(String name) {
  var list = name.split(" ");
  var newName = "";
  for (var e in list) {
    newName += "${e[0].toUpperCase()}${e.substring(1)} ";
  }
  return newName;
}

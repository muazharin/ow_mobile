String phoneFormat(String no) {
  if (no[0] == "0") {
    return "+62${no.substring(1)}";
  } else {
    return no;
  }
}

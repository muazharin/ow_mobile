// assets path
var pngPath = "assets/png";
var jpgPath = "assets/jpg";
var svgPath = "assets/svg";
var lottiePath = "assets/lottie";

// error message
var rto = "Request Time Out";
var noInternet = "Unable to connect to server";
var unknown = "Something is wrong";

// endpoint

// auth
var authcheckphonenumber = "/auth/check_phone_number";
var authlogin = "/auth/signin";
var authregister = "/auth/signup";

// user
String? authcreatepassword = "/user/create_password";

// wallet
String? getourwallet = "/wallet/get_all_wallet";
String? createwallet = "/wallet/create_wallet";
String? updatewallet = "/wallet/update_wallet";

// owWallet
String? getmemberwallet = "/ow/get_ow_user";
String? addmemberwallet = "/ow/add_member";
String? getmemberforwallet = "/ow/get_for_member";

// transaction
String? gettransactionwallet = "/trans/get_all_by_wallet_id";
String? gettransactionuser = "/trans/get_all_by_user_id";
String? createtransaction = "/trans/create_trans";

// category
String? getcategory = "/category/get_all_category";
String? createcategory = "/category/add_category";
String? updatecategory = "/category/update_category";
String? deletecategory = "/category/delete_category";

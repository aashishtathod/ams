//base url
const String url =
    "http://8423-2409-4053-2202-d972-1025-e26a-e71e-80b6.ngrok.io";
const String apiUrl = "$url/api";

//login api
const String validateUser = "$apiUrl/UserAccount";

//Audit Tab Apis
const String auditList = "$apiUrl/auditlist";
const String auditAssetList = "$apiUrl/auditassetlist";
const String updateScannedAuditAsset = "$apiUrl/updateauditscanasset";

//Asset Details Api
const String assetDetails = "$apiUrl/scannedauditasset";

//Transfer Tab Apis
//Location  ,SubLoaction  , UserInfo Api
const String location = "$apiUrl/location";
const String subLocation = "$apiUrl/sublocation";
const String userInfo = "$apiUrl/userinfo";
const String transferApi = "$apiUrl/transferrequest";

//Sale tab api
const String saleApi = "$apiUrl/salerequest";

//Discard api
const String discardApi = "$apiUrl/discardrequest";

//all users List
const String userList = "$apiUrl/userslist";

//Raise Ticket Api
const String ticketRequest = "$apiUrl/ticketrequest";

//Raise Maintainance
const String maintenanceRequest = "$apiUrl/maintenanceassetrequest";

//assset master list
const String assetMaster = "$apiUrl/assetlist";

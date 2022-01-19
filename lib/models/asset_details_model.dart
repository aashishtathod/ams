import 'dart:convert';

AssetDetails assetDetailsFromJson(String str) =>
    AssetDetails.fromJson(json.decode(str));

class AssetDetails {
  AssetDetails({
    this.responseCode,
    this.responseStatus,
    this.responseMessage,
    this.totalItems,
    this.data,
  });

  int? responseCode;
  String? responseStatus;
  String? responseMessage;
  int? totalItems;
  Data? data;

  factory AssetDetails.fromJson(Map<String, dynamic> json) => AssetDetails(
        responseCode: json["ResponseCode"],
        responseStatus: json["ResponseStatus"],
        responseMessage: json["ResponseMessage"],
        totalItems: json["TotalItems"],
        data: Data.fromJson(json["Data"]),
      );
}

class Data {
  Data({
    this.assetId,
    this.financialYearId,
    this.financialYear,
    this.locationId,
    this.locationName,
    this.subLocationId,
    this.subLocationName,
    this.assetCategoryId,
    this.assetCategoryName,
    this.assetSubCategoryId,
    this.assetSubcategoryName,
    this.taggingId,
    this.physicalVerificationId,
    this.locationCodeErp,
    this.locationNameErp,
    this.subLocationCodeErp,
    this.subLocationNameErp,
    this.department,
    this.custodian,
    this.assetCode,
    this.serialNumber,
    this.assetNumber,
    this.assetNumberOld,
    this.assetName,
    this.assetMake,
    this.assetModel,
    this.assetDescription,
    this.usefulLife,
    this.assetConditionId,
    this.assetCondition,
    this.isInUse,
    this.quantity,
    this.capitalizationDate,
    this.acquisitionDate,
    this.openingGrossValue,
    this.acquisitionValue,
    this.writeOffValue,
    this.closingGrossValue,
    this.openingAccumulatedDepreciation,
    this.currentYearDepreciation,
    this.closingAccumulatedDepreciation,
    this.openingWdv,
    this.closingWdv,
    this.depreciationKey,
    this.depreciationStartDate,
    this.cumulitiveAcquisitionValue,
    this.transactionAcquisitionValue,
    this.plannedDepreciationValue,
    this.plant,
    this.vendor,
    this.writeUpValue,
    this.transactionAccumulatedDepreciation,
    this.evaluationGroup,
    this.businessArea,
    this.sanitizationAssetTypeId,
    this.sanitizationAssetTypeName,
    this.sanitizationAssetName,
    this.sanitizationCostChecked,
    this.sanitizationAssetSurfaceId,
    this.sanitizationAssetSurfaceName,
    this.sanitizationTagTypeId,
    this.sanitizationTagTypeName,
    this.sanitizationTempTagNo,
    this.spocName,
    this.remarks1,
    this.remarks2,
    this.createdBy,
    this.createdByName,
    this.assignedId,
    this.assignedName,
    this.createDate,
    this.updateBy,
    this.updateByName,
    this.updateDate,
    this.updateRemarks,
  });

  dynamic assetId;
  dynamic financialYearId;
  dynamic financialYear;
  dynamic locationId;
  String? locationName;
  dynamic subLocationId;
  String? subLocationName;
  dynamic assetCategoryId;
  dynamic assetCategoryName;
  dynamic assetSubCategoryId;
  dynamic assetSubcategoryName;
  dynamic taggingId;
  dynamic physicalVerificationId;
  dynamic locationCodeErp;
  dynamic locationNameErp;
  dynamic subLocationCodeErp;
  dynamic subLocationNameErp;
  dynamic department;
  dynamic custodian;
  String? assetCode;
  dynamic serialNumber;
  String? assetNumber;
  dynamic assetNumberOld;
  String? assetName;
  dynamic assetMake;
  String? assetModel;
  String? assetDescription;
  dynamic usefulLife;
  dynamic assetConditionId;
  dynamic assetCondition;
  bool? isInUse;
  dynamic quantity;
  DateTime? capitalizationDate;
  DateTime? acquisitionDate;
  dynamic openingGrossValue;
  dynamic acquisitionValue;
  dynamic writeOffValue;
  dynamic closingGrossValue;
  dynamic openingAccumulatedDepreciation;
  dynamic currentYearDepreciation;
  dynamic closingAccumulatedDepreciation;
  dynamic openingWdv;
  dynamic closingWdv;
  dynamic depreciationKey;
  DateTime? depreciationStartDate;
  dynamic cumulitiveAcquisitionValue;
  dynamic transactionAcquisitionValue;
  dynamic plannedDepreciationValue;
  dynamic plant;
  dynamic vendor;
  dynamic writeUpValue;
  dynamic transactionAccumulatedDepreciation;
  dynamic evaluationGroup;
  dynamic businessArea;
  dynamic sanitizationAssetTypeId;
  dynamic sanitizationAssetTypeName;
  dynamic sanitizationAssetName;
  bool? sanitizationCostChecked;
  dynamic sanitizationAssetSurfaceId;
  dynamic sanitizationAssetSurfaceName;
  dynamic sanitizationTagTypeId;
  dynamic sanitizationTagTypeName;
  dynamic sanitizationTempTagNo;
  dynamic spocName;
  String? remarks1;
  dynamic remarks2;
  dynamic createdBy;
  dynamic createdByName;
  dynamic assignedId;
  String? assignedName;
  DateTime? createDate;
  dynamic updateBy;
  dynamic updateByName;
  DateTime? updateDate;
  dynamic updateRemarks;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        assetId: json["AssetID"],
        financialYearId: json["FinancialYearID"],
        financialYear: json["FinancialYear"],
        locationId: json["LocationID"],
        locationName: json["LocationName"],
        subLocationId: json["SubLocationID"],
        subLocationName: json["SubLocationName"],
        assetCategoryId: json["AssetCategoryID"],
        assetCategoryName: json["AssetCategoryName"],
        assetSubCategoryId: json["AssetSubCategoryID"],
        assetSubcategoryName: json["AssetSubcategoryName"],
        taggingId: json["TaggingID"],
        physicalVerificationId: json["PhysicalVerificationID"],
        locationCodeErp: json["LocationCodeERP"],
        locationNameErp: json["LocationNameERP"],
        subLocationCodeErp: json["SubLocationCodeERP"],
        subLocationNameErp: json["SubLocationNameERP"],
        department: json["Department"],
        custodian: json["Custodian"],
        assetCode: json["AssetCode"],
        serialNumber: json["SerialNumber"],
        assetNumber: json["AssetNumber"],
        assetNumberOld: json["AssetNumberOld"],
        assetName: json["AssetName"],
        assetMake: json["AssetMake"],
        assetModel: json["AssetModel"],
        assetDescription: json["AssetDescription"],
        usefulLife: json["UsefulLife"],
        assetConditionId: json["AssetConditionID"],
        assetCondition: json["AssetCondition"],
        isInUse: json["IsInUse"],
        quantity: json["Quantity"],
        capitalizationDate: DateTime.parse(json["CapitalizationDate"]),
        acquisitionDate: DateTime.parse(json["AcquisitionDate"]),
        openingGrossValue: json["OpeningGrossValue"],
        acquisitionValue: json["AcquisitionValue"],
        writeOffValue: json["WriteOffValue"],
        closingGrossValue: json["ClosingGrossValue"],
        openingAccumulatedDepreciation: json["OpeningAccumulatedDepreciation"],
        currentYearDepreciation: json["CurrentYearDepreciation"],
        closingAccumulatedDepreciation: json["ClosingAccumulatedDepreciation"],
        openingWdv: json["OpeningWDV"],
        closingWdv: json["ClosingWDV"],
        depreciationKey: json["DepreciationKey"],
        depreciationStartDate: DateTime.parse(json["DepreciationStartDate"]),
        cumulitiveAcquisitionValue: json["CumulitiveAcquisitionValue"],
        transactionAcquisitionValue: json["TransactionAcquisitionValue"],
        plannedDepreciationValue: json["PlannedDepreciationValue"],
        plant: json["Plant"],
        vendor: json["Vendor"],
        writeUpValue: json["WriteUpValue"],
        transactionAccumulatedDepreciation:
            json["TransactionAccumulatedDepreciation"],
        evaluationGroup: json["EvaluationGroup"],
        businessArea: json["BusinessArea"],
        sanitizationAssetTypeId: json["SanitizationAssetTypeID"],
        sanitizationAssetTypeName: json["SanitizationAssetTypeName"],
        sanitizationAssetName: json["SanitizationAssetName"],
        sanitizationCostChecked: json["SanitizationCostChecked"],
        sanitizationAssetSurfaceId: json["SanitizationAssetSurfaceID"],
        sanitizationAssetSurfaceName: json["SanitizationAssetSurfaceName"],
        sanitizationTagTypeId: json["SanitizationTagTypeID"],
        sanitizationTagTypeName: json["SanitizationTagTypeName"],
        sanitizationTempTagNo: json["SanitizationTempTagNo"],
        spocName: json["SpocName"],
        remarks1: json["Remarks1"],
        remarks2: json["Remarks2"],
        createdBy: json["CreatedBy"],
        createdByName: json["CreatedByName"],
        assignedId: json["AssignedID"],
        assignedName: json["AssignedName"],
        createDate: DateTime.parse(json["CreateDate"]),
        updateBy: json["UpdateBy"],
        updateByName: json["UpdateByName"],
        updateDate: DateTime.parse(json["UpdateDate"]),
        updateRemarks: json["UpdateRemarks"],
      );

  Map<String, dynamic> toJson() => {
        "AssetID": assetId,
        "FinancialYearID": financialYearId,
        "FinancialYear": financialYear,
        "LocationID": locationId,
        "LocationName": locationName,
        "SubLocationID": subLocationId,
        "SubLocationName": subLocationName,
        "AssetCategoryID": assetCategoryId,
        "AssetCategoryName": assetCategoryName,
        "AssetSubCategoryID": assetSubCategoryId,
        "AssetSubcategoryName": assetSubcategoryName,
        "TaggingID": taggingId,
        "PhysicalVerificationID": physicalVerificationId,
        "LocationCodeERP": locationCodeErp,
        "LocationNameERP": locationNameErp,
        "SubLocationCodeERP": subLocationCodeErp,
        "SubLocationNameERP": subLocationNameErp,
        "Department": department,
        "Custodian": custodian,
        "AssetCode": assetCode,
        "SerialNumber": serialNumber,
        "AssetNumber": assetNumber,
        "AssetNumberOld": assetNumberOld,
        "AssetName": assetName,
        "AssetMake": assetMake,
        "AssetModel": assetModel,
        "AssetDescription": assetDescription,
        "UsefulLife": usefulLife,
        "AssetConditionID": assetConditionId,
        "AssetCondition": assetCondition,
        "IsInUse": isInUse,
        "Quantity": quantity,
        "CapitalizationDate": capitalizationDate!.toIso8601String(),
        "AcquisitionDate": acquisitionDate!.toIso8601String(),
        "OpeningGrossValue": openingGrossValue,
        "AcquisitionValue": acquisitionValue,
        "WriteOffValue": writeOffValue,
        "ClosingGrossValue": closingGrossValue,
        "OpeningAccumulatedDepreciation": openingAccumulatedDepreciation,
        "CurrentYearDepreciation": currentYearDepreciation,
        "ClosingAccumulatedDepreciation": closingAccumulatedDepreciation,
        "OpeningWDV": openingWdv,
        "ClosingWDV": closingWdv,
        "DepreciationKey": depreciationKey,
        "DepreciationStartDate": depreciationStartDate!.toIso8601String(),
        "CumulitiveAcquisitionValue": cumulitiveAcquisitionValue,
        "TransactionAcquisitionValue": transactionAcquisitionValue,
        "PlannedDepreciationValue": plannedDepreciationValue,
        "Plant": plant,
        "Vendor": vendor,
        "WriteUpValue": writeUpValue,
        "TransactionAccumulatedDepreciation":
            transactionAccumulatedDepreciation,
        "EvaluationGroup": evaluationGroup,
        "BusinessArea": businessArea,
        "SanitizationAssetTypeID": sanitizationAssetTypeId,
        "SanitizationAssetTypeName": sanitizationAssetTypeName,
        "SanitizationAssetName": sanitizationAssetName,
        "SanitizationCostChecked": sanitizationCostChecked,
        "SanitizationAssetSurfaceID": sanitizationAssetSurfaceId,
        "SanitizationAssetSurfaceName": sanitizationAssetSurfaceName,
        "SanitizationTagTypeID": sanitizationTagTypeId,
        "SanitizationTagTypeName": sanitizationTagTypeName,
        "SanitizationTempTagNo": sanitizationTempTagNo,
        "SpocName": spocName,
        "Remarks1": remarks1,
        "Remarks2": remarks2,
        "CreatedBy": createdBy,
        "CreatedByName": createdByName,
        "AssignedID": assignedId,
        "AssignedName": assignedName,
        "CreateDate": createDate!.toIso8601String(),
        "UpdateBy": updateBy,
        "UpdateByName": updateByName,
        "UpdateDate": updateDate!.toIso8601String(),
        "UpdateRemarks": updateRemarks,
      };
}

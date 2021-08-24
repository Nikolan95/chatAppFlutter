class CarModel {
  int id;
  int userId;
  String firstRegistration;
  String vehicleIdentificationNumber;
  String manufacturerAndBrand;
  String licenseNumber;
  String holderName;
  String holderCity;
  String holderPostcode;
  String holderStreet;
  String ownerName;
  String createdAt;
  String updatedAt;

  CarModel(
      {this.id,
      this.userId,
      this.firstRegistration,
      this.vehicleIdentificationNumber,
      this.manufacturerAndBrand,
      this.licenseNumber,
      this.holderName,
      this.holderCity,
      this.holderPostcode,
      this.holderStreet,
      this.ownerName,
      this.createdAt,
      this.updatedAt});

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstRegistration = json['first_registration'];
    vehicleIdentificationNumber = json['vehicle_identification_number'];
    manufacturerAndBrand = json['manufacturer_and_brand'];
    licenseNumber = json['license_number'];
    holderName = json['holder_name'];
    holderCity = json['holder_city'];
    holderPostcode = json['holder_postcode'];
    holderStreet = json['holder_street'];
    ownerName = json['owner_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['first_registration'] = this.firstRegistration;
    data['vehicle_identification_number'] = this.vehicleIdentificationNumber;
    data['manufacturer_and_brand'] = this.manufacturerAndBrand;
    data['license_number'] = this.licenseNumber;
    data['holder_name'] = this.holderName;
    data['holder_city'] = this.holderCity;
    data['holder_postcode'] = this.holderPostcode;
    data['holder_street'] = this.holderStreet;
    data['owner_name'] = this.ownerName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class AddressModel {
  int? placeId;
  String? licence;
  String? osmType;
  int? osmId;
  List<String>? boundingbox;
  String? lat;
  String? lon;
  String? displayName;
  int? placeRank;
  String? category;
  String? type;
  double? importance;
  Address? address;

  AddressModel(
      {this.placeId,
      this.licence,
      this.osmType,
      this.osmId,
      this.boundingbox,
      this.lat,
      this.lon,
      this.displayName,
      this.placeRank,
      this.category,
      this.type,
      this.importance,
      this.address});

  AddressModel.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    licence = json['licence'];
    osmType = json['osm_type'];
    osmId = json['osm_id'];
    boundingbox = json['boundingbox'].cast<String>();
    lat = json['lat'];
    lon = json['lon'];
    displayName = json['display_name'];
    placeRank = json['place_rank'];
    category = json['category'];
    type = json['type'];
    importance = double.tryParse(json['importance'].toString());
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
  }
}

class Address {
  String? office;
  String? houseNumber;
  String? road;
  String? cityDistrict;
  String? city;
  String? iSO31662Lvl4;
  String? postcode;
  String? country;
  String? countryCode;

  Address(
      {this.office,
      this.houseNumber,
      this.road,
      this.cityDistrict,
      this.city,
      this.iSO31662Lvl4,
      this.postcode,
      this.country,
      this.countryCode});

  Address.fromJson(Map<String, dynamic> json) {
    office = json['office'];
    houseNumber = json['house_number'];
    road = json['road'];
    cityDistrict = json['city_district'];
    city = json['city'];
    iSO31662Lvl4 = json['ISO3166-2-lvl4'];
    postcode = json['postcode'];
    country = json['country'];
    countryCode = json['country_code'];
  }
}

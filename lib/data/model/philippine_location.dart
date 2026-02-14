
class PHLocation {
  int? id;
  String? region;
  String? province;
  String? city_municipality;
  String? barangay;

  PHLocation({
    this.id,
    this.region,
    this.province,
    this.city_municipality,
    this.barangay,
  });

  // Create a PHLocation object from JSON data
  factory PHLocation.fromJson(Map<String, dynamic> json) {
    return PHLocation(
      id: json['id'] ?? 0,
      region: json['region'] ?? '',
      province: json['province'] ?? '',
      city_municipality: json['city_municipality'] ?? json['municipality'] ?? '',
      barangay: json['barangay_capital'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'region': region,
      'province': province,
      'city_municipality': city_municipality,
      'barangay_capital': barangay,
    };
  }

  @override
  String toString() {
    return 'PHLocation{id: $id, region: $region, province: $province, city_municipality: $city_municipality, barangay: $barangay,}';
  }
}

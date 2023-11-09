class DeviceInfoCustom {
  final String? deviceId;
  final String? model;
  final String? brand;
  final String? version;
  final String? display;

  DeviceInfoCustom({
    this.deviceId,
    this.model,
    this.brand,
    this.version,
    this.display,
  });

   Map<String, dynamic> toJson() => {
        "model": model,
        "brand": brand,
        "version": version,
        "display": display,
      };
  
}

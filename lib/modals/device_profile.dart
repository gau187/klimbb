class DeviceProfile {
  String themeColor;
  String textSize;

  DeviceProfile(this.themeColor, this.textSize);

  DeviceProfile.fromMap(Map<String, dynamic> res)
      : themeColor = res["themeColor"],
        textSize = res["textSize"];

  Map<String, Object?> toMap() {
    return {
      'themeColor': themeColor,
      'textSize': textSize,
    };
  }
}

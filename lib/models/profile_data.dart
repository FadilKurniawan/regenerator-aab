class ProfileData {
  String? name;
  String? pubspecPath;
  String? bundlePath;
  String? aabPath;
  String? outputName;
  String? keyPath;
  String? keyAlias;
  String? keyPass;

  ProfileData(
      {this.name,
      this.pubspecPath,
      this.bundlePath,
      this.aabPath,
      this.outputName,
      this.keyPath,
      this.keyAlias,
      this.keyPass});

  ProfileData.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.pubspecPath = json['pubspecPath'];
    this.bundlePath = json['bundlePath'];
    this.aabPath = json['aabPath'];
    this.outputName = json['outputName'];
    this.keyPath = json['keyPath'];
    this.keyAlias = json['keyAlias'];
    this.keyPass = json['keyPass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['pubspecPath'] = this.pubspecPath;
    data['bundlePath'] = this.bundlePath;
    data['aabPath'] = this.aabPath;
    data['outputName'] = this.outputName;
    data['keyPath'] = this.keyPath;
    data['keyAlias'] = this.keyAlias;
    data['keyPass'] = this.keyPass;
    return data;
  }
}

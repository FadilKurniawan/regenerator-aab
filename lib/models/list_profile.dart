class ProfielList {
  List<String> list;

  ProfielList({required this.list});

  factory ProfielList.fromJson(Map<String, dynamic> json) => ProfielList(
        list: List<String>.from(json["list"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "list": list,
      };
}

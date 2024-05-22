class ProjectData {
  final String projectName;
  final int value;

  ProjectData({required this.projectName, required this.value});

  factory ProjectData.fromJson(Map<String, dynamic> json) {
    return ProjectData(
      projectName: json['projectName'],
      value: json['value'],
    );
  }
}

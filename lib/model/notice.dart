class Notice {
  final List<String> announcements;

  Notice({required this.announcements});

  factory Notice.fromJson(Map<String, dynamic> json) {
    var list = json['announcements'] as List;
    List<String> announcementsList = list.map((i) => i as String).toList();
    return Notice(announcements: announcementsList);
  }
}

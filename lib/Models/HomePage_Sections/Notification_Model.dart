class NotificationResponse {
  final int status;
  final String msg;
  final List<Notification> notifications;
  final int count;

  NotificationResponse({
    required this.status,
    required this.msg,
    required this.notifications,
    required this.count,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> notificationsList = json['notifications'];
    final List<Notification> notifications = notificationsList
        .map((notification) => Notification.fromJson(notification))
        .toList();

    return NotificationResponse(
      status: json['status'],
      msg: json['msg'],
      notifications: notifications,
      count: json['count'],
    );
  }
}

class Notification {
  final int id;
  final int userId;
  final String header;
  final String detail;
  final String expiresOn;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;

  Notification({
    required this.id,
    required this.userId,
    required this.header,
    required this.detail,
    required this.expiresOn,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      userId: json['user_id'],
      header: json['header'],
      detail: json['detail'],
      expiresOn: json['expires_on'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }
}

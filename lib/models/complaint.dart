class ComplaintModel {
  late String title, content, userId;
  late bool isComplaint;

  
  ComplaintModel();
  ComplaintModel.fromMap(map) {
    if (map == null) {
      return;
    }
    title = map['title'];
    content = map['content'];
    userId = map['user_id'];
    isComplaint = map['is_complaint'];
  }
  toMap() {
    return {
      'title': title,
      'content': content,
      'user_id': userId,
      'is_complaint': isComplaint,
    };
  }
}

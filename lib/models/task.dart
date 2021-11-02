class Task {
  int id;
  String row;
  int seqNum;
  String text;

  Task({this.id, this.row, this.seqNum, this.text});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    row = json['row'];
    seqNum = json['seq_num'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['row'] = this.row;
    data['seq_num'] = this.seqNum;
    data['text'] = this.text;
    return data;
  }
}
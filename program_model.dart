class ProgramModel {
  final String id;
  final String name;
  final String startDate;
  final String endDate;

  ProgramModel({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
  });

  static ProgramModel empty = ProgramModel(
    id: '',
    name: '',
    startDate: '',
    endDate: '',
  );

  factory ProgramModel.fromJson(Map<String, dynamic> json) {
    return ProgramModel(
      id: json['id'].toString(),
      name: json['name'],
      startDate: json['start_date'].toString().split('T')[0],
      endDate: json['end_date'].toString().split('T')[0],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'start_date': startDate,
        'end_date': endDate,
      };
  @override
  String toString() {
    return 'ProgramModel{id: $id, name: $name, startDate: $startDate, endDate: $endDate}';
  }
}

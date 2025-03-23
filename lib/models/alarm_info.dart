class AlarmInfo {
  DateTime alarmDateTime;
  String? description; // Make description nullable
  bool isActive; // Non-nullable boolean

  // Initialize isActive in the constructor
  AlarmInfo(this.alarmDateTime, {this.description, this.isActive = true});
}
class BpItem {
  DateTime date = DateTime.now();
  int? diastolic;
  int? systolic;

  BpItem(this.systolic, this.diastolic, {DateTime? date}) {
    if (date != null) {
      this.date = date;
    }
  }
}

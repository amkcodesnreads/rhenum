class bpItem {
  DateTime date = DateTime.now();
  int? diastolic;
  int? systolic;

  bpItem(this.systolic, this.diastolic, {DateTime? date}) {
    if (date != null) {
      this.date = date;
    }
  }
}

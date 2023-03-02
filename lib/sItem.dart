class SItem {
  DateTime date = DateTime.now();
  int? sugar;

  SItem(this.sugar, {DateTime? date}) {
    if (date != null) {
      this.date = date;
    }
  }
}

String formatDate(DateTime? date) {
  if (date != null) {
    return "${date!.day}/${date!.month}/${date!.year}";
  }

  return "";
}
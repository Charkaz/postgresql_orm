class Column {
  late String name;
  late String type;
  late bool primaryKey;
  late bool unique;
  late bool isNull;
  late bool isSerial;
  late bool foreignKey;
  late String referencesTable;

  Column({
    required this.name,
    required this.type,
    this.primaryKey = false,
    this.unique = false,
    this.isNull = false,
    this.isSerial = false,
    this.foreignKey = false,
    this.referencesTable = "",
  });
}

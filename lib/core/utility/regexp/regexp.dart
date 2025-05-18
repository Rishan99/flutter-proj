class ExpressionPatterns {
  //Regular Exp for floating value with onle Two digit after decimal
  final RegExp doubleRegExp = RegExp(r'^\d+(\.\d{0,2})?$');
}

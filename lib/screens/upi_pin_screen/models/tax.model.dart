class TaxDropdownItem {
  final String name;
  final String price;

  TaxDropdownItem(this.name, this.price);

  @override
  int get hashCode => name.hashCode ^ price.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TaxDropdownItem && runtimeType == other.runtimeType && name == other.name && price == other.price;
}

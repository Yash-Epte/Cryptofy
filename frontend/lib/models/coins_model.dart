// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Coins {
  String id;
  String name;
  String symbol;
  Coins({
    required this.id,
    required this.name,
    required this.symbol,
  });

  Coins copyWith({
    String? id,
    String? name,
    String? symbol,
  }) {
    return Coins(
      id: id ?? this.id,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'symbol': symbol,
    };
  }

  factory Coins.fromMap(Map<String, dynamic> map) {
    return Coins(
      id: map['id'] as String,
      name: map['name'] as String,
      symbol: map['symbol'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Coins.fromJson(String source) => Coins.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Coins(id: $id, name: $name, symbol: $symbol)';

  @override
  bool operator ==(covariant Coins other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.symbol == symbol;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ symbol.hashCode;
}

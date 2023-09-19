import 'package:hive/hive.dart';
import '../models/coin.dart';

class CoinHiveAdapter extends TypeAdapter<Coin> {
  @override
  final typeId = 0;

  @override
  Coin read(BinaryReader reader) {
    return Coin(
      icon: reader.readString(),
      name: reader.readString(),
      acronym: reader.readString(),
      price: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, Coin obj){
    writer.writeString(obj.icon);
    writer.writeString(obj.name);
    writer.writeString(obj.acronym);
    writer.writeDouble(obj.price);

  }
}

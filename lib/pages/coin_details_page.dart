import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:urubu_do_pix/models/coin.dart';

class CoinDetails extends StatefulWidget {
  final Coin coin;
  const CoinDetails({super.key, required this.coin});

  @override
  State<CoinDetails> createState() => _CoinDetailsState();
}

class _CoinDetailsState extends State<CoinDetails> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  final _form = GlobalKey<FormState>();
  final _value = TextEditingController();
  double quantity = 0;

  buy(){
    print('burron');
    if(_form.currentState!.validate()){
      //save buy

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(
          'Successful purchase',
        ))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coin.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            //Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    child: Image.asset(widget.coin.icon),
                  ),
                  Container(
                    width: 10,
                  ),
                  Text(
                    real.format(widget.coin.price),
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: Colors.grey[800],
                    ),
                  )
                ],
              ),
            ),

            (quantity > 0)
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 24,
                      ),
                      padding: const EdgeInsets.all(12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(.05),
                      ),
                      child: Text(
                        '$quantity ${widget.coin.acronym}',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.teal),
                      ),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(bottom: 24),
                  ),
            Form(
                key: _form,
                child: TextFormField(
                  controller: _value,
                  style: const TextStyle(fontSize: 22),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Value',
                    prefixIcon: Icon(
                      Icons.monetization_on_outlined,
                      color: Colors.black87,
                    ),
                    suffix: Text(
                      'reais',
                      style: TextStyle(fontSize: 14),
                    ),
                    labelStyle: TextStyle(color: Colors.black87),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black87), // Cor da borda quando focado
                    ), // Cor do rótulo
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'inform the value';
                    } else if (double.parse(value) < 50) {
                      return 'minimum purchase is R\$ 50,00';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      quantity = (value.isEmpty)
                          ? 0
                          : double.parse(value) / widget.coin.price;
                    });
                  },
                )),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: () {
                  buy();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.check),
                    Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Buy',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

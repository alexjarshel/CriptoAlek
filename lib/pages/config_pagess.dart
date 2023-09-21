import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:urubu_do_pix/configs/app_setings.dart';
import 'package:urubu_do_pix/repositories/account_repoitory.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPage();
}

class _ConfigurationPage extends State<ConfigurationPage> {
  @override
  Widget build(BuildContext context) {
    final account = context.watch<AccountRepository>();
    final loc = context.read<AppSettings>().locale;

    NumberFormat real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Configurations'),
      ),
      body: Padding(padding: EdgeInsets.all(12), child: Column(
        children: [
          ListTile(
            title: Text('Balance'),
            subtitle: Text(
              real.format(account.saldo),
              style: TextStyle(
                fontSize: 25,color: Colors.black
              ),
            ),
            trailing: IconButton(onPressed: updateBalance, icon: Icon(Icons.edit),),
          ),
          Divider(),
        ],
      ),),
    );
  }

  updateBalance() async{

    final form = GlobalKey<FormState>();
    final value = TextEditingController();
    final account = context.read<AccountRepository>();

    value.text = account.saldo.toString();

    AlertDialog dialog = AlertDialog(
      title: Text('update balance'),
      content: Form(
        key: form,
        child: TextFormField(
          controller: value,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
          ],
          validator: (value){
            if(value!.isEmpty) return 'inform the balance value';
            return null;
          },
        ),
      ),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: Text('cancel')),
      TextButton(onPressed: (){
        if(form.currentState!.validate()){
          account.setSaldo(double.parse(value.text));
          Navigator.pop(context);
        }
      }, child: Text('Save'))
    ],
    );

    showDialog(context: context, builder: (context) => dialog);

  }
}
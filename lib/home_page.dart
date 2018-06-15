import 'package:flutter/material.dart';
import 'package:validate/validate.dart';

class GreenbookHomePage extends StatefulWidget {
  @override
  _GreenbookHomePageState createState() => new _GreenbookHomePageState();
}

class _FormData {
  TextEditingController tic = new TextEditingController();
  String peso = '';
  String taxa_hidrica = '';
  String nacl = '';
  String gluca = '';
  String kcl = '';

  String result_g_de_glic = '';
  String result_taxa_hidrica = '';
  String result_nacl = '';
  String result_gluca = '';
  String result_kcl = '';
  String result_volume_compor_tig = '';
  String result_percent_composicao_soro = '';
  String result_sg_10 = '';
  String result_sg_10_2 = '';

}

class _GreenbookHomePageState extends State<GreenbookHomePage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _FormData _data = new _FormData();

  String _validateValue(String value) {
    const VALIDATION_MESSAGE = 'Por favor digite um valor';
    try {
      Validate.notBlank(value);
      if(!(double.parse(value) > 0)) return VALIDATION_MESSAGE;
    } catch (e) {
      return VALIDATION_MESSAGE;
    }

    return null;
  }

  void submit() {
    print('submit.');
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.
      var tic = double.parse(_data.tic.toString());
      var peso = double.parse(_data.peso);
      var taxa_hidrica = double.parse(_data.taxa_hidrica);
      var nacl = double.parse(_data.nacl);
      var gluca = double.parse(_data.gluca);
      var kcl = double.parse(_data.kcl);
      setState(() {
        var result_g_de_glic = tic*peso*1.4;
        _data.result_g_de_glic = (result_g_de_glic).toString();
        var result_taxa_hidrica = peso*taxa_hidrica;
        _data.result_taxa_hidrica = (result_taxa_hidrica).toString();
        var result_nacl = peso*nacl/3.4;
        _data.result_nacl = (result_nacl).toString();
        var result_gluca = peso*gluca;
        _data.result_gluca = (result_gluca).toString();
        var result_kcl = peso*kcl/1.3;
        _data.result_kcl = (result_kcl).toString();
        var result_volume_compor_tig = (peso*taxa_hidrica)-(result_nacl+result_gluca+result_kcl);
        _data.result_volume_compor_tig = (result_volume_compor_tig).toString();
        var result_percent_composicao_soro = (result_g_de_glic*100)/result_volume_compor_tig;
        _data.result_percent_composicao_soro = (result_percent_composicao_soro).toString();
        var result_sg_10 = (result_percent_composicao_soro>10) ? ((50-result_percent_composicao_soro)*result_volume_compor_tig/40) : 0;
        _data.result_sg_10 = result_sg_10.toString();
//        var result_sg_10_2 = (result_percent_composicao_soro>5&&result_percent_composicao_soro<10) ? ((50-result_percent_composicao_soro)*result_volume_compor_tig/40) : 0;
//        _data.result_sg_10_2 = result_sg_10_2.toString();
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Greenbook'),
      ),
      body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            key: this._formKey,
            child: new ListView(
              children: <Widget>[
                new ListTile(
                  title: new TextFormField(
                      keyboardType: TextInputType.number, // Use email input type for emails.
                      decoration: new InputDecoration(
                        labelText: 'TIC (mcg/kg/min)',
                        hintText: '3 mcg/kg/min',
                      ),
                      controller: this._data.tic,
//                      onSaved: (String value) {
//                        this._data.tic = value;
//                      },
                      validator: this._validateValue,
                  ),
                ),
                new ListTile(
                  title: new TextFormField(
                      keyboardType: TextInputType.number, // Use email input type for emails.
                      decoration: new InputDecoration(
                        labelText: 'Peso (kg)',
                        hintText: '5 kg',
                      ),
                      onSaved: (String value) {
                        this._data.peso = value;
                      },
                      validator: this._validateValue,
                  ),
                ),
                new ListTile(
                  title: const Text('g de glic'),
                  subtitle: new Text('${_data.result_g_de_glic} g')
                ),
                new ListTile(
                  title: new TextFormField(
                    keyboardType: TextInputType.number, // Use email input type for emails.
                    decoration: new InputDecoration(
                      labelText: 'Taxa hídrica',
                      hintText: '50',
                    ),
                    onSaved: (String value) {
                      this._data.taxa_hidrica = value;
                    },
                    validator: this._validateValue,
                  ),
                ),
                new ListTile(
                    title: const Text('Taxa Hidrica'),
                    subtitle: new Text('${_data.result_taxa_hidrica}')
                ),
                new ListTile(
                  title: new TextFormField(
                    keyboardType: TextInputType.number, // Use email input type for emails.
                    decoration: new InputDecoration(
                      labelText: 'Nacl 20% (meq/kg)',
                      hintText: '2',
                    ),
                    onSaved: (String value) {
                      this._data.nacl = value;
                    },
                    validator: this._validateValue,
                  ),
                ),
                new ListTile(
                    title: const Text('Nacl 20% (meq/kg)'),
                    subtitle: new Text('${_data.result_nacl} ml')
                ),
                new ListTile(
                  title: new TextFormField(
                    keyboardType: TextInputType.number, // Use email input type for emails.
                    decoration: new InputDecoration(
                      labelText: 'GluCa 10% (ml/kg)',
                      hintText: '2',
                    ),
                    onSaved: (String value) {
                      this._data.gluca = value;
                    },
                    validator: this._validateValue,
                  ),
                ),
                new ListTile(
                    title: const Text('GluCa 10% (ml/kg)'),
                    subtitle: new Text('${_data.result_gluca} ml')
                ),
                new ListTile(
                  title: new TextFormField(
                    keyboardType: TextInputType.number, // Use email input type for emails.
                    decoration: new InputDecoration(
                      labelText: 'kcl 10% (meq/kg)',
                      hintText: '2',
                    ),
                    onSaved: (String value) {
                      this._data.kcl = value;
                    },
                    validator: this._validateValue,
                  ),
                ),
                new ListTile(
                    title: const Text('kcl 10% (meq/kg)'),
                    subtitle: new Text('${_data.result_kcl} ml')
                ),
                new ListTile(
                    title: const Text('volume p/ compor TIG'),
                    subtitle: new Text('${_data.result_volume_compor_tig} ml')
                ),
                new ListTile(
                    title: const Text('% p/ composição do soro'),
                    subtitle: new Text('${_data.result_percent_composicao_soro} %')
                ),
                new ListTile(
                    title: const Text('SG 10%'),
                    subtitle: new Text('${_data.result_sg_10} ml')
                ),
                new ListTile(
                    title: const Text('SG 10%'),
                    subtitle: new Text('${_data.result_sg_10_2} ml')
                ),
                new Container(
                  width: screenSize.width,
                  child: new RaisedButton(
                    child: new Text(
                      'Calcular',
                      style: new TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: () => this.submit(),
                    color: Colors.green,
                  ),
                  margin: new EdgeInsets.only(
                      top: 20.0
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
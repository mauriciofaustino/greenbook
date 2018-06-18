import 'package:flutter/material.dart';
import 'package:greenbook/DoubleEditingController.dart';
import 'package:validate/validate.dart';

class GreenbookHomePage extends StatefulWidget {
  @override
  _GreenbookHomePageState createState() => new _GreenbookHomePageState();
}

class _FormData {
  DoubleEditingController tic = new DoubleEditingController();
  DoubleEditingController peso = new DoubleEditingController();
  DoubleEditingController taxa_hidrica = new DoubleEditingController();
  DoubleEditingController nacl = new DoubleEditingController();
  DoubleEditingController gluca = new DoubleEditingController();
  DoubleEditingController kcl = new DoubleEditingController();
}

class _CalculationResult {
  String result_g_de_glic='';
  String result_taxa_hidrica='';
  String result_nacl='';
  String result_gluca='';
  String result_kcl='';
  String result_volume_compor_tig='';
  String result_percent_composicao_soro='';
  String result_sg_10='';
  String result_sg_10_2='';
  String result_sg_5='';
  String result_sg_5_2='';
  String result_ad='';
  String result_sg_50='';
  String result_gotejamento='';

}

class _GreenbookCalculator {
  final _result = new _CalculationResult();

  _CalculationResult calculate(_FormData formData) {
    var result_g_de_glic = formData.tic.doubleValue*formData.peso.doubleValue*1.44;
    var result_taxa_hidrica = formData.peso.doubleValue*formData.taxa_hidrica.doubleValue;
    var result_nacl = formData.peso.doubleValue*formData.nacl.doubleValue/3.4;
    var result_gluca = formData.peso.doubleValue*formData.gluca.doubleValue;
    var result_kcl = formData.peso.doubleValue*formData.kcl.doubleValue/1.3;
    var result_volume_compor_tig = (formData.peso.doubleValue*formData.taxa_hidrica.doubleValue)-(result_nacl+result_gluca+result_kcl);
    var result_percent_composicao_soro = (result_g_de_glic*100)/result_volume_compor_tig;
    var result_sg_10 = (result_percent_composicao_soro>10) ? ((50-result_percent_composicao_soro)*result_volume_compor_tig/40) : 0;
    var result_sg_5 = (result_percent_composicao_soro>5&&result_percent_composicao_soro<10) ? (10-result_percent_composicao_soro)*result_volume_compor_tig/5 : 0;
    var result_sg_10_2 = (result_percent_composicao_soro>5&&result_percent_composicao_soro<10) ? result_volume_compor_tig-result_sg_5 : 0;
    var result_sg_5_2 = (result_percent_composicao_soro<5) ? result_volume_compor_tig-result_sg_10_2 : 0;
    var result_ad = (result_percent_composicao_soro<5) ? 5-result_percent_composicao_soro*result_volume_compor_tig/5 : 0;
    var result_50 = (result_percent_composicao_soro>10) ? (result_percent_composicao_soro-10)*result_volume_compor_tig/40 : 0;
    var result_gotejamento = result_taxa_hidrica/24;

    _result.result_g_de_glic=result_g_de_glic.toString();
    _result.result_taxa_hidrica=result_taxa_hidrica.toString();
    _result.result_nacl=result_nacl.toString();
    _result.result_gluca=result_gluca.toString();
    _result.result_kcl=result_kcl.toString();
    _result.result_volume_compor_tig=result_volume_compor_tig.toString();
    _result.result_percent_composicao_soro=result_percent_composicao_soro.toString();
    _result.result_sg_10=result_sg_10.toString();
    _result.result_sg_10_2=result_sg_10_2.toString();
    _result.result_sg_5=result_sg_5.toString();
    _result.result_sg_5_2=result_sg_5_2.toString();
    _result.result_ad=result_ad.toString();
    _result.result_sg_50=result_50.toString();
    _result.result_gotejamento=result_gotejamento.toString();
    return _result;
  }
}

class _GreenbookHomePageState extends State<GreenbookHomePage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _FormData _data = new _FormData();
  final _GreenbookCalculator _calculator = new _GreenbookCalculator();

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
    setState(() {
      _calculator.calculate(_data);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      keyboardType: TextInputType.number, 
                      decoration: new InputDecoration(
                        labelText: 'TIC (mcg/kg/min)',
                        hintText: '3 mcg/kg/min',
                      ),
                      controller: this._data.tic,
                      validator: this._validateValue,
                  ),
                ),
                new ListTile(
                  title: new TextFormField(
                      keyboardType: TextInputType.number, 
                      decoration: new InputDecoration(
                        labelText: 'Peso (kg)',
                        hintText: '5 kg',
                      ),
                      controller: this._data.peso,
                      validator: this._validateValue,
                  ),
                ),
                new ListTile(
                  title: new TextFormField(
                    keyboardType: TextInputType.number, 
                    decoration: new InputDecoration(
                      labelText: 'Taxa hídrica',
                      hintText: '50',
                    ),
                    controller: this._data.taxa_hidrica,
                    validator: this._validateValue,
                  ),
                ),
                new ListTile(
                  title: new TextFormField(
                    keyboardType: TextInputType.number, 
                    decoration: new InputDecoration(
                      labelText: 'Nacl 20% (meq/kg)',
                      hintText: '2',
                    ),
                    controller: this._data.nacl,
                    validator: this._validateValue,
                  ),
                ),
                new ListTile(
                  title: new TextFormField(
                    keyboardType: TextInputType.number, 
                    decoration: new InputDecoration(
                      labelText: 'GluCa 10% (ml/kg)',
                      hintText: '2',
                    ),
                    controller: this._data.gluca,
                    validator: this._validateValue,
                  ),
                ),
                new ListTile(
                  title: new TextFormField(
                    keyboardType: TextInputType.number, 
                    decoration: new InputDecoration(
                      labelText: 'kcl 10% (meq/kg)',
                      hintText: '2',
                    ),
                    controller: this._data.kcl,
                    validator: this._validateValue,
                  ),
                ),
                new ListTile(
                    title: const Text('g de glic'),
                    subtitle: new Text('${_calculator._result.result_g_de_glic} g')
                ),
                new ListTile(
                    title: const Text('Taxa Hidrica'),
                    subtitle: new Text('${_calculator._result.result_taxa_hidrica}')
                ),
                new ListTile(
                    title: const Text('Nacl 20% (meq/kg)'),
                    subtitle: new Text('${_calculator._result.result_nacl} ml')
                ),
                new ListTile(
                    title: const Text('GluCa 10% (ml/kg)'),
                    subtitle: new Text('${_calculator._result.result_gluca} ml')
                ),
                new ListTile(
                    title: const Text('kcl 10% (meq/kg)'),
                    subtitle: new Text('${_calculator._result.result_kcl} ml')
                ),
                new ListTile(
                    title: const Text('volume p/ compor TIG'),
                    subtitle: new Text('${_calculator._result.result_volume_compor_tig} ml')
                ),
                new ListTile(
                    title: const Text('% p/ composição do soro'),
                    subtitle: new Text('${_calculator._result.result_percent_composicao_soro} %')
                ),
                new ListTile(
                    title: const Text('SG 10%'),
                    subtitle: new Text('${_calculator._result.result_sg_10} ml')
                ),
                new ListTile(
                    title: const Text('SG 10%'),
                    subtitle: new Text('${_calculator._result.result_sg_10_2} ml')
                ),
                new ListTile(
                    title: const Text('SG5%'),
                    subtitle: new Text('${_calculator._result.result_sg_5} ml')
                ),
                new ListTile(
                    title: const Text('SG 5%'),
                    subtitle: new Text('${_calculator._result.result_sg_5_2} ml')
                ),
                new ListTile(
                    title: const Text('AD'),
                    subtitle: new Text('${_calculator._result.result_ad} ml')
                ),
                new ListTile(
                    title: const Text('SG 50%'),
                    subtitle: new Text('${_calculator._result.result_sg_50} ml')
                ),
                new ListTile(
                    title: const Text('Gotejamento'),
                    subtitle: new Text('${_calculator._result.result_gotejamento}')
                ),
              ],
            ),
          )
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          _formKey.currentState.save();
          if (this._formKey.currentState.validate()) {
//            Scaffold.of(context).showSnackBar(new SnackBar(
//              content: new Text("Calculando"),
//            ));
            this.submit();
          }
        },
        tooltip: 'Calcular',
        child: new Icon(Icons.done),
      ),
    );
  }
}
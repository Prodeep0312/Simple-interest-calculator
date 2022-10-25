import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SIMPLE INTEREST CALCULATOR APP',
    home: SI(),
    theme: ThemeData(
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

class SI extends StatefulWidget {
  const SI({Key? key}) : super(key: key);

  @override
  State<SI> createState() => _SIState();
}

class _SIState extends State<SI> {
  var _formkey=GlobalKey<FormState>();
  int principal = 0;
  var _currencies = ['Rupees', 'Dollar', 'Pounds'];
  var _currentItemSelected = 'Rupees';

  TextEditingController principalcontroller = TextEditingController();
  TextEditingController roicontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
        backgroundColor: Colors.indigo,
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 30.0),
                height: 100.0,
                width: 100.0,
                child: Image(
                    image: NetworkImage(
                        'https://github.com/smartherd/Flutter-Demos/blob/%233.5-section-three-video-five/images/money.png?raw=true')),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]+"))],
                style: TextStyle(
                  color: Colors.cyanAccent,
                ),
                validator: (value)
                { if(value == null || value.isEmpty)
                  {
                    return 'Please enter principal amount';

                  }


                    return null;
                },





                keyboardType: TextInputType.number,
                controller: principalcontroller,
                decoration: InputDecoration(
                    labelText: 'Principal',
                    hintText: 'Enter principal amount eg 9000',
                    errorStyle: TextStyle(
                      color: Colors.yellowAccent,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide:
                          BorderSide(width: 1, color: Colors.greenAccent),
                    )),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]+"))],
                style: TextStyle(
                  color: Colors.cyanAccent,
                ),
                validator: (value)
                { if(value == null || value.isEmpty)
                {
                  return 'Please enter rate';

                }



                return null;
                },
                keyboardType: TextInputType.number,
                controller: roicontroller,
                decoration: InputDecoration(
                    labelText: 'Rate',
                    hintText: 'Enter rate in percentage',
                    errorStyle: TextStyle(
                      color: Colors.yellowAccent,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide:
                          BorderSide(width: 1, color: Colors.yellowAccent),
                    )),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]+"))],

                      style: TextStyle(
                        color: Colors.cyanAccent,
                      ),
                      validator: (value)
                      { if(value == null || value.isEmpty)
                      {
                        return 'Please enter time';

                      }



                      return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: timecontroller,

                      decoration: InputDecoration(
                          labelText: 'Time',
                          hintText: 'Enter time in years',
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                          ),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),

                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide:
                                BorderSide(width: 1, color: Colors.redAccent),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    child: DropdownButton<String>(
                  items: _currencies.map((String Value) {
                    return DropdownMenuItem<String>(
                      value: Value,
                      child: Text(
                        Value,
                      ),
                    );
                  }).toList(),
                  value: _currentItemSelected,
                  onChanged: (String? newValueSelected) {
                    _onDropDownItemSelected(newValueSelected);
                  },
                )),
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    width: 200.0,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if(_formkey.currentState!.validate())
                              {
                                this.displayResult = _calculateTotalReturns();
                              }

                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurpleAccent,
                        ),
                        child: Text("Calculate")),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    width: 180.0,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),
                        child: Text("Reset")),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Text(
              displayResult,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onDropDownItemSelected(String? newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected.toString();
    });
  }

  String _calculateTotalReturns() {
    double p = double.parse(principalcontroller.text);
    double r = double.parse(roicontroller.text);
    double t = double.parse(timecontroller.text);
    double amount = p + (p * r * t) / 100;
    String result =
        'After $t years, your investment will be worth $amount $_currentItemSelected';
    return result;
  }

  void _reset() {
    principalcontroller.text = '';
    roicontroller.text = '';
    timecontroller.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}

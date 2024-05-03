import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: SimpleCalculator(),
      );
  }
}
class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String result ='0';
  String equation ='0';
  String expression ='';
  double EqFontsize= 38.0;
  double ResFontsize = 48.0;

  buttonpressed(String buttonText){
    setState(() {
        if(buttonText =='C'){
          equation='0';
          result ='0';
          EqFontsize= 38.0;
          ResFontsize = 48.0;
        }
        else if(buttonText == '⌫'){
          equation = equation.substring(0,equation.length-1);
          EqFontsize= 38.0;
          ResFontsize = 48.0;
          if(equation == ''){
            equation='0';
          }
        }
        else if(buttonText == '='){

          EqFontsize= 38.0;
          ResFontsize = 48.0;
          expression=equation;
          expression=expression.replaceAll('×', '*');
          expression=expression.replaceAll('÷', '/');
          try{
            Parser p = Parser();
            Expression exp = p.parse(expression);
            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          }
          catch(e){
            result='Error';
          }
        }
        else{
          EqFontsize= 38.0;
          ResFontsize = 48.0;
          if(equation=='0'){
            equation = buttonText;
          }
          else{
            equation=equation+buttonText;
          }
        }
    });
  }

  Widget buildbutton(String buttonText,double buttonheight,Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height*0.09*buttonheight,
      color: buttonColor,
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
            color: Colors.white,
            width: 1,
            style: BorderStyle.solid
          )
        ),
        backgroundColor: buttonColor,
        onPressed: (){
          buttonpressed(buttonText);
        },
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),



    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(title: Text('Simple Calculator',
        style:TextStyle(
          color: Colors.white,
          fontSize: 18.0,

        )
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: Column(
        children: [
          Expanded(child: Container(
            alignment: Alignment.centerRight,
            color: Colors.black26,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(equation,style: TextStyle(color: Colors.white,fontSize: EqFontsize),),
                  ),
                  Divider(height: 60.0,color: Colors.white24,),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(result,style: TextStyle(color: Colors.white,fontSize: ResFontsize)),
                  ),
                ],
              ),
            ),
          )),
          Expanded(child: Container(
            alignment: Alignment.center,
            color: Colors.grey[900],
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*1,
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              buildbutton('C', 1, Colors.red),
                              buildbutton('⌫', 1, Colors.blueAccent),
                              buildbutton('%', 1, Colors.blueAccent),
                              buildbutton('×', 1, Colors.blueAccent),
                            ]
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*1,
                      child: Table(
                        children: [
                          TableRow(
                              children: [
                                buildbutton('7', 1, Colors.black26),
                                buildbutton('8', 1, Colors.black26),
                                buildbutton('9', 1, Colors.black26),
                                buildbutton('÷', 1, Colors.blueAccent),
                              ]
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*1,
                      child: Table(
                        children: [
                          TableRow(
                              children: [
                                buildbutton('4', 1, Colors.black26),
                                buildbutton('5', 1, Colors.black26),
                                buildbutton('6', 1, Colors.black26),
                                buildbutton('-', 1, Colors.blueAccent),
                              ]
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*1,
                      child: Table(
                        children: [
                          TableRow(
                              children: [
                                buildbutton('1', 1, Colors.black26),
                                buildbutton('2', 1, Colors.black26),
                                buildbutton('3', 1, Colors.black26),
                                buildbutton('+', 1, Colors.blueAccent),
                              ]
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*1,
                      child: Table(
                        children: [
                          TableRow(
                              children: [
                                buildbutton('.', 1, Colors.black26),
                                buildbutton('0', 1, Colors.black26),
                                buildbutton('00', 1, Colors.black26),
                                buildbutton('=', 1, Colors.red),
                              ]
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ],
            ),

          ))
        ],
      ),
    );
  }
}



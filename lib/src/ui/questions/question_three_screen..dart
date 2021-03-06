import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'widgets/next_or_back_button.dart';
import 'widgets/pagination.dart';

class QuestionThreeScreen extends StatefulWidget {
  final VoidCallback onGoToBackQuestion;
  final VoidCallback onGoToNextQuestion;
  QuestionThreeScreen({
    Key key,
    @required this.onGoToBackQuestion,
    @required this.onGoToNextQuestion
  }) : super(key: key);
  @override
  _QuestionThreeScreenState createState() => _QuestionThreeScreenState();
}

class _QuestionThreeScreenState extends State<QuestionThreeScreen> {
  double _currentSliderValue = 3;

  Future<void> _showMyDialog(String content) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ayuda'),
          content: ListTile(
            title: Text(content),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        icon: Icon(Icons.help_outline_rounded),
                        onPressed: () {
                          _showMyDialog("Por favor ingresa la informacion real, por que esta sirve para establecer el punto de partida en el proceso de adquirir nuevos habitos.\nLa informacion solicitada es unicamente para realizar calculos necesarios para obtener indicadores como IMC y para establecer un punto de partida para los retos propuestos con la finalidad de ayudarte a adquirr un nuevo habito.");
                        }
                    )
                    //DialogHelp(context: this.context, content: "Por favor ingresa la informacion real, por que esta sirve para establecer el punto de partida en el proceso de adquirir nuevos habitos.\nLa informacion solicitada es unicamente para realizar calculos necesarios para obtener indicadores como IMC y para establecer un punto de partida para los retos propuestos con la finalidad de ayudarte a adquirr un nuevo habito.")
                  ],
                ),
                PaginationText(total: 6, actual: 4),
                Expanded(child: SizedBox(child: _content(),)),
                _questionsChangeButton(),
              ],
            ),
          )
        )
    );
  }

  Widget _questionsChangeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NextOrBackButton(
          inputFunction: widget.onGoToBackQuestion,
          icon: Icons.west,
        ),
        NextOrBackButton(
          inputFunction: widget.onGoToNextQuestion,
          icon: Icons.east,
        )
      ],
    );
  }

  Widget _content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: Image.asset("assets/images/tea.png", height: 150,),
        ),

        Text(
          _currentSliderValue.round().toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),
        ),

        RichText(
          text:
          TextSpan(style: TextStyle(fontSize: 20, color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: '¿Con cuantas ', style: TextStyle(fontWeight: FontWeight.normal)),
              TextSpan(text: 'cucharitas ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'endulzas tu taza?', style: TextStyle(fontWeight: FontWeight.normal)),
//              TextSpan(text: 'tomas al dia? ', style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
          textAlign: TextAlign.center,
        ),

        
        SfSlider(
          min: 0.0,
          max: 6.0,
          value: _currentSliderValue,
          interval: 1,
          showLabels: true,
          showTicks: true,
          showDivisors: true,
          enableTooltip: true,
          onChanged: (dynamic value) {
            setState(() {
              int val=value.toInt();
              _currentSliderValue = val.toDouble();
            });
          },
        ),


      ],
    );
  }

}

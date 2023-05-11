import 'package:flutter/material.dart';

class Pessoa {
  String nome;
  double peso;
  double altura;

  Pessoa({required this.nome, required this.peso, required this.altura});
}

class Calculo extends StatefulWidget {
  const Calculo({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Calculo> createState() => _CalculoState();
}

class _CalculoState extends State<Calculo> {
  Pessoa pessoa = Pessoa(nome: '', peso: 0, altura: 0);

  TextEditingController nomeController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  double imc = 0.0;


  @override
  void dispose() {
    nomeController.dispose();
    pesoController.dispose();
    alturaController.dispose();
    super.dispose();
  }

  void atualizarPessoa() {
    setState(() {
      pessoa.nome = nomeController.text;
      pessoa.peso = double.tryParse(pesoController.text) ?? 0.0;
      pessoa.altura = double.tryParse(alturaController.text) ?? 0.0;
    });
  }

  void calcular() {
    double alturaEmMetros = pessoa.altura / 100.0;
    imc = pessoa.peso / (alturaEmMetros * alturaEmMetros);
    verificarClassificacao();
  }

  String classificacao = '';
  void verificarClassificacao(){
    switch (imc) {
      case < 16:
        classificacao = 'Magreza grave';
        break;
         case > 16 && < 17 :
        classificacao = 'Magreza moderada';
        break;
        case > 17 && <  18.5 :
        classificacao = 'Magreza leve';
        break;
         case > 18.5 && <  25 :
        classificacao = 'Saudável';
        break;
         case > 25 && <  30 :
        classificacao = 'Sobrepeso';
        break;
         case > 30 && <  35 :
        classificacao = 'Obesidade grau I';
        break;
         case > 35 && <  40 :
        classificacao = 'Obesidade grau II (severa)';
        break;
         case >=40:
        classificacao = 'Obesidade grau III (mórbida)';
        break;
      default:
      classificacao = 'IMC não identificado';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left:20.0, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              TextField(
                controller: pesoController,
                decoration: const InputDecoration(
                  labelText: 'Peso',
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                controller: alturaController,
                decoration: const InputDecoration(
                  labelText: 'Altura',
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
             const  SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    atualizarPessoa();
                    calcular();
                  });
                },
                child: const Text('Atualizar'),
              ),
            const SizedBox(height: 16),
              Text('Nome: ${pessoa.nome}'),
              Text('Peso: ${pessoa.peso} Kg'),
              Text('Altura: ${pessoa.altura} Cm'),
              Text('IMC: ${imc.toStringAsFixed(1)}'),
              Text('Classificação: $classificacao'),
            ],
          ),
        ),
      ),
    );
  }
}


import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:word_cloud/word_cloud.dart';
import '/widgets/heat_word_map.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width / 3, // one third of the screen
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              DrawerHeader(child: Text('Drawer Header')),
              EscolherArquivo(),
              Expanded(
                  child: SizedBox(
                      child: ListView.builder(
                          itemCount: 50,
                          itemBuilder: (context, index) =>
                              ArquivoListado(index: index))))
            ],
          ),
        ),
      ),
      body: Center(child: HeatWordMap()),
    );
  }
}

class NuvemDePalavras extends StatefulWidget {
  const NuvemDePalavras({super.key});

  @override
  State<NuvemDePalavras> createState() => _NuvemDePalavrasState();
}

class _NuvemDePalavrasState extends State<NuvemDePalavras> {
  List<Map<dynamic, dynamic>> data = [];
  WordCloudData myData = WordCloudData(data: []);

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse('http://localhost:8000'));
    if (response.statusCode == 200) {
      final utf8String =
          utf8.decode(response.bodyBytes); // Decodifica corretamente
      setState(() {
        data = List<Map<String, dynamic>>.from(json.decode(utf8String));

        myData = WordCloudData(data: data);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WordCloudView(
      data: myData,
      mapwidth: 500,
      mapheight: 500,
      // mapcolor: Color.fromARGB(255, 174, 183, 235),
      colorlist: [
        Color(0xff008040),
        Color(0xffE4B004),
        Color(0xff80AE28),
        Color(0xff1480C0),
        Colors.black
      ],
      shape: WordCloudEllipse(majoraxis: 250, minoraxis: 200),
    );
  }
}

class EscolherArquivo extends StatefulWidget {
  const EscolherArquivo({
    super.key,
  });

  @override
  State<EscolherArquivo> createState() => _EscolherArquivoState();
}

class _EscolherArquivoState extends State<EscolherArquivo> {
  bool escolhendo = false;

  void escolherArquivo() async {
    if (escolhendo) return;
    escolhendo = true;

    final FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String arquivoCaminho = result.files.single.path!.toString();
      print(arquivoCaminho);
    } else {
      // TODO checar filetype .mp3 == true
      print('Caminho nada a ver');
    } // TODO Enviar o arquivo no respectivo path para a api o servidor intermediário

    escolhendo = false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Enviar novo áudio'),
        FilledButton(onPressed: escolherArquivo, child: Text('Enviar arquivo'))
      ],
    );
  }
}

class ArquivoListado extends StatelessWidget {
  const ArquivoListado({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text('Arquivo $index')],
    );
  }
}

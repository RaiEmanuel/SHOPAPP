import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:shoapp/routes/login/widget/WFormlogin.dart';
import 'package:shoapp/connection/Connection.dart';

class Category {
  late int id;
  late String name;

  Category({this.id = 1, this.name = "default"});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}


class RouteLogin extends StatelessWidget {
  const RouteLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: GestureDetector(
                onTap: (){
                  Connection.teste();
                },
                child: Text(
                  "Ecommerce",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            WFormLogin()
          ],
        ),
        decoration: BoxDecoration(color: Colors.grey[300]),
      ),
    );
  }
}
class Equipe {
  late int posicao;
  late int pontos;
  late Time time;
  late int jogos;
  late int vitorias;
  late int empates;
  late int derrotas;
  late int golsPro;
  late int golsContra;
  late int saldoGols;
  late double aproveitamento;
  late int variacaoPosicao;
  late List<String> ultimosJogos;

  Equipe(
      {required this.posicao,
        required this.pontos,
        required this.time,
        required this.jogos,
        required this.vitorias,
        required this.empates,
        required this.derrotas,
        required this.golsPro,
        required this.golsContra,
        required this.saldoGols,
        required this.aproveitamento,
        required this.variacaoPosicao,
        required this.ultimosJogos});

  Equipe.fromJson(Map<String, dynamic> json) {
    posicao = json['posicao'];
    pontos = json['pontos'];
    time = (json['time'] != null ? new Time.fromJson(json['time']) : null)!;
    jogos = json['jogos'];
    vitorias = json['vitorias'];
    empates = json['empates'];
    derrotas = json['derrotas'];
    golsPro = json['gols_pro'];
    golsContra = json['gols_contra'];
    saldoGols = json['saldo_gols'];
    aproveitamento = double.parse(json['aproveitamento'].toString());
    variacaoPosicao = json['variacao_posicao'];
    ultimosJogos = json['ultimos_jogos'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['posicao'] = this.posicao;
    data['pontos'] = this.pontos;
    if (this.time != null) {
      data['time'] = this.time.toJson();
    }
    data['jogos'] = this.jogos;
    data['vitorias'] = this.vitorias;
    data['empates'] = this.empates;
    data['derrotas'] = this.derrotas;
    data['gols_pro'] = this.golsPro;
    data['gols_contra'] = this.golsContra;
    data['saldo_gols'] = this.saldoGols;
    data['aproveitamento'] = this.aproveitamento;
    data['variacao_posicao'] = this.variacaoPosicao;
    data['ultimos_jogos'] = this.ultimosJogos;
    return data;
  }
}

class Time {
  late int timeId;
  late String nomePopular;
  late String sigla;
  late String escudo;

  Time({required this.timeId, required this.nomePopular, required this.sigla, required this.escudo});

  Time.fromJson(Map<String, dynamic> json) {
    timeId = json['time_id'];
    nomePopular = json['nome_popular'];
    sigla = json['sigla'];
    escudo = json['escudo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_id'] = this.timeId;
    data['nome_popular'] = this.nomePopular;
    data['sigla'] = this.sigla;
    data['escudo'] = this.escudo;
    return data;
  }
}

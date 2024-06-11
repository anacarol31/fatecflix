import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filmes Aplicativo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Lista de filmes
  List<Movie> movies = [
    Movie(
      title: 'Minha Mãe É Uma Peça O Filme',
      ano: 2013,
      genero: 'Comédia',
      imageUrl: 'assets/images/filme1.jpg',
      sinopse:'Minha Mãe é uma Peça é uma comédia brasileira que segue a história de Dona Hermínia, uma mãe solteira e engraçada que está enfrentando o desafio de criar seus filhos.',
      elenco: ['Paulo Gustavo', 'Rodrigo Pandolfo', 'Mariana Xavier', 'Samantha Schmütz'],
    ),
    Movie(
      title: 'A Cabana',
      ano: 2016,
      genero: 'Romance',
      imageUrl: 'assets/images/filme2.jpg',
      sinopse:'"A Cabana" é um filme sobre Mack, um homem devastado pela perda de sua filha, que recebe uma misteriosa carta de Deus, convidando-o a voltar ao local onde ela foi morta. Lá, ele encontra Deus, Jesus e o Espírito Santo, que o ajudam a enfrentar sua dor e encontrar redenção e cura espiritual.',
      elenco: ['Sam Worthington', 'Octavia Spencer', 'Tim McGraw'],
    ),
    Movie(
      title: 'Top Gun',
      ano: 2022,
      genero: 'Ação e Drama',
      imageUrl: 'assets/images/filme3.jpg',
      sinopse: '"Top Gun" segue o piloto Maverick na escola de elite da Marinha, onde compete para ser o melhor e enfrenta a perda de seu amigo Goose, enquanto se envolve com a instrutora Charlie.',
      elenco: ['Tom Cruise', 'Kelly McGillis', 'Val Kilmer'],
    ),
    Movie(
      title: 'Planeta dos Macacos, o Reinado',
      ano: 2024,
      genero: 'Ação, Aventura e Ficção Científica',
      imageUrl: 'assets/images/filme04.jpg',
      sinopse:'"Planeta dos Macacos: O Reinado" segue uma nova geração de macacos lutando para sobreviver e formar sociedades após o colapso da civilização humana.',
      elenco: ['Andy Serkis como César (macaco)', 'Woody Harrelson como Coronel McCullough (humano)', 'Amiah Miller como Nova (humano)'],
    ),
    Movie(
      title: 'Como eu era antes de você',
      ano: 2016,
      genero: 'Drama e Romance',
      imageUrl: 'assets/images/filme5.jpg',
      sinopse: '"Como Eu Era Antes de Você" conta a história de Lou, uma cuidadora que se apaixona por Will, um homem tetraplégico. Enquanto enfrentam desafios emocionais juntos, eles descobrem o poder do amor e da aceitação.',
      elenco: ['Emilia Clarke como Louisa Clark', 'Sam Claflin como Will Traynor', 'Janet McTeer como Camilla Traynor'],
    ),
  ];

  String? selectedGenero;

  // Nomes dos integrantes
  List<String> integrantes = [
    'Ana Caroline',
    'Matheus Conceição',
    'Nikoly Pereira',
  ];

  @override
  Widget build(BuildContext context) {
    List<Movie> filteredMovies = selectedGenero != null
        ? movies.where((movie) => movie.genero == selectedGenero).toList()
        : movies;

    return Scaffold(
      appBar: AppBar(
        title: Text('Filmes'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            hint: Text('Filtro'),
            value: selectedGenero,
            onChanged: (String? value) {
              setState(() {
                selectedGenero = value!;
              });
            },
            items: _getGeneros().map<DropdownMenuItem<String>>((genero) {
              return DropdownMenuItem<String>(
                value: genero,
                child: Text(genero),
              );
            }).toList(),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Duas colunas
                childAspectRatio: 0.9, // Proporção entre altura e largura
              ),
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsPage(movie: filteredMovies[index]),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                            child: Image.network(
                              filteredMovies[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                filteredMovies[index].title,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(filteredMovies[index].ano.toString()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Integrantes'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: integrantes.map((integrante) {
                        return Text(integrante,
                        style:TextStyle(fontWeight: FontWeight.bold));
                      }).toList(),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Fechar'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Integrantes'),
          ),
        ],
      ),
    );
  }

  List<String> _getGeneros() {
    Set<String> generos = movies.map((movie) => movie.genero).toSet();
    return List<String>.from(generos);
  }
}

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                movie.imageUrl,
                width: 300,///detalhes
                height: 420,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text('Ano: ${movie.ano}'),
              Text('Gênero: ${movie.genero}'),
              Text('Sinopse: ${movie.sinopse}'),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Elenco:'),
                  Expanded(
                    child: Text(
                      movie.elenco.join(','),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Movie {
  final String title;
  final int ano;
  final String genero;
  final String imageUrl;
  final String sinopse;
  final List<String> elenco;

  Movie({
    required this.title,
    required this.ano,
    required this.genero,
    required this.imageUrl,
    required this.sinopse,
    required this.elenco,
  });
}

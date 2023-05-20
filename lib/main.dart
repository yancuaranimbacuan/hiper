import 'package:flutter/material.dart';
import 'package:torch_controller/torch_controller.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter_radio_player/models/frp_source_modal.dart';

void main() {
  TorchController().initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Agrega esta línea
      title: 'Hiper App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: appitp(),
    );
  }
}

//_____________________________________Pagina principal appitp_____________________________________

Future<void> _showSimulatedSearchDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Estas seguro de salir'),
        content: Text('la aplicacion se cerrara'),
        actions: <Widget>[
          TextButton(
            child: Text('Aceptar'),
            onPressed: () {
              //Navigator.of(context).pop();
              SystemNavigator.pop();
            },
          ),
        ],
      );
    },
  );
}

class appitp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(242, 232, 247, 179),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/log.gif',
                          height: 70,
                        ),
                      ),
                      Text(
                        'Configuración',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Image.asset(
              //  "assets/logo.png",
              //  height: 40.0,
              //),
              //SizedBox(width: 10.0),
              Text(
                "Hiper App",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Icon(Icons.android),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10.0)),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 3,
        childAspectRatio:
            1.0, // Ajusta este valor para cambiar el tamaño de los botones
        mainAxisSpacing:
            10, // Ajusta este valor para cambiar el espacio vertical entre los botones
        crossAxisSpacing:
            10, // Ajusta este valor para cambiar el espacio horizontal entre los botones
        padding: const EdgeInsets.all(10),
        children: [
          createButton(context, 'assets/lin.png', Page1()),
          createButton(context, 'assets/cal.png', Page2()),
          createButton(context, 'assets/mus.png', Page3()),
          createButton(context, 'assets/radio.jpeg', NuevaPagina()),
          createButton(context, 'assets/logo.png', Page2()),
          createButton(context, 'assets/salir.png', Page2()),
          // Agrega más botones aquí
        ],
      ),
    );
  }

  Widget createButton(BuildContext context, String imagePath, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  var isActive = false;
  var controller = TorchController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Linterna'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/lin1.jpeg"), // Ruta de la imagen de fondo
            fit: BoxFit.cover, // Ajuste de la imagen al contenedor
          ),
        ),
        child: Center(
          child: CircleAvatar(
            minRadius: 26,
            maxRadius: 26,
            child: Transform.scale(
              scale: 1.5,
              child: IconButton(
                onPressed: () {
                  controller.toggle();
                  isActive = !isActive;
                },
                icon: const Icon(Icons.power_settings_new),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  double firstNumber = 0;
  double secondNumber = 0;
  double result = 0;
  final TextEditingController t1 = TextEditingController(text: "0");
  final TextEditingController t2 = TextEditingController(text: "0");

  void add() {
    setState(() {
      firstNumber = double.parse(t1.text);
      secondNumber = double.parse(t2.text);
      result = firstNumber + secondNumber;
    });
  }

  void subtract() {
    setState(() {
      firstNumber = double.parse(t1.text);
      secondNumber = double.parse(t2.text);
      result = firstNumber - secondNumber;
    });
  }

  void multiply() {
    setState(() {
      firstNumber = double.parse(t1.text);
      secondNumber = double.parse(t2.text);
      result = firstNumber * secondNumber;
    });
  }

  void divide() {
    setState(() {
      firstNumber = double.parse(t1.text);
      secondNumber = double.parse(t2.text);
      result = firstNumber / secondNumber;
    });
  }

  void clear() {
    setState(() {
      t1.text = "0";
      t2.text = "0";
      result = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Resultado: $result",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: t1,
              decoration: InputDecoration(hintText: 'Ingrese el primer número'),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: t2,
              decoration:
                  InputDecoration(hintText: 'Ingrese el segundo número'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(onPressed: add, child: Text('+')),
                ElevatedButton(onPressed: subtract, child: Text('-')),
                ElevatedButton(onPressed: multiply, child: Text('*')),
                ElevatedButton(onPressed: divide, child: Text('/')),
              ],
            ),
            SizedBox(height: 20.0), //Espacio entre botones (20 pixeles
            ElevatedButton(
                onPressed: clear, child: Text('Limpiar')), //Botón de limpiar
          ],
        ),
      ),
    );
  }
}

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  final AudioPlayer audioPlayer = AudioPlayer();
  List<SongInfo> songs = [];

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  void _requestPermissions() async {
    if (await Permission.storage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      getSongs();
    } else {
      // You can request again while the app is in use.
      if (await Permission.storage.isPermanentlyDenied) {
        // The user opted to never again see the permission request dialog for this
        // app. The only way to change the permission's status now is by
        // letting the user manually enable it in the system settings.
        openAppSettings();
      }
    }
  }

  void getSongs() async {
    songs = await audioQuery.getSongs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página 3'),
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(songs[index].title),
              subtitle: Text(songs[index].artist),
              //trailing: IconButton(
              //  icon: Icon(Icons.play_arrow),
              //  onPressed: () async {
              //    try {
              //      await audioPlayer.play(songs[index].filePath, isLocal: true);
              //      // La reproducción fue exitosa
              //    } catch (e) {
              //      print('Error playing audio: $e');
              //      // Hubo un error al reproducir el audio
              //}
              //},
              //),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.skip_previous),
                    onPressed: () async {
                      try {
                        if (index > 0) {
                          await audioPlayer.play(songs[index - 1].filePath,
                              isLocal: true);
                        }
                        // La reproducción de la canción anterior fue exitosa
                      } catch (e) {
                        print('Error playing previous song: $e');
                        // Hubo un error al reproducir la canción anterior
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.play_arrow),
                    onPressed: () async {
                      try {
                        await audioPlayer.play(songs[index].filePath,
                            isLocal: true);
                        // La reproducción fue exitosa
                      } catch (e) {
                        print('Error playing audio: $e');
                        // Hubo un error al reproducir el audio
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.pause),
                    onPressed: () async {
                      try {
                        await audioPlayer.pause();
                        // La pausa fue exitosa
                      } catch (e) {
                        print('Error pausing audio: $e');
                        // Hubo un error al pausar el audio
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.skip_next),
                    onPressed: () async {
                      try {
                        if (index < songs.length - 1) {
                          await audioPlayer.play(songs[index + 1].filePath,
                              isLocal: true);
                        }
                        // La reproducción de la siguiente canción fue exitosa
                      } catch (e) {
                        print('Error playing next song: $e');
                        // Hubo un error al reproducir la siguiente canción
                      }
                    },
                  ),
                ],
              ));
        },
      ),
    );
  }
}

//_____________________________________Pagina secundaria tienda android_____________________________________

class NuevaPagina extends StatefulWidget {
  @override
  _NuevaPaginaState createState() => _NuevaPaginaState();
}

class _NuevaPaginaState extends State<NuevaPagina> {
  final FlutterRadioPlayer _flutterRadioPlayer = FlutterRadioPlayer();
  int _currentStationIndex = 0;

  final FRPSource frpSource = FRPSource(
    mediaSources: <MediaSources>[
      MediaSources(
        url: "http://64.37.50.226:8042/stream/1/",
        description: "Station 1",
        isPrimary: true,
        title: "Station 1",
        isAac: true,
      ),
      MediaSources(
        url: "hhttps://stream2.305stream.com/proxy/client128?mp=/stream",
        description: "Station 2",
        isPrimary: false,
        title: "Station 2",
        isAac: false,
      ),
      MediaSources(
        url: "http://64.37.50.226:8042/;stream.nsv",
        description: "Station 2",
        isPrimary: false,
        title: "Station 3",
        isAac: false,
      ),
      // Listado de estaciones de radio
    ],
  );

  @override
  void initState() {
    super.initState();
    _flutterRadioPlayer.initPlayer();
    _flutterRadioPlayer.addMediaSources(frpSource);
  }

  // void _nextStation() {
  //   if (_currentStationIndex < frpSource.mediaSources.length - 1) {
  //     _currentStationIndex++;
  //     _flutterRadioPlayer.play(frpSource.mediaSources[_currentStationIndex].url);
  //   }
  // }

  // void _previousStation() {
  //   if (_currentStationIndex > 0) {
  //     _currentStationIndex--;
  //     _flutterRadioPlayer.play(frpSource.mediaSources[_currentStationIndex].url);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/radio.jpeg",
                  height: 40.0,
                ),
                SizedBox(width: 10.0),
                Text(
                  "Radio",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        _flutterRadioPlayer.play();
                      },
                      child: Text("Play"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //       primary: Colors.blue,
                        //       onPrimary: Colors.white,
                        //       padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        //       textStyle: TextStyle(
                        //         fontSize: 15,
                        //       ),
                        //     ),
                        //     onPressed: _previousStation,
                        //     child: Text("Anterior"),
                        // ),
                        // SizedBox(width: 10),
                        // ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //       primary: Colors.blue,
                        //       onPrimary: Colors.white,
                        //       padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        //       textStyle: TextStyle(
                        //         fontSize: 15,
                        //       ),
                        //     ),
                        //     onPressed: _nextStation,
                        //     child: Text("Siguiente"),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

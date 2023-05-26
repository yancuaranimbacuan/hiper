library input_calculator;

import 'package:flutter/material.dart';
import 'package:torch_controller/torch_controller.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter_radio_player/models/frp_source_modal.dart';

export 'src/calculator_text_field.dart';
export 'src/calculator_text_form_field.dart';
export 'src/numeric_text_field.dart';
export 'src/themes.dart' show CalculatorThemes;

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
                          'assets/splahs.png',
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
          createButton(context, 'assets/mus.png', Page2()),
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
  String operation = '';
  double result = 0.0;

  void addValue(String value) {
    setState(() {
      operation += value;
    });
  }

  void calculate() {
    setState(() {
      List<String> parts = operation.split(' ');
      if (parts.length != 3) {
        // Invalid operation
        return;
      }

      double firstNumber = double.parse(parts[0]);
      String operator = parts[1];
      double secondNumber = double.parse(parts[2]);

      switch (operator) {
        case '+':
          result = firstNumber + secondNumber;
          break;
        case '-':
          result = firstNumber - secondNumber;
          break;
        case '*':
          result = firstNumber * secondNumber;
          break;
        case '/':
          if (secondNumber != 0) {
            result = firstNumber / secondNumber;
          }
          break;
      }

      operation = result.toString();
    });
  }

  void clear() {
    setState(() {
      operation = '';
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
            TextField(
              controller: TextEditingController(text: operation),
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      children: List.generate(9, (index) {
                        index += 1;
                        return ElevatedButton(
                          onPressed: () => addValue(index.toString()),
                          child: Text('$index'),
                        );
                      }),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () => addValue(" + "),
                        child: Text('+'),
                      ),
                      ElevatedButton(
                        onPressed: () => addValue(" - "),
                        child: Text('-'),
                      ),
                      ElevatedButton(
                        onPressed: () => addValue(" * "),
                        child: Text('*'),
                      ),
                      ElevatedButton(
                        onPressed: () => addValue(" / "),
                        child: Text('/'),
                      ),
                      ElevatedButton(onPressed: calculate, child: Text('=')),
                      ElevatedButton(
                        onPressed: clear,
                        child: Text('AC'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => addValue("0"),
                      child: Text('0'),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => addValue("."),
                      child: Text('.'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class Page3 extends StatefulWidget {
//   @override
//   _Page3State createState() => _Page3State();
// }

// class _Page3State extends State<Page3> {
//   final FlutterAudioQuery audioQuery = FlutterAudioQuery();
//   final AudioPlayer audioPlayer = AudioPlayer();
//   List<SongInfo> songs = [];

//   @override
//   void initState() {
//     super.initState();
//     _requestPermissions();
//   }

//   void _requestPermissions() async {
//     if (await Permission.storage.request().isGranted) {
//       // Either the permission was already granted before or the user just granted it.
//       getSongs();
//     } else {
//       // You can request again while the app is in use.
//       if (await Permission.storage.isPermanentlyDenied) {
//         // The user opted to never again see the permission request dialog for this
//         // app. The only way to change the permission's status now is by
//         // letting the user manually enable it in the system settings.
//         openAppSettings();
//       }
//     }
//   }

//   void getSongs() async {
//     songs = await audioQuery.getSongs();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Página 3'),
//       ),
//       body: ListView.builder(
//         itemCount: songs.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//               title: Text(songs[index].title),
//               subtitle: Text(songs[index].artist),
//               //trailing: IconButton(
//               //  icon: Icon(Icons.play_arrow),
//               //  onPressed: () async {
//               //    try {
//               //      await audioPlayer.play(songs[index].filePath, isLocal: true);
//               //      // La reproducción fue exitosa
//               //    } catch (e) {
//               //      print('Error playing audio: $e');
//               //      // Hubo un error al reproducir el audio
//               //}
//               //},
//               //),

//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.skip_previous),
//                     onPressed: () async {
//                       try {
//                         if (index > 0) {
//                           await audioPlayer.play(songs[index - 1].filePath,
//                               isLocal: true);
//                         }
//                         // La reproducción de la canción anterior fue exitosa
//                       } catch (e) {
//                         print('Error playing previous song: $e');
//                         // Hubo un error al reproducir la canción anterior
//                       }
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.play_arrow),
//                     onPressed: () async {
//                       try {
//                         await audioPlayer.play(songs[index].filePath,
//                             isLocal: true);
//                         // La reproducción fue exitosa
//                       } catch (e) {
//                         print('Error playing audio: $e');
//                         // Hubo un error al reproducir el audio
//                       }
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.pause),
//                     onPressed: () async {
//                       try {
//                         await audioPlayer.pause();
//                         // La pausa fue exitosa
//                       } catch (e) {
//                         print('Error pausing audio: $e');
//                         // Hubo un error al pausar el audio
//                       }
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.skip_next),
//                     onPressed: () async {
//                       try {
//                         if (index < songs.length - 1) {
//                           await audioPlayer.play(songs[index + 1].filePath,
//                               isLocal: true);
//                         }
//                         // La reproducción de la siguiente canción fue exitosa
//                       } catch (e) {
//                         print('Error playing next song: $e');
//                         // Hubo un error al reproducir la siguiente canción
//                       }
//                     },
//                   ),
//                 ],
//               ));
//         },
//       ),
//     );
//   }
// }

//_____________________________________Pagina secundaria tienda android_____________________________________

class NuevaPagina extends StatefulWidget {
  @override
  _NuevaPaginaState createState() => _NuevaPaginaState();
}

class _NuevaPaginaState extends State<NuevaPagina> {
  final FlutterRadioPlayer _flutterRadioPlayer = FlutterRadioPlayer();

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
        url: "https://stream2.305stream.com/proxy/client128?mp=/stream",
        description: "Station 2",
        isPrimary: false,
        title: "Station 2",
        isAac: false,
      ),
    ],
  );

  @override
  void initState() {
    super.initState();
    _flutterRadioPlayer.initPlayer();
    _flutterRadioPlayer.addMediaSources(frpSource);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //backgroundColor: Colors.white,
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
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/mus.gif"), // Ruta a tu imagen
              fit: BoxFit.cover,
            ),
          ),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            onPrimary: Colors.white,
                            minimumSize: Size(400, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                          ),
                          icon: Icon(Icons.radio),
                          label: Text(
                            'Play',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            _flutterRadioPlayer.play();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

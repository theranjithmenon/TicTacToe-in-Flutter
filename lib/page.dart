import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List btn = ["", "", "", "", "", "", "", "", ""];
  bool whichPlayer = true;
  int clickedBtn = 0;
  String winner = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Expanded(
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    itemBuilder: (BuildContext context, index) {
                      return MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () {
                          if (clickedBtn == 9) {
                            isOver();
                          } else {
                            if (btn[index] == "") {
                              btnClick(index);
                              isOver();
                            }
                          }
                        },
                        color: (btn[index] == "")
                            ? Colors.lightBlueAccent
                            : (btn[index] == "X")
                                ? Colors.redAccent
                                : Colors.orangeAccent,
                        child: Text(
                          btn[index],
                          style: const TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }),
              ),
              TextButton(
                  onPressed: () {
                    for (int i = 0; i < 9; i++) {
                      setState(() {
                        btn[i] = "";
                      });
                      whichPlayer = true;
                      clickedBtn = 0;
                      winner = "";
                    }
                  },
                  child: const Text("Reset"))
            ],
          ),
        ),
      )),
    );
  }

  void btnClick(index) {
    setState(() {
      if (whichPlayer) {
        btn[index] = "X";
      } else {
        btn[index] = "O";
      }
    });
    whichPlayer = !whichPlayer;
    clickedBtn++;
  }

  void isOver() {
    if (btn[0] == btn[1] && btn[0] == btn[2] && btn[0] != "") {
      winner = btn[0];
      snack();
    } else if (btn[3] == btn[4] && btn[3] == btn[5] && btn[3] != "") {
      winner = btn[3];
      snack();
    } else if (btn[6] == btn[7] && btn[6] == btn[8] && btn[6] != "") {
      winner = btn[6];
      snack();
    } else if (btn[0] == btn[3] && btn[0] == btn[6] && btn[0] != "") {
      winner = btn[0];
      snack();
    } else if (btn[1] == btn[4] && btn[1] == btn[7] && btn[1] != "") {
      winner = btn[1];
      snack();
    } else if (btn[2] == btn[5] && btn[5] == btn[8] && btn[2] != "") {
      winner = btn[2];
      snack();
    } else if (btn[0] == btn[4] && btn[0] == btn[8] && btn[0] != "") {
      winner = btn[0];
      snack();
    } else if (btn[2] == btn[4] && btn[2] == btn[6] && btn[2] != "") {
      winner = btn[2];
      snack();
    } else if (clickedBtn == 9 && winner == "") {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("The game is a Draw")));
    }
  }

  snack() {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("$winner won the game")));
  }
}

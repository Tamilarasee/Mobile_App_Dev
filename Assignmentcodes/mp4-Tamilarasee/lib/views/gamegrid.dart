import 'package:battleships/model/gamedetails_model.dart';
import 'package:flutter/material.dart';

class GameGrid extends StatefulWidget {
  final GameDetailsModel? gameDetails;
  final bool isEditable;
  final bool isNewGame;
  final Function(String, bool, bool)? onTap;
  final Function(bool, GameDetailsModel?)? onClick;

  const GameGrid(
      {required this.isEditable,
      required this.isNewGame,
      this.gameDetails,
      this.onTap,
      this.onClick,
      super.key});

  @override
  State<GameGrid> createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> {
  List<String> rowNames = ['A', 'B', 'C', 'D', 'E'];
  List<Color> blockColor = List.filled(36, Colors.white);
  List<bool> isBlockClicked = List.filled(36, false);
  int counter = 0;
  String shot = "";
  bool isCleared = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(children: [
          Expanded(child: LayoutBuilder(builder: (context, constraints) {
            final aspectRatio = constraints.maxWidth / constraints.maxHeight;
            final shipsList = widget.gameDetails?.ships;
            final sunkList = widget.gameDetails?.sunk;
            final wrecksList = widget.gameDetails?.wrecks;
            final shotList = widget.gameDetails?.shots;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6, childAspectRatio: aspectRatio),
              itemCount: 36,
              itemBuilder: (context, index) {
                int row = index ~/ 6;  //quotient
                int col = index % 6;   //remainder
                Color selectedColor = Colors.white;
                bool isClicked = false;
                if (widget.isNewGame) {
                  selectedColor = blockColor[index];
                  isClicked = isBlockClicked[index];
                }
                if (row == 0 && col == 0) {
//blank box
                  return Container();
                } else if (row == 0) {
                  //display Header from 1-5
                  return Container(
                    alignment: Alignment.center,
                    child: Text(col.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  );
                } else if (col == 0) {
                  //display header
                  return Container(
                    alignment: Alignment.center,
                    child: Text(rowNames[row - 1],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  );
                } else {
                  final rowNamesValue = '${rowNames[row - 1]}$col';
                  bool isShipAvailable = false;
                  bool isShipSunk = false;
                  bool isShipWrek = false;
                  bool isShotMissed = false;

                  if (!widget.isNewGame) {
                    if (isCleared) {
                      shot = "";
                      isCleared = false;
                    }
                    if (shot != "") {
                      if (rowNamesValue == shot) {
                        selectedColor = Color.fromARGB(255, 230, 149, 7);
                        isClicked = true;
                      }
                    }
                  }

                  if (widget.gameDetails != null) {
                    String ship = shipsList!.firstWhere(
                        (element) => element == rowNamesValue,
                        orElse: () => "");

                    if (ship.isNotEmpty) {
                      isShipAvailable = true;
                    }
                    String sunk = sunkList!.firstWhere(
                        (element) => element == rowNamesValue,
                        orElse: () => "");

                    if (sunk.isNotEmpty) {
                      isShipSunk = true;
                    }
                    String wreck = wrecksList!.firstWhere(
                        (element) => element == rowNamesValue,
                        orElse: () => "");

                    if (wreck.isNotEmpty) {
                      isShipWrek = true;
                    }
                    String shots = shotList!.firstWhere(
                        (element) => element == rowNamesValue,
                        orElse: () => "");

                    if (shots.isNotEmpty && !isShipSunk) {
                      isShotMissed = true;
                    }
                  }
                  return Container(
                      child: Material(
                          color: selectedColor,
                          child: InkWell(
                            onTap: widget.isEditable
                                ? () {
                                    if (widget.isNewGame) {
                                      if (!isClicked) {
                                        if (counter < 5) {
                                          setState(() {
                                            counter++;
                                            blockColor[index] = Colors.blue;
                                            isClicked = true;
                                            isBlockClicked[index] = true;
                                          });
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    '5 ships are selected')),
                                          );
                                        }
                                      } else {
                                        setState(() {
                                          counter--;
                                          blockColor[index] = Colors.white;
                                          isClicked = false;
                                          isBlockClicked[index] = false;
                                        });
                                      }
                                      final value = '${rowNames[row - 1]}$col';
                                      widget.onTap?.call(
                                          value, isClicked, widget.isNewGame);
                                    } else {
                                      final value = '${rowNames[row - 1]}$col';
                                      setState(() {
                                        if (value == shot) {
                                          isClicked = false;
                                          selectedColor = Colors.white;
                                          shot = "";
                                        } else {
                                          selectedColor = Color.fromARGB(255, 230, 149, 7);
                                          isClicked = true;
                                          shot = value;
                                        }
                                      });
                                      widget.onTap?.call(
                                          value, isClicked, widget.isNewGame);
                                    }
                                  }
                                : null, //onTap?.call(row, col),
                            splashColor: Colors.blue,
                            hoverColor:
                                const Color.fromARGB(255, 158, 218, 160),

                            child: Container(
                              alignment: AlignmentDirectional.center,
                              child: Center(
                                child: Row(
                                  children: [
                                    isShipAvailable
                                        ? const Icon(Icons.sailing_rounded,
                                            color: Colors.blue)
                                        : Container(),
                                    isShipSunk
                                        ? Text(String.fromCharCode(128165))
                                        : Container(),
                                    isShipWrek
                                        ? const Icon(Icons.bubble_chart,
                                            color: Colors.lightBlue)
                                        : Container(),
                                    isShotMissed
                                        ? Text(String.fromCharCode(128163))
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          )));
                }
              },
            );
          })),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
            onPressed: widget.isEditable
                ? () {
                    isCleared = true;
                    widget.onClick
                        ?.call(widget.isNewGame, widget.gameDetails);
                  }
                : null,
            child: const Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ]));
  }
}

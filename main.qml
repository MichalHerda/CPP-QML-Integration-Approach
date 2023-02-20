import QtQuick
import QtQuick.Controls
import NoughtsAndCrosses 1.0
import "jsBackEnd.js" as Js
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ApplicationWindow {
        maximumWidth: 300
        maximumHeight: 500
        minimumWidth: 300
        minimumHeight: 500
        visible: true
        color: "darkslategrey"
        title: qsTr("Noughts And Crosses")
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        property color rectColor:     "lightblue"
        property color borderColor:   "black"
        property color areaColor:     "blue"
        property color repeaterColor: "orange"
        property color indicateColor: "red"
        property color linesColor:    "gold"
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    BackEnd {
        id: back                                                                           // BackEnd item
        onTurnChanged:          (turn) => {                                                // Enable reading C++ functions
                       }                                                                   // From main.qml level
        }
//-----------------------------------------------------PLAYER INDICATOR AREA------------------------------------------------------------------
    Repeater {
            id: playerAreaRep
            model: 2
            delegate: Rectangle {
                id: playerAreaElement
                x: 15 + (index * 140)
                y: 15
                width: 130
                height: 100
                color: rectColor
                border {color: borderColor; width: 7}

                Repeater {
                    id: textRepeater
                    model: ListModel {
                        ListElement {txt: "PLAYER X" ; q: 18}
                        ListElement {txt: "PLAYER O" ; q: 18}
                        ListElement {txt: "   PRESS" ; q: 60}
                        ListElement {txt: "  START!" ; q: 60}
                        ListElement {txt: "    TURN" ; q: 60}
                        ListElement {txt: "   WINS!" ; q: 60}
                        ListElement {txt: "    DRAW" ; q: 60}
                    }
                    delegate: Text {
                        id: textRepeaterElement
                        x: 18
                        y: q
                        font {bold: true; pointSize: 15}
                        text: txt
                        visible: false
                    }
                }
                Component.onCompleted: {
                   Js.initialState (playerAreaRep)
                }
            }
        }
//-------------------------------------------------------------GAME-BOARD--------------------------------------------------------------------
    Rectangle {
        id: area
        color: "blue"
        border.color: borderColor                                                   //game board
        border.width: 3
        x: 15
        y: 129
        width: 270
        height: 270

        Repeater{
            id: repeax
            model: 9                                                                // game grid as 9 rectangles repeat
            delegate: Rectangle {
                id: tileElement
                x: (index % 3) * area.width/3
                y:  Math.floor (index / 3) * area.height/3
                width: area.width/3
                height: area.height/3
                color: repeaterColor
                border {color: borderColor; width: tileElement.width/20}

                Repeater {
                    id: tileRepeater
                    model: ListModel {
                        ListElement {src: "qrc:/Images/empty.png" ; vis: true }
                        ListElement {src: "qrc:/Images/cross.png" ; vis: false}
                        ListElement {src: "qrc:/Images/nought.png"; vis: false}
                    }
                    delegate: Image {
                        id: tileRepeaterElement
                        width: tileElement.width/1.2
                        height: tileElement.height/1.2
                        anchors.centerIn: parent
                        source: src
                        visible: vis
                    }
                }

                MouseArea {
                    anchors.fill: tileElement
                    onClicked: {
                        if( (!back.game_over) && (back.tile[index] === 0) ) {
                           repeax.itemAt(index).children[0].visible = false
                           if(back.turn)
                               repeax.itemAt(index).children[1].visible = true
                           else
                               repeax.itemAt(index).children[2].visible = true

                           back.change_tile_value (index, back.turn);
                           back.check_for_win (back.turn, back.tile);
                           if(back.check_for_win) {
                               for(let i = 1; i <= 8; i++ ) {
                                   if(back.magic_number === i) {
                                       Js.drawLine(i, playerAreaRep, linesRep)                                 // display line if winning
                                       back.game_overWrite(game_over);
                                   }
                               }
                           }
                           back.check_is_move_possible (back.tile);
                           back.turnWrite (back.turn)
                           if(back.check_is_move_possible) {
                               if(back.turn) {
                                   Js.indicateXturn (playerAreaRep, indicateColor, borderColor)
                                }
                               else {
                                   Js.indicateYturn (playerAreaRep, indicateColor, borderColor)
                                }
                            }
                        }
                       else {
                           Js.initialState (playerAreaRep)
                        }
                    }
                }
            }
        }
//-------------------------------------------------------------LINES----------------------------------------------------------------------
        Repeater {
                id: linesRep
                model: ListModel {
                    ListElement { p:10 ; q:40 ; w:250; h:10 ; o:0   }
                    ListElement { p:10 ; q:130; w:250; h:10 ; o:0   }                       // lines coordination
                    ListElement { p:10 ; q:220; w:250; h:10 ; o:0   }                       // don't touch - FRAGILE
                    ListElement { p:40 ; q:10 ; w:10 ; h:250; o:0   }
                    ListElement { p:130; q:10 ; w:10 ; h:250; o:0   }
                    ListElement { p:220; q:10 ; w:10 ; h:250; o:0   }
                    ListElement { p:125; q:-28; w:10 ; h:320; o:135 }
                    ListElement { p:125; q:-18; w:10 ; h:320; o:45  }
                }
                delegate: Rectangle {
                    x: p
                    y: q
                    width: w
                    height: h
                    color: linesColor
                    rotation: o
                    visible: false
                }
            }
        }
//---------------------------------------------------------BOTTOM_AREA--------------------------------------------------------------------
    Rectangle {
        color: rectColor
        border.color: borderColor
        border.width: 3
        x: 15
        y: 415
        width: 270
        height: 70

        Button {
            id: button
            x: 42
            y: 15
            width: 185
            height: 40
            text: qsTr ("Start/Restart Game")

            onClicked: {
                Js.clearLinesAndBoard (repeax, linesRep)

                    back.game_over = true
                    back.clear_board (back.tile)
                    Js.pressStartClear (playerAreaRep)

                if(back.turn) {
                    Js.indicateXturn (playerAreaRep, indicateColor, borderColor)
                }
                else {
                    Js.indicateYturn (playerAreaRep, indicateColor, borderColor)
                }
            }
        }
    }
}

import QtQuick
import QtQuick.Controls
import NoughtsAndCrosses 1.0
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ApplicationWindow {
        maximumWidth: 300
        maximumHeight: 500
        minimumWidth: 300
        minimumHeight: 500
        visible: true
        color: "darkslategrey"
        title: qsTr("Nought And Crosses")
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        property color rectColor: "lightblue"
        property color borderColor: "black"
        property color areaColor: "blue"
        property color repeaterColor: "orange"
        property color indicateColor: "red"
        property color linesColor: "gold"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////                                                                                            ///////////////////////////
/////////////////////////                                      BACK_END ITEMS                                        ///////////////////////////
/////////////////////////                                                                                            ///////////////////////////
/////////////////////////                                                                                            ///////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    BackEnd {
        id: back1
        onGame_overChanged: (game_over) => {
                       }
        }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    BackEnd {
        id: back2
        onTileChanged:          (tile) => {
                       }
        }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    BackEnd {
        id: back3
        onTurnChanged:          (turn) => {
        }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////                                                                                        ///////////////////////////
////////////////////////////                                PLAYER INDICATOR AREA                                   ///////////////////////////
////////////////////////////                                                                                        ///////////////////////////
////////////////////////////                                                                                        ///////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    }
    Rectangle {
        id: uprec1
        color: rectColor
        border.color: borderColor
        border.width: 7
        x: 15
        y: 15
        width: 130
        height: 100
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               TextField {
                    id: textField1                   
                    readOnly: true
                    background: Rectangle {
                             color: rectColor
                         }
                    font.bold: true
                    x: 15
                    y: 14
                    width: 98
                    height: 29
                    placeholderText: qsTr("   PLAYER X")
                }
                TextField {
                    id: textField3
                    readOnly: true
                    background: Rectangle {
                             color: rectColor
                         }
                    font.bold: true
                    x: 15
                    y: 57
                    width: 98
                    height: 29
                    placeholderText: qsTr("      PRESS")
                }
        }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   Rectangle {
        id: uprec2
        color: rectColor
        border.color: borderColor
        border.width: 7
        x: 155
        y: 15
        width: 130
        height: 100
        visible: true
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                TextField {
                    id: textField2
                    readOnly: true
                    background: Rectangle {
                             color: rectColor
                         }
                    font.bold: true
                    x: 15
                    y: 14
                    width: 98
                    height: 29
                    placeholderText: qsTr("   PLAYER O")
                }
                TextField {
                    id: textField4
                    readOnly: true
                    background: Rectangle {
                             color: rectColor
                         }
                    font.bold: true
                    x: 15
                    y: 57
                    width: 98
                    height: 29
                    placeholderText: qsTr("     START!")
                }
        }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////                                                                                         ////////////////////////
///////////////////////////                                        GAME-BOARD                                       ////////////////////////
///////////////////////////                                                                                         ////////////////////////
///////////////////////////                                                                                         ////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    Rectangle {
        id: area
        color: "blue"
        border.color: borderColor
        border.width: 3
        x: 15
        y: 129
        width: 270
        height: 270

        Repeater{
            id: repeax
            model: 9
            delegate: Rectangle {
                id: tileElement
                x: (index % 3) * area.width/3
                y:  Math.floor (index / 3) * area.height/3
                width: area.width/3
                height: area.height/3
                color: repeaterColor
                border {color: "midnightblue"; width: tileElement.width/20}
                property bool vis1: true
                property bool vis2: false
                property bool vis3: false

                Image {
                    id: image1
                    width: tileElement.width/1.2
                    height: tileElement.height/1.2
                    visible: parent.vis1
                    anchors.centerIn: parent
                    source: "qrc:/Images/empty.png"
                   }
                Image {
                    id: image2
                    width: tileElement.width/1.2
                    height: tileElement.height/1.2
                    visible: parent.vis2
                    anchors.centerIn: parent
                    source: "qrc:/Images/cross.png"
                   }
                Image {
                    id: image3
                    width: tileElement.width/1.2
                    height: tileElement.height/1.2
                    visible: parent.vis3
                    anchors.centerIn: parent
                    source: "qrc:/Images/nought.png"
                   }
                MouseArea {
                    anchors.fill: tileElement
                    onClicked: {
                        if( (!back3.game_over) && (back3.tile[index] === 0) ) {
                           repeax.itemAt(index).vis1 = false
                           if(back3.turn)
                               repeax.itemAt(index).vis2 = true
                           else
                               repeax.itemAt(index).vis3 = true

                           back3.change_tile_value(index,back3.turn);
                           back3.check_for_win(back3.turn,back3.tile);
                           if(back3.check_for_win) {
                               if      (back3.magic_number === 1) {line1.visible = true; back3.game_overWrite(game_over);}
                               else if (back3.magic_number === 2) {line2.visible = true; back3.game_overWrite(game_over);}
                               else if (back3.magic_number === 3) {line3.visible = true; back3.game_overWrite(game_over);}
                               else if (back3.magic_number === 4) {line4.visible = true; back3.game_overWrite(game_over);}
                               else if (back3.magic_number === 5) {line5.visible = true; back3.game_overWrite(game_over);}
                               else if (back3.magic_number === 6) {line6.visible = true; back3.game_overWrite(game_over);}
                               else if (back3.magic_number === 7) {line7.visible = true; back3.game_overWrite(game_over);}
                               else if (back3.magic_number === 8) {line8.visible = true; back3.game_overWrite(game_over);}
                           }

                           back3.check_is_move_possible(back3.tile);
                           console.log("check for win = ", back3.check_for_win(back3.turn,back3.tile));
                           back3.turnWrite(back3.turn)
                           console.log("check is move possible = ",back3.check_is_move_possible(back3.tile))
                           if(back3.check_is_move_possible) {
                               if(back3.turn) {
                                   textField3.text = "       TURN";
                                   textField4.text = " ";
                                   uprec1.border.color = indicateColor;
                                   uprec2.border.color = borderColor;
                                }
                               else {
                                   textField4.text = "       TURN";
                                   textField3.text = " ";
                                   uprec1.border.color = borderColor;
                                   uprec2.border.color = indicateColor;
                                }
                            }
                        }
                       else {
                             console.log("PRESS START")
                        }
                    }
                }
            }
        }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////                                                                                            ////////////////////////
//////////////////////                                      LINES                                                 ////////////////////////
//////////////////////                                                                                            ////////////////////////
//////////////////////                                                                                            ////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Rectangle {
            id: line1
            color: linesColor
            x: 10                                                                       // it could be ListModel created here as well
            y: 50
            width: 250
            height: 10
            visible: false
        }
        Rectangle {
            id: line2
            color: linesColor
            x: 10
            y: 130
            width: 250
            height: 10
            visible: false
        }
        Rectangle {
            id: line3
            color: linesColor
            x: 10
            y: 215
            width: 250
            height: 10
            visible: false
        }
        Rectangle {
            id: line4
            color: linesColor
            x: 45
            y: 10
            width: 10
            height: 250
            visible: false
        }
        Rectangle {
            id: line5
            color: linesColor
            x: 130
            y: 10
            width: 10
            height: 250
            visible: false
        }
        Rectangle {
            id: line6
            color: linesColor
            x: 215
            y: 10
            width: 10
            height: 250
            visible: false
        }
        Rectangle {
            id: line7
            color: linesColor
            x: 125
            y: -15
            width: 10
            height: 320
            rotation:  135
            visible: false
        }
        Rectangle {
            id: line8
            color: linesColor
            x: 115
            y: -15
            width: 10
            height: 320
            rotation: 45
            visible: false
        }
    }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////                                                                                            /////////////////////////
/////////////////////                                    BOTTOM_AREA                                             /////////////////////////
/////////////////////                                                                                            /////////////////////////
/////////////////////                                                                                            /////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
            text: qsTr("Start/Restart Game")

            onClicked: {
                for(let i = 0; i < 9; i++) {
                    console.log(i)

                    repeax.itemAt(i).vis1 = true
                    repeax.itemAt(i).vis2 = false
                    repeax.itemAt(i).vis3 = false

                    console.log("vis1 (",i,") = ", repeax.itemAt(i).vis1)
                    console.log("vis2 (",i,") = ", repeax.itemAt(i).vis2)
                    console.log("vis3 (",i,") = ", repeax.itemAt(i).vis3)
                }
                    line1.visible = false
                    line2.visible = false
                        line3.visible = false
                        line4.visible = false
                            line5.visible = false
                            line6.visible = false
                                line7.visible = false
                                line8.visible = false

                    back3.game_over = true
                    back3.clear_board(back3.tile)
                    textField3.text = "       TURN"
                    textField4.text = " "

                if(back3.turn) {
                    textField3.text = "       TURN";                                                    // indicate
                    textField4.text = " ";                                                              // whose
                    uprec1.border.color = indicateColor;                                                // turn
                    uprec2.border.color = borderColor;
                    }
                else
                    {
                    textField4.text = "       TURN";
                    textField3.text = " ";
                    uprec1.border.color = borderColor;
                    uprec2.border.color = indicateColor;
                    }
            }
        }
    }
}

import QtQuick
import QtQuick.Controls
import NoughtsAndCrosses 1.0
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
        property color rectColor: "lightblue"
        property color borderColor: "black"
        property color areaColor: "blue"
        property color repeaterColor: "orange"
        property color indicateColor: "red"
        property color linesColor: "gold"
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    BackEnd {
        id: back                                                                           // BackEnd item
        onTurnChanged:          (turn) => {                                                // Enable reading C++ functions
                       }                                                                   // From main.qml level
        }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////PLAYER INDICATOR AREA///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    Rectangle {
        id: uprec1
        color: rectColor
        border.color: borderColor
        border.width: 7
        x: 15
        y: 15
        width: 130
        height: 100
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
///////////////////////////////////////////////////////////////GAME-BOARD///////////////////////////////////////////////////////////////////
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
                border {color: borderColor; width: tileElement.width/20}
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
                        if( (!back.game_over) && (back.tile[index] === 0) ) {
                           repeax.itemAt(index).vis1 = false
                           if(back.turn)
                               repeax.itemAt(index).vis2 = true
                           else
                               repeax.itemAt(index).vis3 = true

                           back.change_tile_value(index,back.turn);
                           back.check_for_win(back.turn,back.tile);
                           if(back.check_for_win) {
                               for(let i = 1; i <= 8; i++ ) {
                                   if(back.magic_number === i) {
                                       linesRep.itemAt(i - 1).visible = true;
                                       back.game_overWrite(game_over);
                                   }
                               }
                           }
                           back.check_is_move_possible(back.tile);
                           console.log("check for win = ", back.check_for_win(back.turn,back.tile));
                           back.turnWrite(back.turn)
                           console.log("check is move possible = ",back.check_is_move_possible(back.tile))
                           if(back.check_is_move_possible) {
                               if(back.turn) {
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
//////////////////////////////////////////////////////////////LINES///////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Repeater {
                id: linesRep
                model: ListModel {
                    ListElement { p:10 ; q:40 ; w:250; h:10 ; o:0   }
                    ListElement { p:10 ; q:130; w:250; h:10 ; o:0   }
                    ListElement { p:10 ; q:220; w:250; h:10 ; o:0   }
                    ListElement { p:40 ; q:10 ; w:10 ; h:250; o:0   }
                    ListElement { p:130; q:10 ; w:10 ; h:250; o:0   }
                    ListElement { p:220; q:10 ; w:10 ; h:250; o:0   }
                    ListElement { p:125; q:-15; w:10 ; h:320; o:135 }
                    ListElement { p:115; q:-15; w:10 ; h:320; o:45  }
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
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////BOTTOM_AREA//////////////////////////////////////////////////////////////////////
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
                    repeax.itemAt(i).vis1 = true
                    repeax.itemAt(i).vis2 = false
                    repeax.itemAt(i).vis3 = false

                    if(i < 8) {
                        console.log(i," visible: ",linesRep.itemAt(i).visible)
                        linesRep.itemAt(i).visible = false
                    }
                }
                    back.game_over = true
                    back.clear_board(back.tile)
                    textField3.text = "       TURN"
                    textField4.text = " "

                if(back.turn) {
                    textField3.text = "       TURN";                                                    // indicate
                    textField4.text = " ";                                                              // whose
                    uprec1.border.color = indicateColor;                                                // turn
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
    }
}

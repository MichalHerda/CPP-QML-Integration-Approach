///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////                                                                                            /////////
//////////                      SORRY FOR THE AMOUNT OF CODE, I'LL TRY TO SHORT IT MAYBE              /////////
//////////                     I HAD AN ISSUE WITH "COMPONENT" SO I REFUSE TO CREATE IT               /////////
//////////                        AND ALSO UNEXPECTED ERRORS WITH FUNCTIONS CREATION                  /////////
//////////                                                                                            /////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
import QtQuick
import QtQuick.Window 2.3
import QtQuick.Controls 6.5
import NoughtsAndCrosses 1.0
import QtQuick.Shapes 1.15
import QtQuick.Layouts 1.3
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
Window {

    function afterClicking(x,image1ID,image2ID,image3ID) {

      if( (!back3.game_over) && (back3.tile[x] == 0) )
           {
            image1ID.visible = false
            if(back3.turn)
                image2ID.visible = true
            else
                image3ID.visible = true

            back3.change_tile_value(x,back3.turn);
            back3.check_for_win(back3.turn,back3.tile);
            if(back3.check_for_win)
            {
                if      (back3.magic_number == 1) {line1.visible = true; back3.game_overWrite(game_over);}
                else if (back3.magic_number == 2) {line2.visible = true; back3.game_overWrite(game_over);}
                else if (back3.magic_number == 3) {line3.visible = true; back3.game_overWrite(game_over);}
                else if (back3.magic_number == 4) {line4.visible = true; back3.game_overWrite(game_over);}
                else if (back3.magic_number == 5) {line5.visible = true; back3.game_overWrite(game_over);}
                else if (back3.magic_number == 6) {line6.visible = true; back3.game_overWrite(game_over);}
                else if (back3.magic_number == 7) {line7.visible = true; back3.game_overWrite(game_over);}
                else if (back3.magic_number == 8) {line8.visible = true; back3.game_overWrite(game_over);}
            }

            back3.check_is_move_possible(back3.tile);
            console.log("check for win = ", back3.check_for_win(back3.turn,back3.tile));
            back3.turnWrite(back3.turn)
            console.log("check is move possible = ",back3.check_is_move_possible(back3.tile))
            if(back3.check_is_move_possible)
            {
                            if(back3.turn)
                                {
                                textField3.text = "       TURN";
                                textField4.text = " ";
                                uprec1.border.color = "red";
                                uprec2.border.color = "black";
                                }
                            else
                                {
                                textField4.text = "       TURN";
                                textField3.text = " ";
                                uprec1.border.color = "black";
                                uprec2.border.color = "red";
                                }
                         }
                   }
    else
       {
          console.log("GAME OVER! PRESS START")
       }
 }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    property bool turn
    property bool game_over
    property variant tile: new QVector()
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    maximumWidth: 300
    maximumHeight: 500
    minimumWidth: 300
    minimumHeight: 500
    visible: true
    color: "darkslategrey"
    title: qsTr("Nought And Crosses")
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////                                                                                            /////////
//////////                      BACK_END ITEMS,NOT SHURE ARE ALL NECESSARY                            /////////
//////////                                                                                            /////////
//////////                                                                                            /////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    BackEnd {
        id: back1
        onGame_overChanged: (game_over) => {
                       }
            }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    BackEnd {
        id: back2
        onTileChanged:          (tile) => {
                       }
            }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    BackEnd {
        id: back3
        onTurnChanged:          (turn) => {
             }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////                                                                                            /////////
//////////                                PLAYER INDICATOR AREA                                       /////////
//////////                                                                                            /////////
//////////                                                                                            /////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    }
    Rectangle {
        id: uprec1
        color: "lightblue"
        border.color: "black"
        border.width: 7
        x: 15
        y: 15
        width: 130
        height: 100
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
               TextField {
                    id: textField1                   
                    readOnly: true
                    background: Rectangle {
                             color: "lightblue"
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
                             color: "lightblue"
                         }
                    font.bold: true
                    x: 15
                    y: 57
                    width: 98
                    height: 29
                    placeholderText: qsTr("      PRESS")
                }
        }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   Rectangle {
        id: uprec2
        color: "lightblue"
        border.color: "black"
        border.width: 7
        x: 155
        y: 15
        width: 130
        height: 100
        visible: true
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                TextField {
                    id: textField2
                    readOnly: true
                    background: Rectangle {
                             color: "lightblue"
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
                             color: "lightblue"
                         }
                    font.bold: true
                    x: 15
                    y: 57
                    width: 98
                    height: 29
                    placeholderText: qsTr("     START!")
                }
        }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////                                                                                            /////////
//////////                                        GAME-BOARD                                          /////////
//////////                                                                                            /////////
//////////                                                                                            /////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    Rectangle {
        color: "blue"
        border.color: "black"
        border.width: 3
        x: 15
        y: 129
        width: 270
        height: 270     
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////                                                                                            /////////
//////////                                         TILE 1                                             /////////
//////////                                                                                            /////////
//////////                                                                                            /////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Rectangle {
            color: "orange"
            border.color: "black"
            border.width: 3
            x: 15
            y: 15
            width: 70
            height: 70
            Image {                                                                                 // w tym języku ni stąd ni z owąd wyskakują błędy "enexpected token", więc strach tu tworzyć funkcje
                id: image1
                visible: true
                anchors.fill: parent
                source: "qrc:/Images/empty.png"
                fillMode: Image.PreserveAspectFit
               }
            Image {
                id: image1A
                visible: false
                anchors.fill: parent
                source: "qrc:/Images/cross.png"
                fillMode: Image.PreserveAspectFit
               }
            Image {
                id: image1B
                visible: false
                anchors.fill: parent
                source: "qrc:/Images/nought.png"
                fillMode: Image.PreserveAspectFit
               }
            MouseArea {
             anchors.fill: image1
             onClicked:
                {
                 afterClicking(0,image1,image1A,image1B)
                }
        }
   }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////                                                                                            /////////
//////////                                       TILE 2                                               /////////
//////////                                                                                            /////////
//////////                                                                                            /////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Rectangle {
            color: "orange"
            border.color: "black"
            border.width: 3
            x: 100
            y: 15
            width: 70
            height: 70
            Image {
                id: image2
                visible: true
                anchors.fill: parent
                source: "qrc:/Images/empty.png"
                fillMode: Image.PreserveAspectFit
               }
            Image {
                id: image2A
                visible: false
                anchors.fill: parent
                source: "qrc:/Images/cross.png"
                fillMode: Image.PreserveAspectFit
               }
            Image {
                id: image2B
                visible: false
                anchors.fill: parent
                source: "qrc:/Images/nought.png"
                fillMode: Image.PreserveAspectFit
               }
            MouseArea {
             anchors.fill: image2
             onClicked:
                {
                 afterClicking(1,image2,image2A,image2B)
                }
            }
        }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////                                                                                            /////////
//////////                                      TILE 3                                                /////////
//////////                                                                                            /////////
//////////                                                                                            /////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
       Rectangle {
            color: "orange"
            border.color: "black"
            border.width: 3
            x: 185
            y: 15
            width: 70
            height: 70
            Image {
                id: image3
                visible: true
                anchors.fill: parent
                source: "qrc:/Images/empty.png"
                fillMode: Image.PreserveAspectFit
               }
            Image {
                id: image3A
                visible: false
                anchors.fill: parent
                source: "qrc:/Images/cross.png"
                fillMode: Image.PreserveAspectFit
               }
            Image {
                id: image3B
                visible: false
                anchors.fill: parent
                source: "qrc:/Images/nought.png"
                fillMode: Image.PreserveAspectFit
               }
                    MouseArea {
                     anchors.fill: image3
                     onClicked:
                        {
                         afterClicking(2,image3,image3A,image3B)
                        }
                    }
        }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////                                                                                            /////////
//////////                                     TILE 4                                                 /////////
//////////                                                                                            /////////
//////////                                                                                            /////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Rectangle {
            color: "orange"
            border.color: "black"
            border.width: 3
            x: 15
            y: 100
            width: 70
            height: 70
            Image {
                id: image4
                visible: true
                anchors.fill: parent
                source: "qrc:/Images/empty.png"
                fillMode: Image.PreserveAspectFit
               }
            Image {
                id: image4A
                visible: false
                anchors.fill: parent
                source: "qrc:/Images/cross.png"
                fillMode: Image.PreserveAspectFit
               }
            Image {
                id: image4B
                visible: false
                anchors.fill: parent
                source: "qrc:/Images/nought.png"
                fillMode: Image.PreserveAspectFit
               }
                         MouseArea {
                         anchors.fill: image4
                         onClicked:
                            {
                             afterClicking(3,image4,image4A,image4B)
                            }
                    }
        }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////                                                                                            /////////
//////////                                       TILE 5                                               /////////
//////////                                                                                            /////////
//////////                                                                                            /////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Rectangle {
            color: "orange"
            border.color: "black"
            border.width: 3
            x: 100
            y: 100
            width: 70
            height: 70
            Image {
                id: image5
                visible: true
                anchors.fill: parent
                source: "qrc:/Images/empty.png"
                fillMode: Image.PreserveAspectFit
               }
            Image {
                id: image5A
                visible: false
                anchors.fill: parent
                source: "qrc:/Images/cross.png"
                fillMode: Image.PreserveAspectFit
               }
            Image {
                id: image5B
                visible: false
                anchors.fill: parent
                source: "qrc:/Images/nought.png"
                fillMode: Image.PreserveAspectFit
               }
                    MouseArea {
                     anchors.fill: image5
                     onClicked:
                        {
                         afterClicking(4,image5,image5A,image5B)
                        }
                    }
       }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////                                                                                            /////////
//////////                                          TILE 6                                            /////////
//////////                                                                                            /////////
//////////                                                                                            /////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Rectangle {
            color: "orange"
            border.color: "black"
            border.width: 3
            x: 185
            y: 100
            width: 70
            height: 70
            Image {
                id: image6
                visible: true
                anchors.fill: parent
                source: "qrc:/Images/empty.png"
                fillMode: Image.PreserveAspectFit
               }
            Image {
                id: image6A
                visible: false
                anchors.fill: parent
                source: "qrc:/Images/cross.png"
                fillMode: Image.PreserveAspectFit
               }
            Image {
                id: image6B
                visible: false
                anchors.fill: parent
                source: "qrc:/Images/nought.png"
                fillMode: Image.PreserveAspectFit
               }
                        MouseArea {
                         anchors.fill: image6
                         onClicked:
                            {
                             afterClicking(5,image6,image6A,image6B)
                              }
                      }
        }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////                                                                                            /////////
//////////                                      TILE 7                                                /////////
//////////                                                                                            /////////
//////////                                                                                            /////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Rectangle {
            color: "orange"
            border.color: "black"
            border.width: 3
            x: 15
            y: 185
            width: 70
            height: 70
            Image {
                id: image7
                visible: true
                anchors.fill: parent
                source: "qrc:/Images/empty.png"
                fillMode: Image.PreserveAspectFit
               }
            Image {
                id: image7A
                visible: false
                anchors.fill: parent
                source: "qrc:/Images/cross.png"
                fillMode: Image.PreserveAspectFit
               }
            Image {
                id: image7B
                visible: false
                anchors.fill: parent
                source: "qrc:/Images/nought.png"
                fillMode: Image.PreserveAspectFit
               }
                    MouseArea {
                     anchors.fill: image7
                     onClicked:
                        {
                         afterClicking(6,image7,image7A,image7B)
                        }
                    }
        }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////                                                                                            /////////
//////////                                        TILE 8                                              /////////
//////////                                                                                            /////////
//////////                                                                                            /////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Rectangle {
            color: "orange"
            border.color: "black"
            border.width: 3
            x: 100
            y: 185
            width: 70
            height: 70
            Image {
                id: image8
                visible: true
                anchors.fill: parent
                source: "qrc:/Images/empty.png"
                fillMode: Image.PreserveAspectFit
               }
            Image {
                id: image8A
                visible: false
                anchors.fill: parent
                source: "qrc:/Images/cross.png"
                fillMode: Image.PreserveAspectFit
               }
            Image {
                id: image8B
                visible: false
                anchors.fill: parent
                source: "qrc:/Images/nought.png"
                fillMode: Image.PreserveAspectFit
               }
                            MouseArea {
                             anchors.fill: image8
                             onClicked:
                                {
                                 afterClicking(7,image8,image8A,image8B)
                                }
                       }
        }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////                                                                                            /////////
//////////                                     TILE 9                                                 /////////
//////////                                                                                            /////////
//////////                                                                                            /////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Rectangle {
            color: "orange"
            border.color: "black"
            border.width: 3
            x: 185
            y: 185
            width: 70
            height: 70
            Image {
                id: image9
                visible: true
                anchors.fill: parent
                source: "qrc:/Images/empty.png"
                fillMode: Image.PreserveAspectFit
               }
            Image {
                id: image9A
                visible: false
                anchors.fill: parent
                source: "qrc:/Images/cross.png"
                fillMode: Image.PreserveAspectFit
               }
            Image {
                id: image9B
                visible: false
                anchors.fill: parent
                source: "qrc:/Images/nought.png"
                fillMode: Image.PreserveAspectFit
               }
                        MouseArea {

                         anchors.fill: image9
                         onClicked:
                            {
                             afterClicking(8,image9,image9A,image9B)
                            }
                    }
            }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////                                                                                            /////////
//////////                                      LINES                                                 /////////
//////////                                                                                            /////////
//////////                                                                                            /////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Rectangle {
            id: line1
            color: "gold"
            x: 10
            y: 50
            width: 250
            height: 10
            visible: false
        }
        Rectangle {
            id: line2
            color: "gold"
            x: 10
            y: 130
            width: 250
            height: 10
            visible: false
        }
        Rectangle {
            id: line3
            color: "gold"
            x: 10
            y: 215
            width: 250
            height: 10
            visible: false
        }
        Rectangle {
            id: line4
            color: "gold"
            x: 45
            y: 10
            width: 10
            height: 250
            visible: false
        }
        Rectangle {
            id: line5
            color: "gold"
            x: 130
            y: 10
            width: 10
            height: 250
            visible: false
        }
        Rectangle {
            id: line6
            color: "gold"
            x: 215
            y: 10
            width: 10
            height: 250
            visible: false
        }
        Rectangle {
            id: line7
            color: "gold"
            x: 125
            y: -15
            width: 10
            height: 320
            rotation:  135
            visible: false
        }
        Rectangle {
            id: line8
            color: "gold"
            x: 115
            y: -15
            width: 10
            height: 320
            rotation: 45
            visible: false
        }
    }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////                                                                                            /////////
//////////                                    BOTTOM_AREA                                             /////////
//////////                                                                                            /////////
//////////                                                                                            /////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    Rectangle {
        color: "lightblue"
        border.color: "black"
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
            onClicked:
            {            
                image1A.visible = false
                image1B.visible = false
                image1.visible = true
                    image2A.visible = false
                    image2B.visible = false
                    image2.visible = true
                        image3A.visible = false
                        image3B.visible = false
                        image3.visible = true
                            image4A.visible = false
                            image4B.visible = false
                            image4.visible = true
                                image5A.visible = false
                                image5B.visible = false
                                image5.visible = true
                                    image6A.visible = false
                                    image6B.visible = false
                                    image6.visible = true
                                        image7A.visible = false
                                        image7B.visible = false
                                        image7.visible = true
                                            image8A.visible = false
                                            image8B.visible = false
                                            image8.visible = true
                                                image9A.visible = false
                                                image9B.visible = false
                                                image9.visible = true
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

                if(back3.turn)
                    {
                    textField3.text = "       TURN";
                    textField4.text = " ";
                    uprec1.border.color = "red";
                    uprec2.border.color = "black";
                    }
                else
                    {
                    textField4.text = "       TURN";
                    textField3.text = " ";
                    uprec1.border.color = "black";
                    uprec2.border.color = "red";

                    }
            }
        }
    }
}

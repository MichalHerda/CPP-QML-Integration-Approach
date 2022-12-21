///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
import QtQuick
import QtQuick.Window 2.3
import QtQuick.Controls 6.5
import NoughtsAndCrosses 1.0
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////                                                              ///////////////////////////////////////
//////////////////////////////////                                                              ///////////////////////////////////////
//////////////////////////////////                         MAIN WINDOW                          ///////////////////////////////////////
//////////////////////////////////                                                              ///////////////////////////////////////
//////////////////////////////////                                                              ///////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Window {
    width: 300
    height: 500
    visible: true
    color: "darkslategrey"
    title: qsTr("Nought And Crosses")
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////                                                              ///////////////////////////////////////
//////////////////////////////////                                                              ///////////////////////////////////////
//////////////////////////////////                         BACK_END TYPES                       ///////////////////////////////////////
//////////////////////////////////                                                              ///////////////////////////////////////
//////////////////////////////////                                                              ///////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    BackEnd {
        id: back1
        onNew_game: (data) => {
                            textField1.text = "PLAYER X"            // It has to be tested
                       }                                            // Does QML requires this items
    }                                                               // Separately
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    BackEnd {
        id: back2
        onTile_clicked:  (data) => {
                             textField2.text = "PLAYER Y"
                       }
    }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////                                                              ///////////////////////////////////////
//////////////////////////////////             AREA INDICATING WHOSE MOVE IS NOW                ///////////////////////////////////////
//////////////////////////////////              AND WHAT IS CURRENTLY STATUS                    ///////////////////////////////////////
//////////////////////////////////                        OF THE GAME                           ///////////////////////////////////////
//////////////////////////////////                                                              ///////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//-------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------PLAYER X---------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------
    Rectangle {
        color: "blue"
        border.color: "black"
        border.width: 3
        x: 15
        y: 15
        width: 130
        height: 100
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       TextField {
            id: textField1
            x: 15
            y: 14
            width: 98
            height: 29
            placeholderText: qsTr("   PLAYER X")
        }
        TextField {
            id: textField3
            x: 42
            y: 57
            width: 50
            height: 29
            placeholderText: qsTr("  ")
        }
    }
//-------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------PLAYER Y---------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------
    Rectangle {
        color: "blue"
        border.color: "black"
        border.width: 3
        x: 155
        y: 15
        width: 130
        height: 100
        visible: true

        TextField {
            id: textField2
            x: 15
            y: 14
            width: 98
            height: 29          
            placeholderText: qsTr("   PLAYER Y")
        }
        TextField {
            id: textField4
            x: 39
            y: 57
            width: 50
            height: 29           
            placeholderText: qsTr(" ")
        }
    }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////                                                              ///////////////////////////////////////
//////////////////////////////////                                                              ///////////////////////////////////////
//////////////////////////////////                         GAME BOARD                           ///////////////////////////////////////
//////////////////////////////////                                                              ///////////////////////////////////////
//////////////////////////////////                                                              ///////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    Rectangle {
        color: "red"
        border.color: "black"
        border.width: 3
        x: 15
        y: 129
        width: 270
        height: 270
///////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////                                                 /////////////////////////
/////////////////////////                THE FIRST LINE                   /////////////////////////
/////////////////////////                                                 /////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
        Rectangle {
            color: "orange"
            border.color: "black"
            border.width: 3          
            x: 15
            y: 15
            width: 70
            height: 70
            Image {
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
                 image1.visible = false
                 if(back2.whose_move === true)
                     image1A.visible = true
                 if(back2.whose_move === false)
                     image1B.visible = true

 //                back2.actions_after_clicking(0,back2.whose_move, back2.tile)
             }
            }
            }

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
                 image2.visible = false
                 if(back2.whose_move === true)
                     image2A.visible = true
                 if(back2.whose_move === false)
                     image2B.visible = true
                 back2.actions_after_clicking(1,back2.whose_move)
                }
            }
        }

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
                 image3.visible = false
                 if(back2.whose_move === true)
                     image3A.visible = true
                 if(back2.whose_move === false)
                     image3B.visible = true
                 back2.actions_after_clicking(2,back2.whose_move)
                }
            }
        }
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////                                                 /////////////////////////
    /////////////////////////                  THE SECOND LINE                /////////////////////////
    /////////////////////////                                                 /////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////
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
                 image4.visible = false
                 if(back2.whose_move === true)
                     image4A.visible = true
                 if(back2.whose_move === false)
                     image4B.visible = true
                 back2.actions_after_clicking(3,back2.whose_move)
                }
            }
        }

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
                 image5.visible = false
                 if(back2.whose_move === true)
                     image5A.visible = true
                 if(back2.whose_move === false)
                     image5B.visible = true
                 back2.actions_after_clicking(4,back2.whose_move)
                }
            }

        }

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
                 image6.visible = false
                 if(back2.whose_move === true)
                     image6A.visible = true
                 if(back2.whose_move === false)
                     image6B.visible = true
                 back2.actions_after_clicking(5,back2.whose_move)
                }
            }
        }
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////                                                 /////////////////////////
    /////////////////////////                    THIRD LINE                   /////////////////////////
    /////////////////////////                                                 /////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////
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
                 image7.visible = false
                 if(back2.whose_move === true)
                     image7A.visible = true
                 if(back2.whose_move === false)
                     image7B.visible = true
                 back2.actions_after_clicking(6,back2.whose_move)
                }
            }
        }

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
                 image8.visible = false
                 if(back2.whose_move === true)
                     image8A.visible = true
                 if(back2.whose_move === false)
                     image8B.visible = true
                 back2.actions_after_clicking(7,back2.whose_move)
                }
            }
        }

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
                 image9.visible = false
                 if(back2.whose_move === true)
                     image9A.visible = true
                 if(back2.whose_move === false)
                     image9B.visible = true
                 back2.actions_after_clicking(8,back2.whose_move,tile)
                }
            }
        }


    }
///////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////                                                 /////////////////////////
/////////////////////////           BUTTON ON THE GUI BOTTOM              /////////////////////////
/////////////////////////                                                 /////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
    Rectangle {
        color: "green"
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
                textField3.text = "TURN"


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



            }


        }


    }
}

function indicateXturn(playerAreaRep, indicateColor, BorderColor) {
    playerAreaRep.itemAt(0).children[4].visible = true                                  // indicate
    playerAreaRep.itemAt(1).children[4].visible = false                                 // whose
    playerAreaRep.itemAt(0).border.color = indicateColor;                               // turn
    playerAreaRep.itemAt(1).border.color = borderColor;
}

function indicateYturn(playerAreaRep, indicateColor, BorderColor) {
    playerAreaRep.itemAt(0).children[4].visible = false
    playerAreaRep.itemAt(1).children[4].visible = true
    playerAreaRep.itemAt(0).border.color = borderColor;
    playerAreaRep.itemAt(1).border.color = indicateColor
}

function clearLinesAndBoard (repeax, linesRep) {
    for(let i = 0; i < 9; i++) {
        repeax.itemAt(i).children[0].visible = true
        repeax.itemAt(i).children[1].visible = false
        repeax.itemAt(i).children[2].visible = false

        if(i < 8) {
            console.log(i," visible: ",linesRep.itemAt(i).visible)                          // clear board from lines
            linesRep.itemAt(i).visible = false                                              // after winning game
        }
    }
}

function drawLine (i, playerAreaRep, linesRep) {
    linesRep.itemAt(i - 1).visible = true;
    playerAreaRep.itemAt(0).children[2].visible = true
    playerAreaRep.itemAt(1).children[3].visible = true
    playerAreaRep.itemAt(0).children[4].visible = false
    playerAreaRep.itemAt(1).children[4].visible = false
}

function initialState (playerAreaRep) {
    playerAreaRep.itemAt(0).children[0].visible = true
    playerAreaRep.itemAt(0).children[1].visible = false
    playerAreaRep.itemAt(0).children[2].visible = true
    playerAreaRep.itemAt(0).children[3].visible = false
    playerAreaRep.itemAt(0).children[4].visible = false

    playerAreaRep.itemAt(1).children[0].visible = false
    playerAreaRep.itemAt(1).children[1].visible = true
    playerAreaRep.itemAt(1).children[2].visible = false
    playerAreaRep.itemAt(1).children[3].visible = true
    playerAreaRep.itemAt(1).children[4].visible = false
}

function pressStartClear(playerAreaRep) {
    playerAreaRep.itemAt(0).children[2].visible = false
    playerAreaRep.itemAt(1).children[3].visible = false
}

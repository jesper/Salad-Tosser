var saladArray = null;
var componentSaladItem;
var componentInsectItem;
var gameStarted = false;
var nbPieces = 40;
var nbInsects = 5;


function startGame() {
    if (gameStarted) {
        return;
    }

    gameStarted = true;

    //Delete blocks from previous game
//     for (var i = 0; i < maxIndex; i++) {
//         if (board[i] != null)
//             board[i].destroy();
//     }

     //Calculate board size
//     maxColumn = Math.floor(background.width / blockSize);
//     maxRow = Math.floor(background.height / blockSize);
//     maxIndex = maxRow * maxColumn;

     //Initialize Board
    saladArray = new Array(nbPieces + nbInsects);
    var i;

    for (i = 0; i < nbPieces; ++i) {
        saladArray[i] = createSaladItem();
    }
    for (; i < nbPieces + nbInsects; ++i) {
        saladArray[i] = createInsectItem();
    }

    insectsCount.numberOfInsectsRemaining = nbInsects;

    // Countdown init.
    countdown.sec = 30;
    countdown.min = 0;
    countdown.freeze = false;
}

function createSaladItem() {
    if (componentSaladItem == null)
        componentSaladItem = Qt.createComponent("SaladItem.qml");

    var saladItem = componentSaladItem.createObject(gamearea);
    if (saladItem == null) {
        console.log("error creating saladItem");
        console.log(componentSaladItem.errorString());
        return null;
    }

    saladItem.width = Math.random() * 100 + 50;
    saladItem.height = Math.random() * 100 + 50;

    saladItem.x = Math.random() * (gamearea.width - saladItem.width);
    saladItem.y = Math.random() * (gamearea.height - saladItem.height);
    saladItem.z = 2 + Math.random() * (nbPieces + nbInsects);
    saladItem.rotation = Math.random() * 360;
    return saladItem;
}

function createInsectItem() {
    if (componentInsectItem == null)
        componentInsectItem = Qt.createComponent("Insect.qml");

    var insectItem = componentInsectItem.createObject(gamearea);
    if (insectItem == null) {
        console.log("error creating insectItem");
        console.log(componentInsectItem.errorString());
        return null;
    }

    insectItem.width = Math.random() * 30 + 40;
    insectItem.height = Math.random() * 30 + 40;

    insectItem.x = Math.random() * (gamearea.width - insectItem.width);
    insectItem.y = Math.random() * (gamearea.height - insectItem.height);
    insectItem.z = 1;

    return insectItem;
}

// Shake the salad!
// It will move leaves and insects, changing their position and depth.
function shaking(x, y) {
    if (saladArray == null)
        return;
    for (var i = 0; i < nbPieces + nbInsects; ++i) {
        var new_x = saladArray[i].x + (Math.random() + 0.5) * 6 * x + (Math.random() - 0.5) * 160;
        var new_y = saladArray[i].y + (Math.random() + 0.5) * 6 * y + (Math.random() - 0.5) * 160;

        saladArray[i].x = Math.max(0,
            Math.min(gamearea.width - saladArray[i].width, new_x));
        saladArray[i].y = Math.max(0,
            Math.min(gamearea.height - saladArray[i].height, new_y));

        if (i < nbPieces) {
            saladArray[i].rotation = Math.random() * 360;
            saladArray[i].state = "shaking";
        }
    }
}

// We just killed one insect (yay!).
// We now need to update the count of remaining insects.
function insectKilled() {
    --insectsCount.numberOfInsectsRemaining;
    if (insectsCount.numberOfInsectsRemaining == 0) {
        // We win the game \o/
        gameOver("win");
    }
}

// The game is over.
function gameOver(type) {
    countdown.freeze = true

    if (type == "win") {
        console.log("You won the game! Congrats!")
    } else if (type == "timeout") {

    } else {
        console.log("Error: unsupported type of game over \"" + type + "\"")
    }

}

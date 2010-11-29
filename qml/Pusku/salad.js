var saladArray;
var componentSaladItem;
var componentInsectItem;
var gameStarted = false;
var nbPieces = 20;
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
}

function createSaladItem() {
    if (componentSaladItem == null)
        componentSaladItem = Qt.createComponent("SaladItem.qml");

    var saladItem = componentSaladItem.createObject(gamescreen);
    if (saladItem == null) {
        console.log("error creating saladItem");
        console.log(componentSaladItem.errorString());
        return null;
    }

    saladItem.width = Math.random() * 100 + 50;
    saladItem.height = Math.random() * 100 + 50;

    saladItem.x = Math.random() * (gamescreen.width - saladItem.width);
    saladItem.y = Math.random() * (gamescreen.height - saladItem.height);
    saladItem.z = Math.random() * (nbPieces + nbInsects);
    saladItem.rotation = Math.random() * 360;
    return saladItem;
}

function createInsectItem() {
    if (componentInsectItem == null)
        componentInsectItem = Qt.createComponent("Insect.qml");

    var insectItem = componentInsectItem.createObject(gamescreen);
    if (insectItem == null) {
        console.log("error creating insectItem");
        console.log(componentInsectItem.errorString());
        return null;
    }

    insectItem.width = Math.random() * 30 + 20;
    insectItem.height = Math.random() * 30 + 20;

    insectItem.x = Math.random() * (gamescreen.width - insectItem.width);
    insectItem.y = Math.random() * (gamescreen.height - insectItem.height);
    insectItem.rotation = Math.random() * 360;
    return insectItem;
}

function shaking() {
    for (var i = 0; i < nbPieces + nbInsects; ++i) {
        saladArray[i].x += (Math.random() - 0.5) * 50;
        saladArray[i].y += (Math.random() - 0.5) * 50;
        saladArray[i].z = Math.random() * (nbPieces + nbInsects);
        saladArray[i].rotation = Math.random() * 360;
        saladArray[i].state = "shaking";
    }
}

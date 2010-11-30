var saladArray;
var componentSaladItem;
var componentInsectItem;
var gameStarted = false;
var nbPieces = 20;
var nbInsects = 5;
var nbInsectsRemaining = 0;


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
    nbInsectsRemaining = nbInsects;
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
//    insectItem.rotation = Math.random() * 360;
    return insectItem;
}

function shaking() {
    for (var i = 0; i < nbPieces + nbInsects; ++i) {
        var new_x = saladArray[i].x + (Math.random() - 0.5) * 200;
        var new_y = saladArray[i].y + (Math.random() - 0.5) * 200;

        saladArray[i].x = Math.max(0,
            Math.min(gamescreen.width - saladArray[i].width, new_x));
        saladArray[i].y = Math.max(0,
            Math.min(gamescreen.height - saladArray[i].height, new_y));

        saladArray[i].z = Math.random() * (nbPieces + nbInsects);
        if (i < nbPieces) {
            saladArray[i].rotation = Math.random() * 360;
            saladArray[i].state = "shaking";
        }
    }
    console.log("shaking!");
}

function getNbInsectRemaining() {
    return nbInsectsRemaining.toString();
}

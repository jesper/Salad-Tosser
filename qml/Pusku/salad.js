var saladArray = null;
var componentSaladItem = null;
var componentInsectItem = null;
var componentScorpionItem = null;
var componentScoreIncrement = null;
var componentTimeBonus = null;
var gameStarted = false;
var nbPieces = 15;
var nbInsects = 5;
var nbScorpions = 2;

var scorpionArray = null;
var gameOverType;

function restartGame() {
    nbPieces = 15;
    nbScorpions = 2;

    gameStarted = false;
    gamescreen.level = 1;
    scoreBox.score = 0;
    startGame();
}

function levelUp() {
    nbPieces += 4;
    nbScorpions += 1;

    gamescreen.level++;

    var timeBonus = Math.floor((countdown.realTime-1) / 5);

    if (timeBonus >= 1) {
        timeBonusText.text = "Good job, time bonus: " + timeBonus + "!";
    } else {
        timeBonusText.text = "Phew, close call!";
    }

    createScoreIncrement(timeBonus);

    gameStarted = false;
    gamescreen.running = false;

    levelUpAnimation.restart();
}

function startGame() {
    if (gameStarted) {
        return;
    }

    // Countdown init.
    countdown.sec = 20;
    countdown.min = 0;
    countdown.freeze = false;
    countdownText.text = "0:20"

    gamescreen.running = true;

    gameStarted = true;

    var i;
    if (saladArray != null) {
        for (i = 0; i < saladArray.length; ++i) {
            saladArray[i].destroy();
        }
    }

     //Initialize Board
    saladArray = new Array(nbPieces + nbInsects);

    for (i = 0; i < nbPieces; ++i) {
        saladArray[i] = createSaladItem();
    }
    for (; i < nbPieces + nbInsects; ++i) {
        saladArray[i] = createInsectItem();
    }

    scorpionArray = new Array(nbScorpions);

    for (i = 0; i < nbScorpions; ++i) {
        scorpionArray[i] = createScorpionItem();
        saladArray[saladArray.length] = scorpionArray[i];
    }

    insectsCount.numberOfInsectsRemaining = nbInsects;

    health.healthCount = 2;
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

    var size = Math.random() * 30 + 110;

    // We make the tomatoes smaller.
    if (saladItem.type == 3) {
        size = size * 0.7;
    }

    saladItem.width = size;
    saladItem.height = size;

    saladItem.x = Math.random() * (gamearea.width - saladItem.width);
    saladItem.y = Math.random() * (gamearea.height - saladItem.height);
    saladItem.z = 3 + Math.random() * (nbPieces + nbInsects);
    saladItem.rotation = Math.random() * 360;

    saladItem.shakeFactor = 1.0;

    saladItem.placed = true;

    return saladItem;
}

function createScorpionItem() {
    if (componentScorpionItem == null)
        componentScorpionItem = Qt.createComponent("Scorpion.qml");

    var scorpionItem = componentScorpionItem.createObject(gamearea);
    if (scorpionItem == null) {
        console.log("error creating scorpionItem");
        console.log(componentScorpionItem.errorString());
        return null;
    }

    scorpionItem.width = 140;
    scorpionItem.height = 140;
    scorpionItem.x = Math.random() * (gamearea.width - scorpionItem.width);
    scorpionItem.y = Math.random() * (gamearea.height - scorpionItem.height);
    scorpionItem.z = 2;

    scorpionItem.shakeFactor = 0.8;

    scorpionItem.placed = true;

    return scorpionItem;
}

function moveScorpion(scorpionItem) {
    var new_x;
    var new_y;

    do {
        var dir_x = Math.random() - 0.5;
        var dir_y = Math.random() - 0.5;

        var inv_len = 1 / Math.sqrt(dir_x * dir_x + dir_y * dir_y);
        dir_x *= inv_len;
        dir_y *= inv_len;

        new_x = scorpionItem.x + dir_x * 120;
        new_y = scorpionItem.y + dir_y * 120;
    } while (new_x < 0 || new_x > (gamearea.width - scorpionItem.width)
             || new_y < 0 || new_y > (gamearea.height - scorpionItem.height));

    scorpionItem.x = new_x;
    scorpionItem.y = new_y;
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

    var size = 75;

    // We make the lady bugs smaller.
    if (insectItem.type == 1) {
        size = size * 0.7;
    }

    insectItem.width = size;
    insectItem.height = size;

    insectItem.x = Math.random() * (gamearea.width - insectItem.width);
    insectItem.y = Math.random() * (gamearea.height - insectItem.height);
    insectItem.z = 2;

    insectItem.shakeFactor = 0.9;

    insectItem.placed = true;

    return insectItem;
}

// Shake the salad!
function shaking(x, y) {
    if (saladArray == null || !gamescreen.running)
        return;

    audio.playShake();

    for (var i = 0; i < scorpionArray.length; ++i) {
        scorpionArray[i].shake();
    }

    for (var i = 0; i < saladArray.length; ++i) {
        var new_x = saladArray[i].x + saladArray[i].shakeFactor * ((Math.random() + 0.5) * 6 * x + (Math.random() - 0.5) * 160);
        var new_y = saladArray[i].y + saladArray[i].shakeFactor * ((Math.random() + 0.5) * 6 * y + (Math.random() - 0.5) * 160);

        if (saladArray[i].state == "dead")
            continue;

        saladArray[i].x = Math.max(0,
            Math.min(gamearea.width - saladArray[i].width, new_x));
        saladArray[i].y = Math.max(0,
            Math.min(gamearea.height - saladArray[i].height, new_y));

        if (i < nbPieces) {
            saladArray[i].rotation += Math.random() * 20;
            saladArray[i].state = "shaking";
        }
    }
}

// We just killed one insect (yay!).
// We now need to update the count of remaining insects.
function insectKilled(insect) {
    if (insect.type == 0)
        audio.playSquash();
    else
        audio.playSquish();
    --insectsCount.numberOfInsectsRemaining;

    createScoreIncrement(1);
    createTimeBonus();

    if (insectsCount.numberOfInsectsRemaining == 0) {
        // next level!
        levelUp();
    }
}

// We just got bitten by one insect (/o\).
// We now need to update our health.
function bittenByInsect() {
    audio.playOuch();
    --health.healthCount;

    createScoreIncrement(-2);

    if (health.healthCount == 0) {
        gameOver("dead");
    }
}

function gameOver(type)
{
    gameOverType = type;

    gamescreen.running = false;
    countdown.freeze = true;

    gameOverAnimation.start();
}

// The game is over.
function gameOverScreen() {
    var high = updateHighScore();

    var highText = high;

    gameoverMenu.highScoreText =
        high < scoreBox.score ? "New high!" : "High: " + highText;

    if (gameOverType == "timeout") {
        gameoverMenu.source = "alarm.svg"
        console.log("game over, score: " + scoreBox.score + ", high: " + high);
    } else if (gameOverType == "dead") {
        gameoverMenu.source = "scorpion.svg"
    } else {
        console.log("Error: unsupported type of game over \"" + gameOverType + "\"")
    }

    gameoverMenu.opacity = 1
    gameStarted = false;
}

function updateHighScore(score) {
    var db = openDatabaseSync("SaladTossHighScore", "1.0", "Salad Tosser Highscore", 100);

    var high = 0;
    db.transaction(
        function(tx) {
            // Create the database if it doesn't already exist
            tx.executeSql('CREATE TABLE IF NOT EXISTS Scores(score INTEGER)');

            var result = tx.executeSql('SELECT * FROM Scores ORDER BY score DESC').rows;
            if (result.length != 0)
                high = result.item(0).score;

            if (high == undefined || high == null)
                high = 0;

            // Insert new high
            if (scoreBox.score > high) {
                tx.executeSql('DELETE FROM Scores');
                tx.executeSql('INSERT INTO Scores VALUES(?)', [ scoreBox.score ]);
            }
        }
    )

    return high;
}

function updateTimerString() {
    if (countdown.sec > 9) {
        countdown.secString = countdown.sec
    } else {
        countdown.secString = "0" + countdown.sec
    }
    countdownText.text = countdown.min + ":" + countdown.secString
}

var timeBonusCount = 0;

function createTimeBonus() {
    if (componentTimeBonus == null)
        componentTimeBonus = Qt.createComponent("TimeBonus.qml");

    var timeBonus = componentTimeBonus.createObject(gamescreen);
    if (timeBonus == null) {
        console.log("error creating timeBonus");
        console.log(componentTimeBonus.errorString());
        return null;
    }

    ++timeBonusCount;
    gamescreen.timerPaused = true;

    countdown.realTime += 3;

    timeBonus.startAnimation();
}

function destroyTimeBonus(timeBonus)
{
    --timeBonusCount;
    if (timeBonusCount == 0)
        gamescreen.timerPaused = false;
    timeBonus.destroy();
}

function createScoreIncrement(increment) {
    if (componentScoreIncrement == null)
        componentScoreIncrement = Qt.createComponent("ScoreIncrement.qml");

    var scoreIncrement = componentScoreIncrement.createObject(gamescreen);
    if (scoreIncrement == null) {
        console.log("error creating scoreIncrement");
        console.log(componentScoreIncrement.errorString());
        return null;
    }

    scoreIncrement.increment = Math.abs(increment);
    scoreIncrement.sign = increment > 0 ? 1 : -1;

    scoreIncrement.startAnimation();
}

function destroyScoreIncrement(scoreIncrement)
{
    scoreIncrement.destroy();
}

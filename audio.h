#ifndef AUDIO_H
#define AUDIO_H
#include <QMediaPlayer>
#include <QFileInfo>
#include <QDebug>
#include <QCoreApplication>

class Player : public QObject {
public:
    Player(const QUrl &url, int instances = 1, QObject *parent = 0)
        : QObject(parent)
        , m_index(0)
    {
        instances = qMax(1, instances);
        for (int i = 0; i < instances; ++i) {
            QMediaPlayer *player = new QMediaPlayer(this);
            player->setMedia(url);
            m_players << player;
        }
    }

    void play()
    {
        m_players.at(m_index)->play();
        m_index++;
        if (m_index >= m_players.size())
            m_index = 0;
    }

private:
    QVector<QMediaPlayer *> m_players;
    int m_index;
};

class Audio : public QObject {
    Q_OBJECT

    enum Sound {
        StartGame,
        Click,
        About,
        Ouch,
        Quit,
        ReturnToGame,
        ReturnToMenu,
        Squish,
        Squash,
        Shake,
        NumSounds,
        Theme,
        LevelUp,
        Death,
        Arite,
        Beep
    };

public:
    Audio(QString path) {
        m_path = path;


    }

    void startLoadingSounds() {
        loadSound(StartGame, "startgame.mp3");
        emit loaded("Sound file you'll hear once");

        loadSound(Click, "click.mp3");
        emit loaded("Don't think we even use this sound file anymore");

        loadSound(About, "about.mp3");
        emit loaded("Sammi made this sound");

        loadSound(Ouch, "ouch.mp3");
        emit loaded("This is what happens when you touch a scorpion!");

        loadSound(Quit, "quit.mp3");
        emit loaded("Let's hope you never hear this sound");

        loadSound(ReturnToGame, "returntogame.mp3");
        emit loaded("'Fab'ulous sound file!");

        loadSound(ReturnToMenu, "returntomenu.mp3");
        emit loaded("Most likely true sound file");

        loadSound(Squish, "squish.mp3", 3);
        emit loaded("Best sound file in the game");

        loadSound(Squash, "squish2.mp3", 3);
        emit loaded("Yet another squashing sound");

        loadSound(Shake, "shake.mp3");
        emit loaded("Jefe's dancing style");

        loadSound(LevelUp, "levelup.mp3");
        emit loaded("Fab sounding like the koolaid guy");

        loadSound(Death, "death.mp3");
        emit loaded("Jefe style trombone");

        loadSound(Theme, "theme.mp3");
        emit loaded("Best theme song ever, worth the wait");

        loadSound(Arite, "arite.mp3");
        emit loaded("Giggidi");

        loadSound(Beep, "beep.mp3");
        emit loaded("You'll hate hearing this sound");
    }

public slots:
    void play(Sound sound) {
        if (m_players.at(sound))
            m_players.at(sound)->play();
    }

    void playStartGame() {
        play(StartGame);
    }

    void playClick() {
        play(Click);
    }

    void playAbout() {
        play(About);
    }

    void playOuch() {
        play(Ouch);
    }

    void playQuit() {
        play(Quit);
    }

    void playReturnToGame() {
        play(ReturnToGame);
    }

    void playReturnToMenu() {
        play(ReturnToMenu);
    }

    void playSquish() {
        play(Squish);
    }

    void playSquash() {
        play(Squash);
    }

    void playShake() {
        play(Shake);
    }

    void playDeath() {
        play(Death);
    }

    void playLevelUp() {
        play(LevelUp);
    }

    void playTheme() {
        play(Theme);
    }

    void playArite() {
        play(Arite);
    }

    void playBeep() {
        play(Beep);
    }

signals:
    void loaded(QString file);

private:
    void loadSound(Sound sound, const QString &filename, int instances = 1) {
        if (m_players.size() <= sound)
            m_players.resize(sound + 1);
        m_players[sound] = new Player(QUrl::fromLocalFile(m_path + "/" + filename), instances, this);
    }

    QVector<Player *> m_players;

    QString m_path;
};

#endif // AUDIO_H

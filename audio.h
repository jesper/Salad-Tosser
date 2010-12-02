#ifndef AUDIO_H
#define AUDIO_H
#include <QtMultimediaKit/QMediaPlayer>
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
        Shake,
        NumSounds
    };

public:
    Audio(QString path) {
        m_path = path;


    }

    void startLoadingSounds() {
        loadSound(StartGame, "startgame.mp3");
        emit loaded("sound file you'll hear once");

        loadSound(Click, "click.mp3");
        emit loaded("don't think we even use this sound file anymore");

        loadSound(About, "about.mp3");
        emit loaded("sammi made this sound");

        loadSound(Ouch, "ouch.mp3");
        emit loaded("this is what happens when you touch a scorpion!");

        loadSound(Quit, "quit.mp3");
        emit loaded("let's hope you never hear this sound");

        loadSound(ReturnToGame, "returntogame.mp3");
        emit loaded("'fab'ulous sound file!");

        loadSound(ReturnToMenu, "returntomenu.mp3");
        emit loaded("most likely true sound file");

        loadSound(Squish, "squish.mp3", 3);
        emit loaded("best sound file in the game");

        loadSound(Shake, "shake.mp3");
        emit loaded("Jefe's dancing style");

    }

public slots:
    void play(Sound sound) {
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

    void playShake() {
        play(Shake);
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

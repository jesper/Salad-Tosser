#ifndef AUDIO_H
#define AUDIO_H
#include <QtMultimediaKit/QMediaPlayer>
#include <QFileInfo>
#include <QDebug>
#include <QCoreApplication>

class Audio : public QObject {
    Q_OBJECT

public:
    Audio(QString path) {
        m_path = path;

        m_startGame_player = new QMediaPlayer;
        m_startGame_player->setMedia(QUrl::fromLocalFile(m_path+"/startgame.mp3"));

        m_click_player = new QMediaPlayer;
        m_click_player->setMedia(QUrl::fromLocalFile(m_path+"/click.mp3"));

        m_about_player = new QMediaPlayer;
        m_about_player->setMedia(QUrl::fromLocalFile(m_path+"/about.mp3"));

        m_ouch_player = new QMediaPlayer;
        m_ouch_player->setMedia(QUrl::fromLocalFile(m_path+"/ouch.mp3"));

        m_quit_player = new QMediaPlayer;
        m_quit_player->setMedia(QUrl::fromLocalFile(m_path+"/quit.mp3"));

        m_returnToGame_player = new QMediaPlayer;
        m_returnToGame_player->setMedia(QUrl::fromLocalFile(m_path+"/returntogame.mp3"));

        m_returnToMenu_player = new QMediaPlayer;
        m_returnToMenu_player->setMedia(QUrl::fromLocalFile(m_path+"/returntomenu.mp3"));

        m_squish_player = new QMediaPlayer;
        m_squish_player->setMedia(QUrl::fromLocalFile(m_path+"/squish.mp3"));

        m_shake_player = new QMediaPlayer;
        m_shake_player->setMedia(QUrl::fromLocalFile(m_path+"/shake.mp3"));
    };

public slots:
    void playClick() {
        m_click_player->play();
    }
    void playAbout() {
        m_about_player->play();
    }

    void playOuch() {
        m_ouch_player->play();
    }

    void playQuit() {
        m_quit_player->play();
    }

    void playReturnToGame() {
        m_returnToGame_player->play();
    }

    void playReturnToMenu() {
        m_returnToMenu_player->play();
    }

    void playShake() {
        m_shake_player->play();
    }

    void playStartGame() {
        m_startGame_player->play();
    }

    void playSquish() {
        m_squish_player->play();
    }

private:
    QMediaPlayer *m_click_player;
    QMediaPlayer *m_about_player;
    QMediaPlayer *m_ouch_player;
    QMediaPlayer *m_quit_player;
    QMediaPlayer *m_returnToGame_player;
    QMediaPlayer *m_returnToMenu_player;
    QMediaPlayer *m_shake_player;
    QMediaPlayer *m_startGame_player;
    QMediaPlayer *m_squish_player;

    QString m_path;
};

#endif // AUDIO_H

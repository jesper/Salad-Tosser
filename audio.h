#ifndef AUDIO_H
#define AUDIO_H
#include <QtMultimediaKit/QMediaPlayer>

class Audio : public QObject {
    Q_OBJECT

public:
    Audio() {
        m_player = new QMediaPlayer;
        m_player->setMedia(QUrl::fromLocalFile("/opt/usr/share/Pusku/qml/Pusku/click.mp3"));
        m_player->setVolume(100);
    };

public slots:
    void play() {
        m_player->play();
        qDebug("Played yo");
    }
private:
    QMediaPlayer *m_player;
};

#endif // AUDIO_H

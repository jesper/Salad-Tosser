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
        m_click_player = new QMediaPlayer;
        m_click_player->setMedia(QUrl::fromLocalFile(m_path+"/click.mp3"));
    };

public slots:
    void playClick() {
        m_click_player->play();
    }
private:
    QMediaPlayer *m_click_player;
    QString m_path;
};

#endif // AUDIO_H

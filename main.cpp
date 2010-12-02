#include <QtGui/QApplication>
#include <QtGui/QGraphicsObject>
#include <QtGui/QVector3D>
#include <QtOpenGL/QGLWidget>
#include <QtDeclarative/QDeclarativeContext>
#include <QDir>

#include "qmlapplicationviewer.h"
#include "accelerometer.h"
#include "audio.h"
#include <cstdio>


Accelerometer::Accelerometer()
    : m_accelerometer(new QtMobility::QAccelerometer(this))
{
    connect(m_accelerometer, SIGNAL(readingChanged()), this, SLOT(checkReading()));
    m_accelerometer->start();
}

Accelerometer::~Accelerometer()
{
    m_accelerometer->stop();
}

void Accelerometer::checkReading()
{
    QtMobility::QAccelerometerReading *reading = m_accelerometer->reading();

    if (QVector3D(reading->x(), reading->y(), reading->z()).length() > 16.0)
        emit shake(-reading->x(), reading->y());
}

bool Accelerometer::isEnabled()
{
    return m_accelerometer->isConnectedToBackend() && m_accelerometer->isActive();
}

int main(int argc, char *argv[])
{
    QApplication::setGraphicsSystem("raster");
    QApplication app(argc, argv);

    Accelerometer accelerometer;

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);
    viewer.setMainQmlFile(QLatin1String("qml/Pusku/main.qml"));

// *Horrible hack* to get the path of the sound files (same location as qml files)
    Audio audio(QFileInfo(viewer.source().toLocalFile()).absoluteDir().path());

    viewer.rootContext()->setContextProperty("audio", &audio);
    viewer.rootContext()->setContextProperty("accelerometer", &accelerometer);
    viewer.setViewport(new QGLWidget);
    viewer.showFullScreen();

    QObject::connect(&accelerometer, SIGNAL(shake(QVariant, QVariant)),
                     viewer.rootObject(), SLOT(shake(QVariant, QVariant)));

    return app.exec();
}

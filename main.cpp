#include <QtGui/QApplication>
#include <QtGui/QGraphicsObject>
#include <QtGui/QVector3D>
#include <QtOpenGL/QGLWidget>
#include <QtDeclarative/QDeclarativeContext>

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

int main(int argc, char *argv[])
{
    QApplication::setGraphicsSystem("raster");
    QApplication app(argc, argv);

    Accelerometer accelerometer;
    Audio audio;

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);
    viewer.setMainQmlFile(QLatin1String("qml/Pusku/main.qml"));

    viewer.rootContext()->setContextProperty("audio", &audio);
    viewer.setViewport(new QGLWidget);
    viewer.showFullScreen();

    QObject::connect(&accelerometer, SIGNAL(shake(QVariant, QVariant)),
                     viewer.rootObject(), SLOT(shake(QVariant, QVariant)));

    return app.exec();
}

#include <QtGui/QApplication>
#include <QtGui/QGraphicsObject>
#include <QtGui/QVector3D>

#include "qmlapplicationviewer.h"
#include "accelerometer.h"

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

    if (QVector3D(reading->x(), reading->y(), reading->z()).length() > 20.0)
        emit shake();
}

int main(int argc, char *argv[])
{
    QApplication::setGraphicsSystem("raster");
    QApplication app(argc, argv);

    printf("Starting accelerometer\n");
    Accelerometer accelerometer;

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);
    viewer.setMainQmlFile(QLatin1String("qml/Pusku/main.qml"));
    viewer.showExpanded();

    QObject::connect(&accelerometer, SIGNAL(shake()),
                     viewer.rootObject(), SLOT(shake()));
    return app.exec();
}

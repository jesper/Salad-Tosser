#include <QtGui/QApplication>
#include <QtGui/QGraphicsObject>
#include <QtGui/QVector3D>
#include <QtOpenGL/QGLWidget>
#include <QtDeclarative/QDeclarativeContext>
#include <QDir>
#include <QLayout>

#if defined(Q_OS_SYMBIAN)
#include <eikenv.h>
#include <eikappui.h>
#include <aknenv.h>
#include <aknappui.h>
#endif // Q_OS_SYMBIAN

#include "loadscreen.h"
#include "helper.h"
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
    {
#ifdef Q_OS_SYMBIAN
        emit shake(reading->y(), reading->x());
#else
        emit shake(-reading->x(), reading->y());
#endif
    }
}

bool Accelerometer::isEnabled()
{
    return m_accelerometer->isConnectedToBackend() && m_accelerometer->isActive();
}

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QApplication::setGraphicsSystem("opengl");

#ifdef Q_WS_MAEMO_5
    app.setStyle("plastique"); //Looks better than native style IMO
    QApplication::setGraphicsSystem("raster");
#endif

#ifdef Q_OS_SYMBIAN
    CAknAppUi* appUi = dynamic_cast<CAknAppUi*> (CEikonEnv::Static()->AppUi());

    if (appUi)
        appUi->SetOrientationL(CAknAppUi::EAppUiOrientationLandscape);
#endif

    Accelerometer accelerometer;

    LoadScreen loadScreen;
    loadScreen.setItemsToLoadCount(19);

    loadScreen.showFullScreen();
    loadScreen.repaint();

    app.processEvents();

    Helper helper;
    loadScreen.itemLoaded("Analyzing device specs");

    QmlApplicationViewer viewer;
    loadScreen.itemLoaded("Next-Gen Graphics Engine");
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);

    loadScreen.itemLoaded("Salad Logic");
    viewer.rootContext()->setContextProperty("helper", &helper);
    viewer.setMainQmlFile(QLatin1String("qml/Pusku/main.qml"));

    loadScreen.itemLoaded("Cinematic Quality Audio");
    // *Horrible hack* to get the path of the sound files (same location as qml files)
    Audio audio(QFileInfo(viewer.source().toLocalFile()).absoluteDir().path());
    QObject::connect(&audio, SIGNAL(loaded(QString)), &loadScreen, SLOT(itemLoaded(QString)));
    audio.startLoadingSounds();

    viewer.rootContext()->setContextProperty("audio", &audio);
    viewer.rootContext()->setContextProperty("accelerometer", &accelerometer);

    loadScreen.itemLoaded("Enabling bling");
    viewer.setViewport(new QGLWidget);


    QObject::connect(&accelerometer, SIGNAL(shake(QVariant, QVariant)),
                     viewer.rootObject(), SLOT(shake(QVariant, QVariant)));


    viewer.showFullScreen();
    loadScreen.hide();
    return app.exec();
}

#ifndef ACCELEROMETER_H
#define ACCELEROMETER_H

#include <QtSensors/QAccelerometer>

class Accelerometer : public QObject
{
    Q_OBJECT
public:
    Accelerometer();
    ~Accelerometer();

public slots:
    void checkReading();
    bool isEnabled();

signals:
    void shake(QVariant x, QVariant y);

private:
    QtMobility::QAccelerometer *m_accelerometer;
};


#endif // ACCELEROMETER_H

#ifndef HELPERS_H
#define HELPERS_H

#include <QApplication>
#include <QDesktopWidget>

class Helper : public QObject
{
    Q_OBJECT

public:
    Helper() {
        QDesktopWidget *desktop = QApplication::desktop();
        m_screenWidth = desktop->geometry().width();
        m_screenHeight = desktop->geometry().height();
    }

public slots:
    int getScreenWidth() { return m_screenWidth; };
    int getScreenHeight(){ return m_screenHeight; };

private:
    int m_screenWidth;
    int m_screenHeight;
};

#endif // HELPERS_H

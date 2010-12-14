#ifndef LOADSCREEN_H
#define LOADSCREEN_H

#include <QWidget>
#include <QDeclarativeView>
namespace Ui {
    class LoadScreen;
}

class LoadScreen : public QWidget
{
    Q_OBJECT

public:
    explicit LoadScreen(QWidget *parent = 0);
    ~LoadScreen();
    void setItemsToLoadCount(int count);
    void resourcesReady();

public slots:
    void itemLoaded(QString item);
    void declarativeStatusUpdate(QDeclarativeView::Status status);

private:
    void hideIfReady();

    Ui::LoadScreen *ui;
    int m_itemsToLoadCount;
    int m_loadedCount;
    bool m_declarativeReady;
    bool m_resourcesReady;
};

#endif // LOADSCREEN_H

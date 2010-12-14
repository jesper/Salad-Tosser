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

public slots:
    void itemLoaded(QString item);
    void hideMe(QDeclarativeView::Status status);

private:
    Ui::LoadScreen *ui;
    int m_itemsToLoadCount;
    int m_loadedCount;
};

#endif // LOADSCREEN_H

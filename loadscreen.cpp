#include "loadscreen.h"
#include "ui_loadscreen.h"
#include <QDebug>

LoadScreen::LoadScreen(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::LoadScreen)
{
    ui->setupUi(this);
    ui->logo->setPixmap(QPixmap(":images/qml/Pusku/tossmysalad.png"));

    m_loadedCount = 0;
    m_itemsToLoadCount = 0;
}

void LoadScreen::itemLoaded(QString item)
{
    ui->loadText->setText(item);
    m_loadedCount++;
    float progress = (float)m_loadedCount/m_itemsToLoadCount * 100;
    ui->loadProgress->setValue(progress);
}

void LoadScreen::setItemsToLoadCount(int count)
{
    m_itemsToLoadCount = count;
}

LoadScreen::~LoadScreen()
{
    delete ui;
}

void LoadScreen::hideMe(QDeclarativeView::Status status)
{
    if (status == QDeclarativeView::Ready)
        hide();
}

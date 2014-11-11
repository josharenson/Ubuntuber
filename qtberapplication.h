#ifndef QTBERAPPLICATION_H_
#define QTBERAPPLICATION_H_

#include <QtQuick/QQuickView>
#include <QGuiApplication>

class QtBerApplication : public QGuiApplication
{

    Q_OBJECT
public:
    QtBerApplication(int &argc, char **argv);
    virtual ~QtBerApplication();
    bool setup();

private:
    QScopedPointer<QQuickView> m_view;
};

#endif // QTBERAPPLICATION_H_

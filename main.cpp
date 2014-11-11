#include <QGuiApplication>
#include <QtQml/QQmlDebuggingEnabler>

#include "qtberapplication.h"
#include "config.h"

static QQmlDebuggingEnabler debuggingEnabler(false);

int main(int argc, char** argv)
{
//    QGuiApplication::setApplicationName("com.gmail.josharenson.camera");
    QtBerApplication application(argc, argv);
    if (!application.setup()) {return 0;}
    return application.exec();
}

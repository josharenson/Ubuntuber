#include <QtQuick>

#include "plugin.h"

#include "configfile.h"

void QtBerPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(uri == QLatin1String("QtBer"));

    qmlRegisterType<ConfigFile>(uri, 0, 1, "ConfigFile");
}

void QtBerPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    QQmlExtensionPlugin::initializeEngine(engine, uri);
}

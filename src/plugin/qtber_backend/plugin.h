#ifndef QTBER_PLUGIN_H_
#define QTBER_PLUGIN_H_

#include <QtQml/QQmlEngine>
#include <QtQml/QQmlExtensionPlugin>

class QtBerPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

    public:
        void registerTypes(const char *uri);
        void initializeEngine(QQmlEngine *engine, const char *uri);
};

#endif /* QTBER_PLUGIN_H_  */

/*
 * Copyright (C) 2014, 2015 Josh Arenson
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <QCommandLineParser>
#include <QtGui/QGuiApplication>
#include <QtQuick/QQuickView>
#include <QtQml/QtQml>
#include <QDir>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    /* Argument Parsing */
    QCommandLineParser parser;
    parser.setApplicationDescription("Description: \
        A native Uber clone for Ubuntu Touch");
    parser.addHelpOption();
    parser.addVersionOption();
    QCommandLineOption clearSettingsOption(
        {"c","clear-settings"},
        "Clear the application's persistent settings.");
    parser.addOption(clearSettingsOption);
    QCommandLineOption testWithoutConnectivityOption(
            {"t","test-no-connectivity"},
            "Bypass authentication and allow testing of the application with no internet connectivity.");
    parser.addOption(testWithoutConnectivityOption);
    parser.process(app);

    QQuickView* view = new QQuickView();
    if (parser.isSet(clearSettingsOption)) {
        view->rootContext()->setContextProperty("clearSettings", true);
    } else {
        view->rootContext()->setContextProperty("clearSettings", false);
    }

    if (parser.isSet(testWithoutConnectivityOption)) {
        view->rootContext()->setContextProperty("testWithoutConnectivity", true);
    } else {
        view->rootContext()->setContextProperty("testWithoutConnectivity", false);
    }

    /* View Setup */
    QString qmlfile;
    // FIXME I feel like we should know where our files are installed....
    QStringList paths = QStandardPaths::standardLocations(QStandardPaths::DataLocation);
    paths.prepend(QDir::currentPath());
    paths.prepend(QCoreApplication::applicationDirPath());

    foreach (const QString &path, paths) {
        QFileInfo fi(path + "/qml/qtber.qml");
        qDebug() << "Trying to load QML from:" << path + "/qml/qtber.qml";
        if (fi.exists()) {
            qmlfile = path + "/qml/qtber.qml";
            break;
        }
    }
    qDebug() << "Using main qml file from:" << qmlfile;
    view->setResizeMode(QQuickView::SizeRootObjectToView);
    view->setSource(QUrl::fromLocalFile(qmlfile));
    view->show();

    return app.exec();
}

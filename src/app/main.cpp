/*
 * Copyright: 2014 Josh Arenson
 *
 * This file is part of QtBer
 *
 * QtBer is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * QtBer is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Author: Josh Arenson <josharenson@gmail.com>
 *
 * The majority of this file was taken from ubuntu-terminal-app and was
 * authored by Michael Zanetti, Riccardo Padovani, and David Planella
 */

#include <QtGui/QGuiApplication>
#include <QtQuick/QQuickView>
#include <QtQml/QtQml>
#include <QLibrary>
#include <QDir>

#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication a(argc, argv);
    QQuickView view;
    view.setResizeMode(QQuickView::SizeRootObjectToView);

    // Set up import paths
    QStringList importPathList = view.engine()->importPathList();

    // Prepend the location of the plugin in the build dir,
    // so that Qt Creator finds it there, thus overriding the one installed
    // in the system if there is one
    importPathList.prepend(QCoreApplication::applicationDirPath() + "/../plugin/");

    QStringList args = a.arguments();
    QString qmlfile;

    view.engine()->setImportPathList(importPathList);

    // load the qml file
    if (qmlfile.isEmpty()) {
        QStringList paths = QStandardPaths::standardLocations(QStandardPaths::DataLocation);
        paths.prepend(QDir::currentPath());
        paths.prepend(QCoreApplication::applicationDirPath());

        foreach (const QString &path, paths) {
            QFileInfo fi(path + "/qml/qtber.qml");
            qDebug() << "Trying to load QML from:" << path + "/qml/qtber.qml";
            if (fi.exists()) {
                qmlfile = path +  "/qml/qtber.qml";
                break;
            }
        }
    }
    qDebug() << "using main qml file from:" << qmlfile;
    view.setSource(QUrl::fromLocalFile(qmlfile));
    view.show();

    return a.exec();
}

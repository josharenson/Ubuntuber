/*
 * Copyright (C) 2014 Josh Arenson
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Author : Josh Arenson <josharenson@gmail.com>
 */

#include <QtQml>
#include <QtQml/QQmlContext>

#include "plugin.h"
#include "configfile.h"

void QtBerPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(uri == QLatin1String("com.gmail.josharenson.qtber"));

    qmlRegisterType<ConfigFile>(uri, 0, 1, "ConfigFile");
}

void QtBerPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    QQmlExtensionPlugin::initializeEngine(engine, uri);
}

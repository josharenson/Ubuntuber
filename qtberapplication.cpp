#include "qtberapplication.h"

#include <QtCore/QLibrary>
#include <QtCore/QStandardPaths>
#include <QQmlContext>
#include <QQmlEngine>
#include <QScreen>
#include <QtGui/QGuiApplication>

#include "config.h"
QtBerApplication::QtBerApplication(int &argc, char **argv)
    : QGuiApplication(argc, argv)
{

}

QtBerApplication::~QtBerApplication()
{
}

bool QtBerApplication::setup()
{
    QGuiApplication::primaryScreen()->setOrientationUpdateMask(Qt::PortraitOrientation |
                Qt::LandscapeOrientation |
                Qt::InvertedPortraitOrientation |
                Qt::InvertedLandscapeOrientation);

    m_view.reset(new QQuickView());
    m_view->setResizeMode(QQuickView::SizeRootObjectToView);
    m_view->setTitle("QtBer");
    m_view->setColor("black");
    m_view->rootContext()->setContextProperty("application", this);
    // m_view->engine()->setBaseUrl(QUrl::fromLocalFile(cameraAppDirectory()));
    // m_view->engine()->addImportPath(cameraAppImportDirectory());
    // qDebug() << "Import path added" << cameraAppImportDirectory();
    // qDebug() << "Camera app directory" << cameraAppDirectory();
    QObject::connect(m_view->engine(), SIGNAL(quit()), this, SLOT(quit()));
    m_view->setSource(QUrl::fromLocalFile(sourceQml()));

    //run fullscreen if specified at command line or not in DESKTOP_MODE (i.e. on a device)
    if (arguments().contains(QLatin1String("--fullscreen")))
      m_view->showFullScreen();
    else
      m_view->show();

    return true;
}

#include <libconfig.h++>
#include <string>

#include "configfile.h"

#include <QDebug>

ConfigFile::ConfigFile(QObject *parent) : QObject(parent)
{
    libconfig::Config cfg;
    try
    {
        // Macro set in CMakeLists
        cfg.readFile(CONFIG_FILE_PATH);
    }
    catch (const libconfig::FileIOException &fioex)
    {
    }
    catch (const libconfig::ParseException &pex)
    {
    }

    try
    {
        std::string uaau = cfg.lookup("uber_api_authorization_url");
        m_uber_api_authorization_url = QString::fromStdString(uaau);

        std::string uabu = cfg.lookup("uber_api_base_url");
        m_uber_api_base_url = QString::fromStdString(uabu);

        std::string uapu = cfg.lookup("uber_api_products_url");
        m_uber_api_products_url = QString::fromStdString(uapu);

        std::string uaoci = cfg.lookup("uber_api_oauth_client_id");
        m_uber_api_oauth_client_id = QString::fromStdString(uaoci);
    }
    catch (const libconfig::SettingNotFoundException &nfex)
    {
    }
}

QString ConfigFile::uberApiAuthorizationUrl()
{
    return m_uber_api_authorization_url;
}

QString ConfigFile::uberApiBaseUrl()
{
    return m_uber_api_base_url;
}

QString ConfigFile::uberApiProductsUrl()
{
    return m_uber_api_products_url;
}

QString ConfigFile::uberApiOauthClientId()
{
    return m_uber_api_oauth_client_id;
}

#include <libconfig.h++>
#include <string>

#include "configfile.h"

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
        std::string v = cfg.lookup("uber_api_authorization_url");
        m_uber_api_authorization_url = QString::fromStdString(v);
    }
    catch (const libconfig::SettingNotFoundException &nfex)
    {
    }
}

QString ConfigFile::uber_api_authorization_url()
{
    return m_uber_api_authorization_url;
}

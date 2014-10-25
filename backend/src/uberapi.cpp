#include <iostream>
#include <libconfig.h++>
#include <oauth.h>

#include <uberapi.h>

UberAPI::UberAPI()
{
    libconfig::Config cfg;
    try
    {
        cfg.readFile(CONFIG_FILE_PATH);
    }
    catch (const libconfig::FileIOException &fioex)
    {
        std::cout << "I/O error while reading config file!" << std::endl;
    }
    catch (const libconfig::ParseException &pex)
    {
        std::cerr << "Parse error while reading config file!" << std::endl;
    }

    try
    {
       std::string client_id = cfg.lookup("oauth_client_id");
       m_client_id = client_id;

       std::string authorize_url = cfg.lookup("oauth_authorize_url");
       m_authorize_url = authorize_url;
    }
    catch (const libconfig::SettingNotFoundException &nfex)
    {
        std::cerr << "Could not find client_id in config file!" << std::endl;
    }
}

const std::string UberAPI::authorize_url()
{
    return m_authorize_url;
}

const std::string UberAPI::client_id()
{
    return m_client_id;
}

void UberAPI::authenticate()
{
}

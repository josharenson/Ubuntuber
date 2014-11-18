#ifndef QTBER_CONFIG_FILE_H_
#define QTBER_CONFIG_FILE_H_

#include <QObject>

class ConfigFile : public QObject
{
    Q_OBJECT
    Q_PROPERTY (QString uberApiAuthorizationUrl READ uberApiAuthorizationUrl)
    Q_PROPERTY (QString uberApiBaseUrl READ uberApiBaseUrl)
    Q_PROPERTY (QString uberApiProductsUrl READ uberApiProductsUrl)

    Q_PROPERTY (QString uberApiOauthClientId READ uberApiOauthClientId)

    public:
        explicit ConfigFile(QObject *parent = 0);

    protected:
        QString uberApiAuthorizationUrl();
        QString uberApiBaseUrl();
        QString uberApiProductsUrl();

        QString uberApiOauthClientId();

    private:
        QString m_uber_api_authorization_url;
        QString m_uber_api_base_url;
        QString m_uber_api_products_url;

        QString m_uber_api_oauth_client_id;
};

#endif /* QTBER_CONFIG_FILE_H_  */

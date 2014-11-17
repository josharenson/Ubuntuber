#ifndef QTBER_CONFIG_FILE_H_
#define QTBER_CONFIG_FILE_H_

#include <QObject>

class ConfigFile : public QObject
{
    Q_OBJECT
    Q_PROPERTY( QString uber_api_authorization_url
            READ uberApiAuthorizationUrl
            WRITE setUberApiAuthorizationUrl
            NOTIFY uberApiAuthorizationUrlChanged )


    public:
        explicit ConfigFile(QObject *parent = 0);

    Q_SIGNALS:
            void uberApiAuthorizationUrlChanged();

    protected:
        QString uberApiAuthorizationUrl();
        void setUberApiAuthorizationUrl(QString url)
        {
            m_uber_api_authorization_url = url; Q_EMIT uberApiAuthorizationUrlChanged();
        }


    private:
        QString m_uber_api_authorization_url;
};

#endif /* QTBER_CONFIG_FILE_H_  */

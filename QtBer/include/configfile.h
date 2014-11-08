#ifndef QTBER_CONFIG_FILE_H_
#define QTBER_CONFIG_FILE_H_

#include <QObject>

class ConfigFile : QObject
{
    Q_OBJECT

    public:
        explicit ConfigFile(QObject *parent = 0);

        QString uber_api_authorization_url();

    private:
        QString m_uber_api_authorization_url;
};

#endif /* QTBER_CONFIG_FILE_H_  */

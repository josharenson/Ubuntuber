#ifndef UBERAPI_H_
#define UBERAPI_H_

#include <curl/curl.h>
#include <string>

class UberAPI
{
    public:
        UberAPI();
        UberAPI(int);

        // getters
        const std::string client_id();

    private:
        CURL *m_curl;

        std::string m_client_id;
};

#endif /* UBERAPI_H_ */

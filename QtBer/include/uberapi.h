#ifndef UBERAPI_H_
#define UBERAPI_H_

#include <string>

class UberAPI
{
    public:
        UberAPI();

        // getters
        const std::string authorize_url();
        const std::string client_id();

    private:
        std::string m_authorize_url;
        std::string m_client_id;

        void authenticate();
};

#endif /* UBERAPI_H_ */

.import QtQuick.LocalStorage 2.0 as Sql
.import "config.js" as Config
.import "ajaxmee.js" as Ajaxmee

function get_product_types(success_callback, data) {
    var url = Config.uberApi.baseUrl + Config.uberApi.productsUrl;
    var payload =   [
                        {"Authorization": "Bearer " + String(bearerToken())},
                        data
                    ]

    Ajaxmee.ajaxmee('GET', url, payload,
            success_callback,
            function(status, statusText) {
                console.log('error', status, statusText)
            })
}

/******** OAuth Stuff ********/

var dbConArgs = ["QtBer", "1.0", "QtBer Local Data", 1];
function urlHasBearerToken(url) {
    return url.toString().indexOf("access_token") > -1 ? true : false;
}

function saveBearerToken(url) {
    if (!urlHasBearerToken(url)) {
        return false;
    }

    // Do seperate regexes as we can't guarentee the string ordering
    var re_bearerToken = /access_token\=([^&]+)/;
    var re_expiresIn = /expires_in\=([^&]+)/;

    var match_bearerToken = re_bearerToken.exec(url);
    var match_expiresIn = re_expiresIn.exec(url);
    if (!match_bearerToken[1] && !match_expiresIn[1]) {
        return false;
    }

    var bearerToken = match_bearerToken[1];
    var expiresIn = match_expiresIn[1];
    expiresIn += Date.now();

    var db = Sql.LocalStorage.openDatabaseSync(dbConArgs);
    var dataStr = "INSERT INTO OAuthInfo VALUES(?, ?)";
    var data = [bearerToken, expiresIn];
    db.transaction(function(tx) {
        tx.executeSql(
            'CREATE TABLE IF NOT EXISTS OAuthInfo' +
            '(bearer_token TEXT, expires_in DATE)'
        );
        tx.executeSql(dataStr, data);
    });

    return true;
}

function bearerTokenIsValid() {
    return (Date.now() < bearerTokenExpiresIn());
}

// Accessors
function authorizationUrl() {
    return Config.uberApi['authorizationUrl'] +
        "?client_id=" +
        Config.uberApi.oauthClientId +
        "&response_type=token";
}

function bearerToken() {
    var db = Sql.LocalStorage.openDatabaseSync(dbConArgs);
    var dataStr = "SELECT * FROM OAuthInfo";
    var token = null;
    db.transaction(function(tx) {
        var rs = tx.executeSql(dataStr);
        if (rs.rows.item(0)) {
            token = rs.rows.item(rs.rows.length - 1).bearer_token;
        }
    });
    return token;
}

function bearerTokenExpiresIn() {
    var db = Sql.LocalStorage.openDatabaseSync(dbConArgs);
    var dataStr = "SELECT * FROM OAuthInfo";
    var expires = null;
    db.transaction(function(tx) {
        var rs = tx.executeSql(dataStr);
        if (rs.rows.item(0)) {
            expires = rs.rows.item(rs.rows.length - 1).expires_in;
        }
    });
    return expires;
}

.import QtQuick.LocalStorage 2.0 as Sql
.import "config.js" as Config
.import "ajaxmee.js" as Ajaxmee

function get_procuts_types(success_callback, data, config) {
    var url = config.uberApiBaseUrl + config.uberApiProductsUrl;
    console.log(bearer_token());
    return;
    Ajaxmee.ajaxmee('GET', url, data,
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

    var re_bearerToken = /access_token\=([^&]+)/;
    var match = re_bearerToken.exec(url);

    if (!match[1]) {
        return false;
    }

    var bearerToken = match[1];

    var db = Sql.LocalStorage.openDatabaseSync(dbConArgs);
    var dataStr = "INSERT INTO OAuthToken VALUES(?)";
    var data = [bearerToken];
    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS OAuthToken(bearer_token TEXT)');
        tx.executeSql(dataStr, data);
    });

    return true;
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
    var dataStr = "SELECT * FROM OAuthToken";
    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS OAuthToken(bearer_token TEXT)');
        var rs = tx.executeSql(dataStr);
        if (rs.rows.item(0)) {
            console.log(rs.rows.item(0).bearer_token + "<--- IS TOKEN")
        }
    });
}

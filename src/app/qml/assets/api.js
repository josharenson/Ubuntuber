/*
 * Copyright (C) 2014, 2015 Josh Arenson
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

.import QtQuick.LocalStorage 2.0 as Sql
.import "config.js" as Config
.import "ajaxmee.js" as Ajaxmee

function get_price_estimate(start_latitude, start_longitude,
        end_latitude, end_longitude, success_callback) {
    var url = Config.uberApi.baseUrl + Config.uberApi.priceEstimateUrl;

    var data = {
        "start_latitude"    : start_latitude,
        "start_longitude"   : start_longitude,
        "end_latitude"      : end_latitude,
        "end_longitude"     : end_longitude
    };

    var payload =   [
                        {"Authorization" : "Bearer " + String(bearerToken())},
                        data
                    ]

    Ajaxmee.ajaxmee('GET', url, payload,
            success_callback,
            function(status, statusText) {
                console.log('error', status, statusText);
            })
}


// FIXME make this look more like get_price_estimate to help abstraction
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

function addDays(date, days) {
    var result = new Date(date);
    result.setDate(result.getDate() + days);
    return result;
}

function bearerTokenIsValid() {
    var expirationDate = parseInt((new Date(bearerTokenExpiresIn())).getTime());
    var now = parseInt(Date.now());
    return (expirationDate > now);
}

// Useful for debugging or logging out
function dropDbTable() {
    var db = Sql.LocalStorage.openDatabaseSync(dbConArgs);
    var dataStr = "DROP TABLE OAuthInfo";
    try {
        db.transaction(function(tx) {
            tx.executeSql(dataStr);
        });
    } catch (ex) {
        return;
    }

}

function logout() {
    // An Alias for dropping the db table
    return dropDbTable();
}

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

    // Response is in seconds. Convert to days because dates are hard.
    expiresIn = (((expiresIn / 60) / 60) / 24)
    expiresIn = addDays(Date.now(), expiresIn)

    var db = Sql.LocalStorage.openDatabaseSync(dbConArgs);
    var dataStr = "INSERT INTO OAuthInfo VALUES(?, ?)";
    var data = [bearerToken, expiresIn];
    db.transaction(function(tx) {
        tx.executeSql(
            'CREATE TABLE IF NOT EXISTS OAuthInfo' +
            '(bearer_token TEXT, expires_in INTEGER)'
        );
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
    try {
    db.transaction(function(tx) {
        var rs = tx.executeSql(dataStr);
        if (rs.rows.item(0)) {
            expires = rs.rows.item(rs.rows.length - 1).expires_in;
        }
    });
    } catch (ex) {
        expires = null;
    }
    return expires;
}

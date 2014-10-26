.import QtQuick.LocalStorage 2.0 as Sql

function urlChanged(url) {
    console.log("JOSH"+url);
    var authorized = false;
    var mUrl = url.toString();
    var token = "";
    if (mUrl.indexOf("https://login.uber.com") > -1) {
        var query = mUrl.substring(mUrl.indexOf('#') + 1);
        var vars = query.split("&");
        for (var i=0;i<vars.length;i++) {
            var pair = vars[i].split("=");
            if (pair[0] == "access_token") {
                authorized = true;
                token = pair[1];
                console.log("Found token: " + token)
                saveToken(token);
            }
        }
    }
    if (authorized) {
        stack_oauth.token = token;
        stack_oauth.state = "AuthDone";
    }
}

function saveToken(token) {
    console.log("Saving...")
    var db = Sql.LocalStorage.openDatabaseSync("Token", "1.0", "the token", 1);
    var dataStr = "INSERT INTO Token VALUES(?)";
    var data = [token];
    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS Token(token TEXT)');
        tx.executeSql(dataStr, data);
    });
}

function checkToken() {
    var db = Sql.LocalStorage.openDatabaseSync("Token", "1.0", "the token", 1);
    var dataStr = "SELECT * FROM Token";
    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS Token(token TEXT)');
        var rs = tx.executeSql(dataStr);
        if (rs.rows.item(0)) {
            stack_oauth.token = rs.rows.item(0).token
            stack_oauth.state = "AuthDone"
            console.log("Auth done...")
        } else {
            stack_oauth.state = "Login"
            console.log("Logging in....")
        }
    });
}
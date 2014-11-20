/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <p@bergqvi.st> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return. Peppe Bergqvist
 * ----------------------------------------------------------------------------
 */

var ajaxmee = function(method, url, params, successCallback, errorCallback) {

    var size = function(ar) {
        var len = ar.length ? --ar.length : -1;
            for (var k in ar) {
                len++;
            }
        return len;
    }

    var serialize = function(obj, prefix) {
        var str = [];
        for(var p in obj) {
            var k = prefix ? prefix + "[" + p + "]" : p, v = obj[p];
            str.push(typeof v == "object" ?
                serialize(v, k) :
                encodeURIComponent(k) + "=" + encodeURIComponent(v));
        }
        return str.join("&");
    }

    var init = function(method, url, params, successCallback, errorCallback) {

        params = serialize(params)
        var doc = new XMLHttpRequest();
        if (method == 'GET') {
            url = url +'?'+ params
            params = ''
        }
        console.log(method + " " + url);

        doc.onreadystatechange = function() {
            if (doc.readyState == XMLHttpRequest.HEADERS_RECEIVED) {
                var status = doc.status;
                if(status!=200) {
                    errorCallback(status, doc.statusText)
                }
            } else if (doc.readyState == XMLHttpRequest.DONE) {
                var data;
                var contentType = doc.getResponseHeader("Content-Type");
                data = doc.responseText;
                successCallback(data);
            }
        }

        doc.open(method, url);
        if (params.length > 0) {
            doc.setRequestHeader("Authorization","Bearer 7xvgVDclLZvugwKS7LVkxx9MuBA57E")
            doc.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            doc.setRequestHeader("Content-Length", String(params.length));
            doc.send(params);
        } else {

            doc.setRequestHeader("Authorization","Bearer 7xvgVDclLZvugwKS7LVkxx9MuBA57E")
                console.log("setting headers")
            doc.send();
        }
    }

    init(method, url, params, successCallback, errorCallback);
}

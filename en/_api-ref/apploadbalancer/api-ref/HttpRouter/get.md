---
editable: false
---

# Method get

 

 
## HTTP request {#https-request}
```
GET https://apploadbalancer.api.cloud.yandex.net/apploadbalancer/v1/httpRouters/{httpRouterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
httpRouterId | Required.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "name": "string",
  "description": "string",
  "folderId": "string",
  "labels": "object",
  "virtualHosts": [
    {
      "name": "string",
      "authority": [
        "string"
      ],
      "ports": [
        "string"
      ],
      "routes": [
        {
          "name": "string",

          // `virtualHosts[].routes[]` includes only one of the fields `http`, `grpc`
          "http": {
            "match": {
              "httpMethod": [
                "string"
              ],
              "path": {

                // `virtualHosts[].routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`
                "exactMatch": "string",
                "prefixMatch": "string",
                // end of the list of possible fields`virtualHosts[].routes[].http.match.path`

              }
            },

            // `virtualHosts[].routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`
            "route": {
              "backendGroupId": "string",
              "timeout": "string",
              "prefixRewrite": "string",
              "supportWebsockets": true,

              // `virtualHosts[].routes[].http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`
              "hostRewrite": "string",
              "autoHostRewrite": true,
              // end of the list of possible fields`virtualHosts[].routes[].http.route`

            },
            "redirect": {
              "replaceScheme": "string",
              "responseCode": "string"
            },
            "directResponse": {
              "status": "string",
              "body": {
                "text": "string"
              }
            },
            // end of the list of possible fields`virtualHosts[].routes[].http`

          },
          "grpc": {
            "match": {
              "fqmn": {

                // `virtualHosts[].routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`
                "exactMatch": "string",
                "prefixMatch": "string",
                // end of the list of possible fields`virtualHosts[].routes[].grpc.match.fqmn`

              }
            },

            // `virtualHosts[].routes[].grpc` includes only one of the fields `route`, `statusResponse`
            "route": {
              "backendGroupId": "string",
              "maxTimeout": "string",

              // `virtualHosts[].routes[].grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`
              "hostRewrite": "string",
              "autoHostRewrite": true,
              // end of the list of possible fields`virtualHosts[].routes[].grpc.route`

            },
            "statusResponse": {
              "status": "string"
            },
            // end of the list of possible fields`virtualHosts[].routes[].grpc`

          },
          // end of the list of possible fields`virtualHosts[].routes[]`

        }
      ],
      "modifyRequestHeaders": [
        {
          "name": "string",

          // `virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
          "append": "string",
          "replace": "string",
          "remove": true,
          "rename": "string",
          // end of the list of possible fields`virtualHosts[].modifyRequestHeaders[]`

        }
      ],
      "modifyResponseHeaders": [
        {
          "name": "string",

          // `virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
          "append": "string",
          "replace": "string",
          "remove": true,
          "rename": "string",
          // end of the list of possible fields`virtualHosts[].modifyResponseHeaders[]`

        }
      ]
    }
  ]
}
```

 
Field | Description
--- | ---
id | **string**<br><p>Output only. ID of the router.</p> 
name | **string**<br><p>The name is unique within the folder. 3-63 characters long.</p> 
description | **string**<br><p>Description of the router. 0-256 characters long.</p> 
folderId | **string**<br><p>ID of the folder that the router belongs to.</p> 
labels | **object**<br><p>Resource labels as <code>key:value</code> pairs. Maximum of 64 per resource.</p> 
virtualHosts[] | **object**<br><p>Only one virtual host with no authority (default match) can be specified.</p> 
virtualHosts[].<br>name | **string**<br><p>Required.</p> 
virtualHosts[].<br>authority[] | **string**<br><p>A list of domains (host/authority header) that will be matched to this virtual host. Wildcard hosts are supported in the form of '<em>.foo.com' or '</em>-bar.foo.com'. If not specified, all domains will be matched.</p> 
virtualHosts[].<br>ports[] | **string** (int64)<br><p>Ports to attach to each authority, e.g. if authority is example.com and ports are 2345, 80, the resulting server names matches will be example.com, example.com:2345, example.com:80. If not specified, 443 and 80 are assumed (i.e. example.com, example.com:80, example.com:443).</p> 
virtualHosts[].<br>routes[] | **object**<br><p>Routes are matched <em>in-order</em>. Be careful when adding them to the end. For instance, having http '/' match first makes all other routes unused.</p> 
virtualHosts[].<br>routes[].<br>name | **string**<br><p>Required.</p> 
virtualHosts[].<br>routes[].<br>http | **object** <br>`virtualHosts[].routes[]` includes only one of the fields `http`, `grpc`<br><br>
virtualHosts[].<br>routes[].<br>http.<br>match | **object**<br>Checks "/" prefix by default.<br>
virtualHosts[].<br>routes[].<br>http.<br>match.<br>httpMethod[] | **string**<br>
virtualHosts[].<br>routes[].<br>http.<br>match.<br>path | **object**<br><p>If not set, '/' is assumed.</p> 
virtualHosts[].<br>routes[].<br>http.<br>match.<br>path.<br>exactMatch | **string** <br>`virtualHosts[].routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
virtualHosts[].<br>routes[].<br>http.<br>match.<br>path.<br>prefixMatch | **string** <br>`virtualHosts[].routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
virtualHosts[].<br>routes[].<br>http.<br>route | **object** <br>`virtualHosts[].routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br>
virtualHosts[].<br>routes[].<br>http.<br>route.<br>backendGroupId | **string**<br><p>Required. Backend group to route requests.</p> 
virtualHosts[].<br>routes[].<br>http.<br>route.<br>timeout | **string**<br><p>If not set, default is 60 seconds.</p> 
virtualHosts[].<br>routes[].<br>http.<br>route.<br>prefixRewrite | **string**<br><p>If not empty, matched path prefix will be replaced by this value.</p> 
virtualHosts[].<br>routes[].<br>http.<br>route.<br>supportWebsockets | **boolean** (boolean)<br><p>Allows websocket upgrades.</p> 
virtualHosts[].<br>routes[].<br>http.<br>route.<br>hostRewrite | **string** <br>`virtualHosts[].routes[].http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
virtualHosts[].<br>routes[].<br>http.<br>route.<br>autoHostRewrite | **boolean** (boolean) <br>`virtualHosts[].routes[].http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
virtualHosts[].<br>routes[].<br>http.<br>redirect | **object** <br>`virtualHosts[].routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br>
virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>replaceScheme | **string**<br><p>Replaces scheme. If the original scheme is <code>http</code> or <code>https</code>, will also remove the 80 or 443 port, if present.</p> 
virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>responseCode | **string**<br><p>The HTTP status code to use in the redirect response.</p> <ul> <li>MOVED_PERMANENTLY: Moved Permanently HTTP Status Code - 301.</li> <li>FOUND: Found HTTP Status Code - 302.</li> <li>SEE_OTHER: See Other HTTP Status Code - 303.</li> <li>TEMPORARY_REDIRECT: Temporary Redirect HTTP Status Code - 307.</li> <li>PERMANENT_REDIRECT: Permanent Redirect HTTP Status Code - 308.</li> </ul> 
virtualHosts[].<br>routes[].<br>http.<br>directResponse | **object** <br>`virtualHosts[].routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br>
virtualHosts[].<br>routes[].<br>http.<br>directResponse.<br>status | **string** (int64)<br><p>HTTP response status.</p> <p>Acceptable values are 100 to 599, inclusive.</p> 
virtualHosts[].<br>routes[].<br>http.<br>directResponse.<br>body | **object**<br><p>Optional response body.</p> 
virtualHosts[].<br>routes[].<br>http.<br>directResponse.<br>body.<br>text | **string**<br><p>Text message.</p> <p>The string length in characters must be greater than 0.</p> 
virtualHosts[].<br>routes[].<br>grpc | **object** <br>`virtualHosts[].routes[]` includes only one of the fields `http`, `grpc`<br><br>
virtualHosts[].<br>routes[].<br>grpc.<br>match | **object**<br>Checks "/" prefix by default.<br>
virtualHosts[].<br>routes[].<br>grpc.<br>match.<br>fqmn | **object**<br><p>If not set, all services/methods are assumed.</p> 
virtualHosts[].<br>routes[].<br>grpc.<br>match.<br>fqmn.<br>exactMatch | **string** <br>`virtualHosts[].routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
virtualHosts[].<br>routes[].<br>grpc.<br>match.<br>fqmn.<br>prefixMatch | **string** <br>`virtualHosts[].routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
virtualHosts[].<br>routes[].<br>grpc.<br>route | **object** <br>`virtualHosts[].routes[].grpc` includes only one of the fields `route`, `statusResponse`<br><br>
virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>backendGroupId | **string**<br><p>Required. Backend group to route requests.</p> 
virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>maxTimeout | **string**<br><p>Lower timeout may be specified by the client (using grpc-timeout header). If not set, default is 60 seconds.</p> 
virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>hostRewrite | **string** <br>`virtualHosts[].routes[].grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>autoHostRewrite | **boolean** (boolean) <br>`virtualHosts[].routes[].grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
virtualHosts[].<br>routes[].<br>grpc.<br>statusResponse | **object** <br>`virtualHosts[].routes[].grpc` includes only one of the fields `route`, `statusResponse`<br><br>
virtualHosts[].<br>routes[].<br>grpc.<br>statusResponse.<br>status | **string**<br>
virtualHosts[].<br>modifyRequestHeaders[] | **object**<br><p>Apply the following modifications to the request headers.</p> 
virtualHosts[].<br>modifyRequestHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
virtualHosts[].<br>modifyRequestHeaders[].<br>append | **string** <br>`virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Append string to the header value.</p> 
virtualHosts[].<br>modifyRequestHeaders[].<br>replace | **string** <br>`virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>New value for a header.</p> 
virtualHosts[].<br>modifyRequestHeaders[].<br>remove | **boolean** (boolean) <br>`virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Remove the header.</p> 
virtualHosts[].<br>modifyRequestHeaders[].<br>rename | **string** <br>`virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>New name for a header.</p> 
virtualHosts[].<br>modifyResponseHeaders[] | **object**<br><p>Apply the following modifications to the response headers.</p> 
virtualHosts[].<br>modifyResponseHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
virtualHosts[].<br>modifyResponseHeaders[].<br>append | **string** <br>`virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Append string to the header value.</p> 
virtualHosts[].<br>modifyResponseHeaders[].<br>replace | **string** <br>`virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>New value for a header.</p> 
virtualHosts[].<br>modifyResponseHeaders[].<br>remove | **boolean** (boolean) <br>`virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Remove the header.</p> 
virtualHosts[].<br>modifyResponseHeaders[].<br>rename | **string** <br>`virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>New name for a header.</p> 
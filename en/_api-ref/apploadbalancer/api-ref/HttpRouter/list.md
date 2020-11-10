---
editable: false
---

# Method list

 

 
## HTTP request {#https-request}
```
GET https://apploadbalancer.api.cloud.yandex.net/apploadbalancer/v1/httpRouters
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required.
pageSize | Acceptable values are 0 to 1000, inclusive.
pageToken | The maximum string length in characters is 100.
filter | The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "httpRouters": [
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
          "routes": [
            {
              "name": "string",

              // `httpRouters[].virtualHosts[].routes[]` includes only one of the fields `http`, `grpc`
              "http": {
                "match": {
                  "httpMethod": [
                    "string"
                  ],
                  "path": {

                    // `httpRouters[].virtualHosts[].routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`
                    "exactMatch": "string",
                    "prefixMatch": "string",
                    // end of the list of possible fields`httpRouters[].virtualHosts[].routes[].http.match.path`

                  }
                },

                // `httpRouters[].virtualHosts[].routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`
                "route": {
                  "backendGroupId": "string",
                  "timeout": "string",
                  "prefixRewrite": "string",
                  "supportWebsockets": true,

                  // `httpRouters[].virtualHosts[].routes[].http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`
                  "hostRewrite": "string",
                  "autoHostRewrite": true,
                  // end of the list of possible fields`httpRouters[].virtualHosts[].routes[].http.route`

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
                // end of the list of possible fields`httpRouters[].virtualHosts[].routes[].http`

              },
              "grpc": {
                "match": {
                  "fqmn": {

                    // `httpRouters[].virtualHosts[].routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`
                    "exactMatch": "string",
                    "prefixMatch": "string",
                    // end of the list of possible fields`httpRouters[].virtualHosts[].routes[].grpc.match.fqmn`

                  }
                },

                // `httpRouters[].virtualHosts[].routes[].grpc` includes only one of the fields `route`, `statusResponse`
                "route": {
                  "backendGroupId": "string",
                  "maxTimeout": "string",

                  // `httpRouters[].virtualHosts[].routes[].grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`
                  "hostRewrite": "string",
                  "autoHostRewrite": true,
                  // end of the list of possible fields`httpRouters[].virtualHosts[].routes[].grpc.route`

                },
                "statusResponse": {
                  "status": "string"
                },
                // end of the list of possible fields`httpRouters[].virtualHosts[].routes[].grpc`

              },
              // end of the list of possible fields`httpRouters[].virtualHosts[].routes[]`

            }
          ],
          "modifyRequestHeaders": [
            {
              "name": "string",

              // `httpRouters[].virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
              "append": "string",
              "replace": "string",
              "remove": true,
              "rename": "string",
              // end of the list of possible fields`httpRouters[].virtualHosts[].modifyRequestHeaders[]`

            }
          ],
          "modifyResponseHeaders": [
            {
              "name": "string",

              // `httpRouters[].virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`
              "append": "string",
              "replace": "string",
              "remove": true,
              "rename": "string",
              // end of the list of possible fields`httpRouters[].virtualHosts[].modifyResponseHeaders[]`

            }
          ]
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
httpRouters[] | **object**<br>
httpRouters[].<br>id | **string**<br><p>Output only. ID of the router.</p> 
httpRouters[].<br>name | **string**<br><p>The name is unique within the folder. 3-63 characters long.</p> 
httpRouters[].<br>description | **string**<br><p>Description of the router. 0-256 characters long.</p> 
httpRouters[].<br>folderId | **string**<br><p>ID of the folder that the router belongs to.</p> 
httpRouters[].<br>labels | **object**<br><p>Resource labels as <code>key:value</code> pairs. Maximum of 64 per resource.</p> 
httpRouters[].<br>virtualHosts[] | **object**<br><p>Only one virtual host with no authority (default match) can be specified.</p> 
httpRouters[].<br>virtualHosts[].<br>name | **string**<br><p>Required.</p> 
httpRouters[].<br>virtualHosts[].<br>authority[] | **string**<br><p>A list of domains (host/authority header) that will be matched to this virtual host. Wildcard hosts are supported in the form of '<em>.foo.com' or '</em>-bar.foo.com'. If not specified, all domains will be matched.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[] | **object**<br><p>Routes are matched <em>in-order</em>. Be careful when adding them to the end. For instance, having http '/' match first makes all other routes unused.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>name | **string**<br><p>Required.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http | **object** <br>`httpRouters[].virtualHosts[].routes[]` includes only one of the fields `http`, `grpc`<br><br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>match | **object**<br>Checks "/" prefix by default.<br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>match.<br>httpMethod[] | **string**<br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>match.<br>path | **object**<br><p>If not set, '/' is assumed.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>match.<br>path.<br>exactMatch | **string** <br>`httpRouters[].virtualHosts[].routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>match.<br>path.<br>prefixMatch | **string** <br>`httpRouters[].virtualHosts[].routes[].http.match.path` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>route | **object** <br>`httpRouters[].virtualHosts[].routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>route.<br>backendGroupId | **string**<br><p>Required. Backend group to route requests.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>route.<br>timeout | **string**<br><p>If not set, default is 60 seconds.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>route.<br>prefixRewrite | **string**<br><p>If not empty, matched path prefix will be replaced by this value.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>route.<br>supportWebsockets | **boolean** (boolean)<br><p>Allows websocket upgrades.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>route.<br>hostRewrite | **string** <br>`httpRouters[].virtualHosts[].routes[].http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>route.<br>autoHostRewrite | **boolean** (boolean) <br>`httpRouters[].virtualHosts[].routes[].http.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>redirect | **object** <br>`httpRouters[].virtualHosts[].routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>replaceScheme | **string**<br><p>Replaces scheme. If the original scheme is <code>http</code> or <code>https</code>, will also remove the 80 or 443 port, if present.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>redirect.<br>responseCode | **string**<br><p>The HTTP status code to use in the redirect response.</p> <ul> <li>MOVED_PERMANENTLY: Moved Permanently HTTP Status Code - 301.</li> <li>FOUND: Found HTTP Status Code - 302.</li> <li>SEE_OTHER: See Other HTTP Status Code - 303.</li> <li>TEMPORARY_REDIRECT: Temporary Redirect HTTP Status Code - 307.</li> <li>PERMANENT_REDIRECT: Permanent Redirect HTTP Status Code - 308.</li> </ul> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>directResponse | **object** <br>`httpRouters[].virtualHosts[].routes[].http` includes only one of the fields `route`, `redirect`, `directResponse`<br><br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>directResponse.<br>status | **string** (int64)<br><p>HTTP response status.</p> <p>Acceptable values are 100 to 599, inclusive.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>directResponse.<br>body | **object**<br><p>Optional response body.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>http.<br>directResponse.<br>body.<br>text | **string**<br><p>Text message.</p> <p>The string length in characters must be greater than 0.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc | **object** <br>`httpRouters[].virtualHosts[].routes[]` includes only one of the fields `http`, `grpc`<br><br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>match | **object**<br>Checks "/" prefix by default.<br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>match.<br>fqmn | **object**<br><p>If not set, all services/methods are assumed.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>match.<br>fqmn.<br>exactMatch | **string** <br>`httpRouters[].virtualHosts[].routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>match.<br>fqmn.<br>prefixMatch | **string** <br>`httpRouters[].virtualHosts[].routes[].grpc.match.fqmn` includes only one of the fields `exactMatch`, `prefixMatch`<br><br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>route | **object** <br>`httpRouters[].virtualHosts[].routes[].grpc` includes only one of the fields `route`, `statusResponse`<br><br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>backendGroupId | **string**<br><p>Required. Backend group to route requests.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>maxTimeout | **string**<br><p>Lower timeout may be specified by the client (using grpc-timeout header). If not set, default is 60 seconds.</p> 
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>hostRewrite | **string** <br>`httpRouters[].virtualHosts[].routes[].grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>route.<br>autoHostRewrite | **boolean** (boolean) <br>`httpRouters[].virtualHosts[].routes[].grpc.route` includes only one of the fields `hostRewrite`, `autoHostRewrite`<br><br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>statusResponse | **object** <br>`httpRouters[].virtualHosts[].routes[].grpc` includes only one of the fields `route`, `statusResponse`<br><br>
httpRouters[].<br>virtualHosts[].<br>routes[].<br>grpc.<br>statusResponse.<br>status | **string**<br>
httpRouters[].<br>virtualHosts[].<br>modifyRequestHeaders[] | **object**<br><p>Apply the following modifications to the request headers.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyRequestHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyRequestHeaders[].<br>append | **string** <br>`httpRouters[].virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Append string to the header value.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyRequestHeaders[].<br>replace | **string** <br>`httpRouters[].virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>New value for a header.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyRequestHeaders[].<br>remove | **boolean** (boolean) <br>`httpRouters[].virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Remove the header.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyRequestHeaders[].<br>rename | **string** <br>`httpRouters[].virtualHosts[].modifyRequestHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>New name for a header.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyResponseHeaders[] | **object**<br><p>Apply the following modifications to the response headers.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyResponseHeaders[].<br>name | **string**<br><p>Name of the header.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyResponseHeaders[].<br>append | **string** <br>`httpRouters[].virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Append string to the header value.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyResponseHeaders[].<br>replace | **string** <br>`httpRouters[].virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>New value for a header.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyResponseHeaders[].<br>remove | **boolean** (boolean) <br>`httpRouters[].virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>Remove the header.</p> 
httpRouters[].<br>virtualHosts[].<br>modifyResponseHeaders[].<br>rename | **string** <br>`httpRouters[].virtualHosts[].modifyResponseHeaders[]` includes only one of the fields `append`, `replace`, `remove`, `rename`<br><br><p>New name for a header.</p> 
nextPageToken | **string**<br>
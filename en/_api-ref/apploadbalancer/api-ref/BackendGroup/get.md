---
editable: false
---

# Method get

 

 
## HTTP request {#https-request}
```
GET https://apploadbalancer.api.cloud.yandex.net/apploadbalancer/v1/backendGroups/{backendGroupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
backendGroupId | Required.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "name": "string",
  "description": "string",
  "folderId": "string",
  "labels": "object",

  //  includes only one of the fields `http`, `grpc`
  "http": {
    "backends": [
      {
        "name": "string",
        "backendWeight": "integer",
        "loadBalancingConfig": {
          "panicThreshold": "string",
          "localityAwareRoutingPercent": "string"
        },
        "port": "string",
        "healthchecks": [
          {
            "timeout": "string",
            "interval": "string",
            "intervalJitterPercent": "number",
            "healthyThreshold": "string",
            "unhealthyThreshold": "string",
            "healthcheckPort": "string",

            // `http.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`
            "stream": {
              "send": {
                "text": "string"
              },
              "receive": {
                "text": "string"
              }
            },
            "http": {
              "host": "string",
              "path": "string",
              "useHttp2": true
            },
            "grpc": {
              "serviceName": "string"
            },
            // end of the list of possible fields`http.backends[].healthchecks[]`

          }
        ],
        "tls": {
          "sni": "string",
          "tlsOptions": {
            "tlsMinVersion": "string",
            "tlsMaxVersion": "string",
            "cipherSuites": [
              "string"
            ],
            "ecdhCurves": [
              "string"
            ]
          },
          "validationContext": {

            // `http.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`
            "trustedCaId": "string",
            "trustedCaBytes": "string",
            // end of the list of possible fields`http.backends[].tls.validationContext`

          }
        },
        "useHttp2": true,
        "targetGroup": {
          "targetGroupId": "string"
        }
      }
    ]
  },
  "grpc": {
    "backends": [
      {
        "name": "string",
        "backendWeight": "integer",
        "loadBalancingConfig": {
          "panicThreshold": "string",
          "localityAwareRoutingPercent": "string"
        },
        "port": "string",
        "healthchecks": [
          {
            "timeout": "string",
            "interval": "string",
            "intervalJitterPercent": "number",
            "healthyThreshold": "string",
            "unhealthyThreshold": "string",
            "healthcheckPort": "string",

            // `grpc.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`
            "stream": {
              "send": {
                "text": "string"
              },
              "receive": {
                "text": "string"
              }
            },
            "http": {
              "host": "string",
              "path": "string",
              "useHttp2": true
            },
            "grpc": {
              "serviceName": "string"
            },
            // end of the list of possible fields`grpc.backends[].healthchecks[]`

          }
        ],
        "tls": {
          "sni": "string",
          "tlsOptions": {
            "tlsMinVersion": "string",
            "tlsMaxVersion": "string",
            "cipherSuites": [
              "string"
            ],
            "ecdhCurves": [
              "string"
            ]
          },
          "validationContext": {

            // `grpc.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`
            "trustedCaId": "string",
            "trustedCaBytes": "string",
            // end of the list of possible fields`grpc.backends[].tls.validationContext`

          }
        },
        "targetGroup": {
          "targetGroupId": "string"
        }
      }
    ]
  },
  // end of the list of possible fields

}
```

 
Field | Description
--- | ---
id | **string**<br><p>Output only. ID of the backend group.</p> 
name | **string**<br><p>The name is unique within the folder. 3-63 characters long.</p> 
description | **string**<br><p>Description of the backend group. 0-256 characters long.</p> 
folderId | **string**<br><p>ID of the folder that the backend group belongs to.</p> 
labels | **object**<br><p>Resource labels as <code>key:value</code> pairs. Maximum of 64 per resource.</p> 
http | **object** <br> includes only one of the fields `http`, `grpc`<br><br>
http.<br>backends[] | **object**<br>
http.<br>backends[].<br>name | **string**<br><p>Required. Name.</p> 
http.<br>backends[].<br>backendWeight | **integer** (int64)<br><p>Traffic will be split between backends of the same BackendGroup according to their weights. If not set, backend will be disabled.</p> 
http.<br>backends[].<br>loadBalancingConfig | **object**<br>
http.<br>backends[].<br>loadBalancingConfig.<br>panicThreshold | **string** (int64)<br><p>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
http.<br>backends[].<br>loadBalancingConfig.<br>localityAwareRoutingPercent | **string** (int64)<br><p>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
http.<br>backends[].<br>port | **string** (int64)<br><p>Port for all targets from target group.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
http.<br>backends[].<br>healthchecks[] | **object**<br><p>Active health check.</p> 
http.<br>backends[].<br>healthchecks[].<br>timeout | **string**<br><p>Required. Time to wait for a health check response.</p> 
http.<br>backends[].<br>healthchecks[].<br>interval | **string**<br><p>Required. Interval between health checks.</p> 
http.<br>backends[].<br>healthchecks[].<br>intervalJitterPercent | **number** (double)<br><p>An optional jitter amount as a percentage of interval. If specified, during every interval value of (interval_ms * interval_jitter_percent / 100) will be added to the wait time.</p> 
http.<br>backends[].<br>healthchecks[].<br>healthyThreshold | **string** (int64)<br><p>Number of consecutive successful health checks required to promote endpoint into the healthy state. 0 means 1. Note that during startup, only a single successful health check is required to mark a host healthy.</p> 
http.<br>backends[].<br>healthchecks[].<br>unhealthyThreshold | **string** (int64)<br><p>Number of consecutive failed health checks required to demote endpoint into the unhealthy state. 0 means 1. Note that for HTTP health checks, a single 503 immediately makes endpoint unhealthy.</p> 
http.<br>backends[].<br>healthchecks[].<br>healthcheckPort | **string** (int64)<br><p>Optional alternative port for health checking.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
http.<br>backends[].<br>healthchecks[].<br>stream | **object** <br>`http.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br><p>TCP (+TLS) health check (&quot;Stream protocol HC&quot;).</p> 
http.<br>backends[].<br>healthchecks[].<br>stream.<br>send | **object**<br><p>Optional message to send. If empty, it's a connect-only health check.</p> 
http.<br>backends[].<br>healthchecks[].<br>stream.<br>send.<br>text | **string**<br><p>Text message.</p> <p>The string length in characters must be greater than 0.</p> 
http.<br>backends[].<br>healthchecks[].<br>stream.<br>receive | **object**<br><p>Optional text to search in reply.</p> 
http.<br>backends[].<br>healthchecks[].<br>stream.<br>receive.<br>text | **string**<br><p>Text message.</p> <p>The string length in characters must be greater than 0.</p> 
http.<br>backends[].<br>healthchecks[].<br>http | **object** <br>`http.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br>
http.<br>backends[].<br>healthchecks[].<br>http.<br>host | **string**<br><p>Optional &quot;Host&quot; HTTP header value.</p> 
http.<br>backends[].<br>healthchecks[].<br>http.<br>path | **string**<br><p>Required. HTTP path.</p> 
http.<br>backends[].<br>healthchecks[].<br>http.<br>useHttp2 | **boolean** (boolean)<br><p>If set, health checks will use HTTP/2.</p> 
http.<br>backends[].<br>healthchecks[].<br>grpc | **object** <br>`http.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br>
http.<br>backends[].<br>healthchecks[].<br>grpc.<br>serviceName | **string**<br><p>Optional service name for grpc.health.v1.HealthCheckRequest message.</p> 
http.<br>backends[].<br>tls | **object**<br>TLS settings for the upstream.<br>
http.<br>backends[].<br>tls.<br>sni | **string**<br><p>SNI string for TLS connections.</p> 
http.<br>backends[].<br>tls.<br>tlsOptions | **object**<br><p>Common TLS options used for backend TLS connections.</p> 
http.<br>backends[].<br>tls.<br>tlsOptions.<br>tlsMinVersion | **string**<br><p>Minimum TLS protocol version.</p> 
http.<br>backends[].<br>tls.<br>tlsOptions.<br>tlsMaxVersion | **string**<br><p>Maximum TLS protocol version.</p> 
http.<br>backends[].<br>tls.<br>tlsOptions.<br>cipherSuites[] | **string**<br><p>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used.</p> 
http.<br>backends[].<br>tls.<br>tlsOptions.<br>ecdhCurves[] | **string**<br><p>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used.</p> 
http.<br>backends[].<br>tls.<br>validationContext | **object**<br><p>Validation context for backend TLS connections.</p> 
http.<br>backends[].<br>tls.<br>validationContext.<br>trustedCaId | **string** <br>`http.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br><p>Trusted CA certificate ID in the Certificate Manager.</p> 
http.<br>backends[].<br>tls.<br>validationContext.<br>trustedCaBytes | **string** <br>`http.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br><p>Trusted CA blob.</p> 
http.<br>backends[].<br>useHttp2 | **boolean** (boolean)<br><p>Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default.</p> 
http.<br>backends[].<br>targetGroup | **object**<br>References target group for the backend.<br>
http.<br>backends[].<br>targetGroup.<br>targetGroupId | **string**<br><p>Required.</p> 
grpc | **object** <br> includes only one of the fields `http`, `grpc`<br><br>
grpc.<br>backends[] | **object**<br>
grpc.<br>backends[].<br>name | **string**<br><p>Required. Name.</p> 
grpc.<br>backends[].<br>backendWeight | **integer** (int64)<br><p>Traffic will be split between backends of the same BackendGroup according to their weights. If not set, backend will be disabled.</p> 
grpc.<br>backends[].<br>loadBalancingConfig | **object**<br>
grpc.<br>backends[].<br>loadBalancingConfig.<br>panicThreshold | **string** (int64)<br><p>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
grpc.<br>backends[].<br>loadBalancingConfig.<br>localityAwareRoutingPercent | **string** (int64)<br><p>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
grpc.<br>backends[].<br>port | **string** (int64)<br><p>Port for all targets from target group.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
grpc.<br>backends[].<br>healthchecks[] | **object**<br><p>Active health check.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>timeout | **string**<br><p>Required. Time to wait for a health check response.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>interval | **string**<br><p>Required. Interval between health checks.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>intervalJitterPercent | **number** (double)<br><p>An optional jitter amount as a percentage of interval. If specified, during every interval value of (interval_ms * interval_jitter_percent / 100) will be added to the wait time.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>healthyThreshold | **string** (int64)<br><p>Number of consecutive successful health checks required to promote endpoint into the healthy state. 0 means 1. Note that during startup, only a single successful health check is required to mark a host healthy.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>unhealthyThreshold | **string** (int64)<br><p>Number of consecutive failed health checks required to demote endpoint into the unhealthy state. 0 means 1. Note that for HTTP health checks, a single 503 immediately makes endpoint unhealthy.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>healthcheckPort | **string** (int64)<br><p>Optional alternative port for health checking.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>stream | **object** <br>`grpc.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br><p>TCP (+TLS) health check (&quot;Stream protocol HC&quot;).</p> 
grpc.<br>backends[].<br>healthchecks[].<br>stream.<br>send | **object**<br><p>Optional message to send. If empty, it's a connect-only health check.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>stream.<br>send.<br>text | **string**<br><p>Text message.</p> <p>The string length in characters must be greater than 0.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>stream.<br>receive | **object**<br><p>Optional text to search in reply.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>stream.<br>receive.<br>text | **string**<br><p>Text message.</p> <p>The string length in characters must be greater than 0.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>http | **object** <br>`grpc.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br>
grpc.<br>backends[].<br>healthchecks[].<br>http.<br>host | **string**<br><p>Optional &quot;Host&quot; HTTP header value.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>http.<br>path | **string**<br><p>Required. HTTP path.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>http.<br>useHttp2 | **boolean** (boolean)<br><p>If set, health checks will use HTTP/2.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>grpc | **object** <br>`grpc.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br>
grpc.<br>backends[].<br>healthchecks[].<br>grpc.<br>serviceName | **string**<br><p>Optional service name for grpc.health.v1.HealthCheckRequest message.</p> 
grpc.<br>backends[].<br>tls | **object**<br>TLS settings for the upstream.<br>
grpc.<br>backends[].<br>tls.<br>sni | **string**<br><p>SNI string for TLS connections.</p> 
grpc.<br>backends[].<br>tls.<br>tlsOptions | **object**<br><p>Common TLS options used for backend TLS connections.</p> 
grpc.<br>backends[].<br>tls.<br>tlsOptions.<br>tlsMinVersion | **string**<br><p>Minimum TLS protocol version.</p> 
grpc.<br>backends[].<br>tls.<br>tlsOptions.<br>tlsMaxVersion | **string**<br><p>Maximum TLS protocol version.</p> 
grpc.<br>backends[].<br>tls.<br>tlsOptions.<br>cipherSuites[] | **string**<br><p>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used.</p> 
grpc.<br>backends[].<br>tls.<br>tlsOptions.<br>ecdhCurves[] | **string**<br><p>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used.</p> 
grpc.<br>backends[].<br>tls.<br>validationContext | **object**<br><p>Validation context for backend TLS connections.</p> 
grpc.<br>backends[].<br>tls.<br>validationContext.<br>trustedCaId | **string** <br>`grpc.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br><p>Trusted CA certificate ID in the Certificate Manager.</p> 
grpc.<br>backends[].<br>tls.<br>validationContext.<br>trustedCaBytes | **string** <br>`grpc.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br><p>Trusted CA blob.</p> 
grpc.<br>backends[].<br>targetGroup | **object**<br>References target group for the backend.<br>
grpc.<br>backends[].<br>targetGroup.<br>targetGroupId | **string**<br><p>Required.</p> 
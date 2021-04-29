---
editable: false
---

# Method list

 

 
## HTTP request {#https-request}
```
GET https://apploadbalancer.api.cloud.yandex.net/apploadbalancer/v1/backendGroups
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
  "backendGroups": [
    {
      "id": "string",
      "name": "string",
      "description": "string",
      "folderId": "string",
      "labels": "object",
      "createdAt": "string",

      // `backendGroups[]` includes only one of the fields `http`, `grpc`
      "http": {
        "backends": [
          {
            "name": "string",
            "backendWeight": "integer",
            "loadBalancingConfig": {
              "panicThreshold": "string",
              "localityAwareRoutingPercent": "string",
              "strictLocality": true
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

                // `backendGroups[].http.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`
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
                // end of the list of possible fields`backendGroups[].http.backends[].healthchecks[]`

              }
            ],
            "tls": {
              "sni": "string",
              "validationContext": {

                // `backendGroups[].http.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`
                "trustedCaId": "string",
                "trustedCaBytes": "string",
                // end of the list of possible fields`backendGroups[].http.backends[].tls.validationContext`

              }
            },
            "useHttp2": true,
            "targetGroups": {
              "targetGroupIds": [
                "string"
              ]
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
              "localityAwareRoutingPercent": "string",
              "strictLocality": true
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

                // `backendGroups[].grpc.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`
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
                // end of the list of possible fields`backendGroups[].grpc.backends[].healthchecks[]`

              }
            ],
            "tls": {
              "sni": "string",
              "validationContext": {

                // `backendGroups[].grpc.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`
                "trustedCaId": "string",
                "trustedCaBytes": "string",
                // end of the list of possible fields`backendGroups[].grpc.backends[].tls.validationContext`

              }
            },
            "targetGroups": {
              "targetGroupIds": [
                "string"
              ]
            }
          }
        ]
      },
      // end of the list of possible fields`backendGroups[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
backendGroups[] | **object**<br>
backendGroups[].<br>id | **string**<br><p>Output only. ID of the backend group.</p> 
backendGroups[].<br>name | **string**<br><p>The name is unique within the folder. 3-63 characters long.</p> 
backendGroups[].<br>description | **string**<br><p>Description of the backend group. 0-256 characters long.</p> 
backendGroups[].<br>folderId | **string**<br><p>ID of the folder that the backend group belongs to.</p> 
backendGroups[].<br>labels | **object**<br><p>Resource labels as `key:value` pairs. Maximum of 64 per resource.</p> 
backendGroups[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp for the backend group.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
backendGroups[].<br>http | **object** <br>`backendGroups[]` includes only one of the fields `http`, `grpc`<br><br>
backendGroups[].<br>http.<br>backends[] | **object**<br>
backendGroups[].<br>http.<br>backends[].<br>name | **string**<br><p>Required. Name.</p> 
backendGroups[].<br>http.<br>backends[].<br>backendWeight | **integer** (int64)<br><p>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group.</p> 
backendGroups[].<br>http.<br>backends[].<br>loadBalancingConfig | **object**<br>
backendGroups[].<br>http.<br>backends[].<br>loadBalancingConfig.<br>panicThreshold | **string** (int64)<br><p>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
backendGroups[].<br>http.<br>backends[].<br>loadBalancingConfig.<br>localityAwareRoutingPercent | **string** (int64)<br><p>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
backendGroups[].<br>http.<br>backends[].<br>loadBalancingConfig.<br>strictLocality | **boolean** (boolean)<br><p>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones.</p> 
backendGroups[].<br>http.<br>backends[].<br>port | **string** (int64)<br><p>Port for all targets from target group.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[] | **object**<br><p>Active health check.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>timeout | **string**<br><p>Required. Time to wait for a health check response.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>interval | **string**<br><p>Required. Interval between health checks.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>intervalJitterPercent | **number** (double)<br><p>An optional jitter amount as a percentage of interval. If specified, during every interval value of (interval_ms * interval_jitter_percent / 100) will be added to the wait time.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>healthyThreshold | **string** (int64)<br><p>Number of consecutive successful health checks required to promote endpoint into the healthy state. 0 means 1. Note that during startup, only a single successful health check is required to mark a host healthy.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>unhealthyThreshold | **string** (int64)<br><p>Number of consecutive failed health checks required to demote endpoint into the unhealthy state. 0 means 1. Note that for HTTP health checks, a single 503 immediately makes endpoint unhealthy.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>healthcheckPort | **string** (int64)<br><p>Optional alternative port for health checking.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>stream | **object** <br>`backendGroups[].http.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br><p>TCP (+TLS) health check (&quot;Stream protocol HC&quot;).</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>stream.<br>send | **object**<br><p>Optional message to send. If empty, it's a connect-only health check.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>stream.<br>send.<br>text | **string**<br><p>Text message.</p> <p>The string length in characters must be greater than 0.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>stream.<br>receive | **object**<br><p>Optional text to search in reply.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>stream.<br>receive.<br>text | **string**<br><p>Text message.</p> <p>The string length in characters must be greater than 0.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>http | **object** <br>`backendGroups[].http.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br>
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>http.<br>host | **string**<br><p>Optional &quot;Host&quot; HTTP header value.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>http.<br>path | **string**<br><p>Required. HTTP path.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>http.<br>useHttp2 | **boolean** (boolean)<br><p>If set, health checks will use HTTP/2.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>grpc | **object** <br>`backendGroups[].http.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br>
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>grpc.<br>serviceName | **string**<br><p>Optional service name for grpc.health.v1.HealthCheckRequest message.</p> 
backendGroups[].<br>http.<br>backends[].<br>tls | **object**<br>TLS settings for the upstream.<br>
backendGroups[].<br>http.<br>backends[].<br>tls.<br>sni | **string**<br><p>SNI string for TLS connections.</p> 
backendGroups[].<br>http.<br>backends[].<br>tls.<br>validationContext | **object**<br><p>Validation context for backend TLS connections.</p> 
backendGroups[].<br>http.<br>backends[].<br>tls.<br>validationContext.<br>trustedCaId | **string** <br>`backendGroups[].http.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br><p>Trusted CA certificate ID in the Certificate Manager.</p> 
backendGroups[].<br>http.<br>backends[].<br>tls.<br>validationContext.<br>trustedCaBytes | **string** <br>`backendGroups[].http.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br><p>Trusted CA blob.</p> 
backendGroups[].<br>http.<br>backends[].<br>useHttp2 | **boolean** (boolean)<br><p>Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default.</p> 
backendGroups[].<br>http.<br>backends[].<br>targetGroups | **object**<br>References target groups for the backend.<br>
backendGroups[].<br>http.<br>backends[].<br>targetGroups.<br>targetGroupIds[] | **string**<br><p>Required. Must contain at least one element.</p> 
backendGroups[].<br>grpc | **object** <br>`backendGroups[]` includes only one of the fields `http`, `grpc`<br><br>
backendGroups[].<br>grpc.<br>backends[] | **object**<br>
backendGroups[].<br>grpc.<br>backends[].<br>name | **string**<br><p>Required. Name.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>backendWeight | **integer** (int64)<br><p>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>loadBalancingConfig | **object**<br>
backendGroups[].<br>grpc.<br>backends[].<br>loadBalancingConfig.<br>panicThreshold | **string** (int64)<br><p>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>loadBalancingConfig.<br>localityAwareRoutingPercent | **string** (int64)<br><p>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>loadBalancingConfig.<br>strictLocality | **boolean** (boolean)<br><p>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>port | **string** (int64)<br><p>Port for all targets from target group.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[] | **object**<br><p>Active health check.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>timeout | **string**<br><p>Required. Time to wait for a health check response.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>interval | **string**<br><p>Required. Interval between health checks.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>intervalJitterPercent | **number** (double)<br><p>An optional jitter amount as a percentage of interval. If specified, during every interval value of (interval_ms * interval_jitter_percent / 100) will be added to the wait time.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>healthyThreshold | **string** (int64)<br><p>Number of consecutive successful health checks required to promote endpoint into the healthy state. 0 means 1. Note that during startup, only a single successful health check is required to mark a host healthy.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>unhealthyThreshold | **string** (int64)<br><p>Number of consecutive failed health checks required to demote endpoint into the unhealthy state. 0 means 1. Note that for HTTP health checks, a single 503 immediately makes endpoint unhealthy.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>healthcheckPort | **string** (int64)<br><p>Optional alternative port for health checking.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>stream | **object** <br>`backendGroups[].grpc.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br><p>TCP (+TLS) health check (&quot;Stream protocol HC&quot;).</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>stream.<br>send | **object**<br><p>Optional message to send. If empty, it's a connect-only health check.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>stream.<br>send.<br>text | **string**<br><p>Text message.</p> <p>The string length in characters must be greater than 0.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>stream.<br>receive | **object**<br><p>Optional text to search in reply.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>stream.<br>receive.<br>text | **string**<br><p>Text message.</p> <p>The string length in characters must be greater than 0.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>http | **object** <br>`backendGroups[].grpc.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br>
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>http.<br>host | **string**<br><p>Optional &quot;Host&quot; HTTP header value.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>http.<br>path | **string**<br><p>Required. HTTP path.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>http.<br>useHttp2 | **boolean** (boolean)<br><p>If set, health checks will use HTTP/2.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>grpc | **object** <br>`backendGroups[].grpc.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br>
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>grpc.<br>serviceName | **string**<br><p>Optional service name for grpc.health.v1.HealthCheckRequest message.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>tls | **object**<br>TLS settings for the upstream.<br>
backendGroups[].<br>grpc.<br>backends[].<br>tls.<br>sni | **string**<br><p>SNI string for TLS connections.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>tls.<br>validationContext | **object**<br><p>Validation context for backend TLS connections.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>tls.<br>validationContext.<br>trustedCaId | **string** <br>`backendGroups[].grpc.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br><p>Trusted CA certificate ID in the Certificate Manager.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>tls.<br>validationContext.<br>trustedCaBytes | **string** <br>`backendGroups[].grpc.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br><p>Trusted CA blob.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>targetGroups | **object**<br>References target groups for the backend.<br>
backendGroups[].<br>grpc.<br>backends[].<br>targetGroups.<br>targetGroupIds[] | **string**<br><p>Required. Must contain at least one element.</p> 
nextPageToken | **string**<br>
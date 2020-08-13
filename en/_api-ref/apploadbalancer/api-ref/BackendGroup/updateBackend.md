---
editable: false
---

# Method updateBackend

 

 
## HTTP request {#https-request}
```
POST https://apploadbalancer.api.cloud.yandex.net/apploadbalancer/v1/backendGroups/{backendGroupId}:updateBackend
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
backendGroupId | Required.
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",

  //  includes only one of the fields `http`, `grpc`
  "http": {
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

        // `http.healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`
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
        // end of the list of possible fields`http.healthchecks[]`

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

        // `http.tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`
        "trustedCaId": "string",
        "trustedCaBytes": "string",
        // end of the list of possible fields`http.tls.validationContext`

      }
    },
    "useHttp2": true,
    "targetGroup": {
      "targetGroupId": "string"
    }
  },
  "grpc": {
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

        // `grpc.healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`
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
        // end of the list of possible fields`grpc.healthchecks[]`

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

        // `grpc.tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`
        "trustedCaId": "string",
        "trustedCaBytes": "string",
        // end of the list of possible fields`grpc.tls.validationContext`

      }
    },
    "targetGroup": {
      "targetGroupId": "string"
    }
  },
  // end of the list of possible fields

}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>A comma-separated names off ALL fields to be updated. Оnly the specified fields will be changed. The others will be left untouched. If the field is specified in <code>updateMask</code> and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If <code>updateMask</code> is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
http | **object** <br> includes only one of the fields `http`, `grpc`<br><br>
http.<br>name | **string**<br><p>Required. Name.</p> 
http.<br>backendWeight | **integer** (int64)<br><p>Traffic will be split between backends of the same BackendGroup according to their weights. If not set, backend will be disabled.</p> 
http.<br>loadBalancingConfig | **object**<br>
http.<br>loadBalancingConfig.<br>panicThreshold | **string** (int64)<br><p>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
http.<br>loadBalancingConfig.<br>localityAwareRoutingPercent | **string** (int64)<br><p>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
http.<br>port | **string** (int64)<br><p>Port for all targets from target group.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
http.<br>healthchecks[] | **object**<br><p>Active health check.</p> 
http.<br>healthchecks[].<br>timeout | **string**<br><p>Required. Time to wait for a health check response.</p> 
http.<br>healthchecks[].<br>interval | **string**<br><p>Required. Interval between health checks.</p> 
http.<br>healthchecks[].<br>intervalJitterPercent | **number** (double)<br><p>An optional jitter amount as a percentage of interval. If specified, during every interval value of (interval_ms * interval_jitter_percent / 100) will be added to the wait time.</p> 
http.<br>healthchecks[].<br>healthyThreshold | **string** (int64)<br><p>Number of consecutive successful health checks required to promote endpoint into the healthy state. 0 means 1. Note that during startup, only a single successful health check is required to mark a host healthy.</p> 
http.<br>healthchecks[].<br>unhealthyThreshold | **string** (int64)<br><p>Number of consecutive failed health checks required to demote endpoint into the unhealthy state. 0 means 1. Note that for HTTP health checks, a single 503 immediately makes endpoint unhealthy.</p> 
http.<br>healthchecks[].<br>healthcheckPort | **string** (int64)<br><p>Optional alternative port for health checking.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
http.<br>healthchecks[].<br>stream | **object** <br>`http.healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br><p>TCP (+TLS) health check (&quot;Stream protocol HC&quot;).</p> 
http.<br>healthchecks[].<br>stream.<br>send | **object**<br><p>Optional message to send. If empty, it's a connect-only health check.</p> 
http.<br>healthchecks[].<br>stream.<br>send.<br>text | **string**<br><p>Text message.</p> <p>The string length in characters must be greater than 0.</p> 
http.<br>healthchecks[].<br>stream.<br>receive | **object**<br><p>Optional text to search in reply.</p> 
http.<br>healthchecks[].<br>stream.<br>receive.<br>text | **string**<br><p>Text message.</p> <p>The string length in characters must be greater than 0.</p> 
http.<br>healthchecks[].<br>http | **object** <br>`http.healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br>
http.<br>healthchecks[].<br>http.<br>host | **string**<br><p>Optional &quot;Host&quot; HTTP header value.</p> 
http.<br>healthchecks[].<br>http.<br>path | **string**<br><p>Required. HTTP path.</p> 
http.<br>healthchecks[].<br>http.<br>useHttp2 | **boolean** (boolean)<br><p>If set, health checks will use HTTP/2.</p> 
http.<br>healthchecks[].<br>grpc | **object** <br>`http.healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br>
http.<br>healthchecks[].<br>grpc.<br>serviceName | **string**<br><p>Optional service name for grpc.health.v1.HealthCheckRequest message.</p> 
http.<br>tls | **object**<br>TLS settings for the upstream.<br>
http.<br>tls.<br>sni | **string**<br><p>SNI string for TLS connections.</p> 
http.<br>tls.<br>tlsOptions | **object**<br><p>Common TLS options used for backend TLS connections.</p> 
http.<br>tls.<br>tlsOptions.<br>tlsMinVersion | **string**<br><p>Minimum TLS protocol version.</p> 
http.<br>tls.<br>tlsOptions.<br>tlsMaxVersion | **string**<br><p>Maximum TLS protocol version.</p> 
http.<br>tls.<br>tlsOptions.<br>cipherSuites[] | **string**<br><p>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used.</p> 
http.<br>tls.<br>tlsOptions.<br>ecdhCurves[] | **string**<br><p>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used.</p> 
http.<br>tls.<br>validationContext | **object**<br><p>Validation context for backend TLS connections.</p> 
http.<br>tls.<br>validationContext.<br>trustedCaId | **string** <br>`http.tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br><p>Trusted CA certificate ID in the Certificate Manager.</p> 
http.<br>tls.<br>validationContext.<br>trustedCaBytes | **string** <br>`http.tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br><p>Trusted CA blob.</p> 
http.<br>useHttp2 | **boolean** (boolean)<br><p>Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default.</p> 
http.<br>targetGroup | **object**<br>References target group for the backend.<br>
http.<br>targetGroup.<br>targetGroupId | **string**<br><p>Required.</p> 
grpc | **object** <br> includes only one of the fields `http`, `grpc`<br><br>
grpc.<br>name | **string**<br><p>Required. Name.</p> 
grpc.<br>backendWeight | **integer** (int64)<br><p>Traffic will be split between backends of the same BackendGroup according to their weights. If not set, backend will be disabled.</p> 
grpc.<br>loadBalancingConfig | **object**<br>
grpc.<br>loadBalancingConfig.<br>panicThreshold | **string** (int64)<br><p>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
grpc.<br>loadBalancingConfig.<br>localityAwareRoutingPercent | **string** (int64)<br><p>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
grpc.<br>port | **string** (int64)<br><p>Port for all targets from target group.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
grpc.<br>healthchecks[] | **object**<br><p>Active health check.</p> 
grpc.<br>healthchecks[].<br>timeout | **string**<br><p>Required. Time to wait for a health check response.</p> 
grpc.<br>healthchecks[].<br>interval | **string**<br><p>Required. Interval between health checks.</p> 
grpc.<br>healthchecks[].<br>intervalJitterPercent | **number** (double)<br><p>An optional jitter amount as a percentage of interval. If specified, during every interval value of (interval_ms * interval_jitter_percent / 100) will be added to the wait time.</p> 
grpc.<br>healthchecks[].<br>healthyThreshold | **string** (int64)<br><p>Number of consecutive successful health checks required to promote endpoint into the healthy state. 0 means 1. Note that during startup, only a single successful health check is required to mark a host healthy.</p> 
grpc.<br>healthchecks[].<br>unhealthyThreshold | **string** (int64)<br><p>Number of consecutive failed health checks required to demote endpoint into the unhealthy state. 0 means 1. Note that for HTTP health checks, a single 503 immediately makes endpoint unhealthy.</p> 
grpc.<br>healthchecks[].<br>healthcheckPort | **string** (int64)<br><p>Optional alternative port for health checking.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
grpc.<br>healthchecks[].<br>stream | **object** <br>`grpc.healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br><p>TCP (+TLS) health check (&quot;Stream protocol HC&quot;).</p> 
grpc.<br>healthchecks[].<br>stream.<br>send | **object**<br><p>Optional message to send. If empty, it's a connect-only health check.</p> 
grpc.<br>healthchecks[].<br>stream.<br>send.<br>text | **string**<br><p>Text message.</p> <p>The string length in characters must be greater than 0.</p> 
grpc.<br>healthchecks[].<br>stream.<br>receive | **object**<br><p>Optional text to search in reply.</p> 
grpc.<br>healthchecks[].<br>stream.<br>receive.<br>text | **string**<br><p>Text message.</p> <p>The string length in characters must be greater than 0.</p> 
grpc.<br>healthchecks[].<br>http | **object** <br>`grpc.healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br>
grpc.<br>healthchecks[].<br>http.<br>host | **string**<br><p>Optional &quot;Host&quot; HTTP header value.</p> 
grpc.<br>healthchecks[].<br>http.<br>path | **string**<br><p>Required. HTTP path.</p> 
grpc.<br>healthchecks[].<br>http.<br>useHttp2 | **boolean** (boolean)<br><p>If set, health checks will use HTTP/2.</p> 
grpc.<br>healthchecks[].<br>grpc | **object** <br>`grpc.healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br>
grpc.<br>healthchecks[].<br>grpc.<br>serviceName | **string**<br><p>Optional service name for grpc.health.v1.HealthCheckRequest message.</p> 
grpc.<br>tls | **object**<br>TLS settings for the upstream.<br>
grpc.<br>tls.<br>sni | **string**<br><p>SNI string for TLS connections.</p> 
grpc.<br>tls.<br>tlsOptions | **object**<br><p>Common TLS options used for backend TLS connections.</p> 
grpc.<br>tls.<br>tlsOptions.<br>tlsMinVersion | **string**<br><p>Minimum TLS protocol version.</p> 
grpc.<br>tls.<br>tlsOptions.<br>tlsMaxVersion | **string**<br><p>Maximum TLS protocol version.</p> 
grpc.<br>tls.<br>tlsOptions.<br>cipherSuites[] | **string**<br><p>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used.</p> 
grpc.<br>tls.<br>tlsOptions.<br>ecdhCurves[] | **string**<br><p>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used.</p> 
grpc.<br>tls.<br>validationContext | **object**<br><p>Validation context for backend TLS connections.</p> 
grpc.<br>tls.<br>validationContext.<br>trustedCaId | **string** <br>`grpc.tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br><p>Trusted CA certificate ID in the Certificate Manager.</p> 
grpc.<br>tls.<br>validationContext.<br>trustedCaBytes | **string** <br>`grpc.tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br><p>Trusted CA blob.</p> 
grpc.<br>targetGroup | **object**<br>References target group for the backend.<br>
grpc.<br>targetGroup.<br>targetGroupId | **string**<br><p>Required.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is <code>false</code>, it means the operation is still in progress. If <code>true</code>, the operation is completed, and either <code>error</code> or <code>response</code> is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 
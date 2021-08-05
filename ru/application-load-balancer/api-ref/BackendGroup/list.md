---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Method list
Lists backend groups in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://alb.api.cloud.yandex.net/apploadbalancer/v1/backendGroups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list backend groups in.  To get the folder ID, make a [list](/docs/resource-manager/api-ref/Folder/list) request.
pageSize | The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/application-load-balancer/api-ref/BackendGroup/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set `page_token` to the [nextPageToken](/docs/application-load-balancer/api-ref/BackendGroup/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters backend groups listed in the response.  The expression must specify: 1. The field name. Currently you can use filtering only on [BackendGroup.name](/docs/application-load-balancer/api-ref/BackendGroup#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. Example of a filter: `name=my-backend-group`.  The maximum string length in characters is 1000.
 
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

            // `backendGroups[].http.backends[]` includes only one of the fields `targetGroups`, `storageBucket`
            "targetGroups": {
              "targetGroupIds": [
                "string"
              ]
            },
            "storageBucket": {
              "bucket": "string"
            },
            // end of the list of possible fields`backendGroups[].http.backends[]`

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
backendGroups[] | **object**<br><p>A backend group resource. For details about the concept, see <a href="/docs/application-load-balancer/concepts/backend-group">documentation</a>.</p> 
backendGroups[].<br>id | **string**<br><p>ID of the backend group. Generated at creation time.</p> 
backendGroups[].<br>name | **string**<br><p>Name of the backend group. The name is unique within the folder. The string length in characters is 3-63.</p> 
backendGroups[].<br>description | **string**<br><p>Description of the backend group. The string is 0-256 characters long.</p> 
backendGroups[].<br>folderId | **string**<br><p>ID of the folder that the backend group belongs to.</p> 
backendGroups[].<br>labels | **object**<br><p>Backend group labels as ``key:value`` pairs. For details about the concept, see <a href="/docs/overview/concepts/services#labels">documentation</a>. The maximum number of labels is 64.</p> 
backendGroups[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
backendGroups[].<br>http | **object**<br>List of HTTP backends that the backend group consists of. <br>`backendGroups[]` includes only one of the fields `http`, `grpc`<br><br><p>An HTTP backend group resource.</p> 
backendGroups[].<br>http.<br>backends[] | **object**<br>HTTP backend to add to the backend group.<br><p>An HTTP backend resource.</p> 
backendGroups[].<br>http.<br>backends[].<br>name | **string**<br><p>Required. Name of the backend.</p> <p>Value must match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
backendGroups[].<br>http.<br>backends[].<br>backendWeight | **integer** (int64)<br><p>Backend weight. Traffic is distributed between backends of a backend group according to their weights.</p> <p>Weights must be set either for all backends in a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends.</p> <p>If set to ``0``, traffic is not sent to the backend.</p> 
backendGroups[].<br>http.<br>backends[].<br>loadBalancingConfig | **object**<br>Load balancing configuration for the backend.<br><p>A load balancing configuration resource.</p> 
backendGroups[].<br>http.<br>backends[].<br>loadBalancingConfig.<br>panicThreshold | **string** (int64)<br><p>Threshold for panic mode.</p> <p>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see <a href="/docs/application-load-balancer/concepts/backend-group#panic-mode">documentation</a>.</p> <p>If the value is ``0``, panic mode will never be activated and traffic is routed only to healthy backends at all times.</p> <p>Default value: ``0``.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
backendGroups[].<br>http.<br>backends[].<br>loadBalancingConfig.<br>localityAwareRoutingPercent | **string** (int64)<br><p>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see <a href="/docs/application-load-balancer/concepts/backend-group#locality">documentation</a>.</p> <p>If there are no healthy backends in an availability zone, all the traffic is divided between other zones.</p> <p>If ``strictLocality`` is ``true``, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health.</p> <p>Default value: ``0``.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
backendGroups[].<br>http.<br>backends[].<br>loadBalancingConfig.<br>strictLocality | **boolean** (boolean)<br><p>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones.</p> <p>If set to ``true`` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see <a href="/docs/application-load-balancer/concepts/backend-group#locality">documentation</a>.</p> <p>If ``strict_locality`` is ``true``, the value specified in ``localityAwareRoutingPercent`` is ignored.</p> <p>Default value: ``false``.</p> 
backendGroups[].<br>http.<br>backends[].<br>port | **string** (int64)<br><p>Port used by all targets to receive traffic.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[] | **object**<br><p>A health check resource. For details about the concept, see <a href="/docs/application-load-balancer/concepts/backend-group#health-checks">documentation</a>.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>timeout | **string**<br><p>Required. Health check timeout.</p> <p>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>interval | **string**<br><p>Required. Base interval between consecutive health checks.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>intervalJitterPercent | **number** (double)<br>
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>healthyThreshold | **string** (int64)<br><p>Number of consecutive successful health checks required to mark an unhealthy target as healthy.</p> <p>Both ``0`` and ``1`` values amount to one successful check required.</p> <p>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check.</p> <p>Default value: ``0``.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>unhealthyThreshold | **string** (int64)<br><p>Number of consecutive failed health checks required to mark a healthy target as unhealthy.</p> <p>Both ``0`` and ``1`` values amount to one unsuccessful check required.</p> <p>The value is ignored if a health check is failed due to an HTTP ``503 Service Unavailable`` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy.</p> <p>Default value: ``0``.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>healthcheckPort | **string** (int64)<br><p>Port used for health checks.</p> <p>If not specified, the backend port (``port`` or ``port``) is used for health checks.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>stream | **object**<br>TCP stream health check settings. <br>`backendGroups[].http.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br><p>A resource for TCP stream health check settings.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>stream.<br>send | **object**<br><p>Message sent to targets during TCP data transfer.</p> <p>If not specified, no data is sent to the target.</p> <p>A health check payload resource.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>stream.<br>send.<br>text | **string**<br><p>Payload text.</p> <p>The string length in characters must be greater than 0.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>stream.<br>receive | **object**<br><p>Data that must be contained in the messages received from targets for a successful health check.</p> <p>If not specified, no messages are expected from targets, and those that are received are not checked.</p> <p>A health check payload resource.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>stream.<br>receive.<br>text | **string**<br><p>Payload text.</p> <p>The string length in characters must be greater than 0.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>http | **object**<br>HTTP health check settings. <br>`backendGroups[].http.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br><p>A resource for HTTP health check settings.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>http.<br>host | **string**<br><p>Value for the HTTP/1.1 ``Host`` header or the HTTP/2 ``:authority`` pseudo-header used in requests to targets.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>http.<br>path | **string**<br><p>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 ``:path`` pseudo-header.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>http.<br>useHttp2 | **boolean** (boolean)<br><p>Enables HTTP/2 usage in health checks.</p> <p>Default value: ``false``, HTTP/1.1 is used.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>grpc | **object**<br>gRPC health check settings. <br>`backendGroups[].http.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br><p>A resource for gRPC health check settings.</p> 
backendGroups[].<br>http.<br>backends[].<br>healthchecks[].<br>grpc.<br>serviceName | **string**<br><p>Name of the gRPC service to be checked.</p> <p>If not specified, overall health is checked.</p> <p>For details about the concept, see <a href="https://github.com/grpc/grpc/blob/master/doc/health-checking.md">GRPC Health Checking Protocol</a>.</p> 
backendGroups[].<br>http.<br>backends[].<br>tls | **object**<br>Settings for TLS connections between load balancer nodes and backend targets.  If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in `validationContext`. If not specified, the load balancer establishes unencrypted HTTP connections with targets.<br><p>A resource for backend TLS settings.</p> 
backendGroups[].<br>http.<br>backends[].<br>tls.<br>sni | **string**<br><p>Server Name Indication (SNI) string for TLS connections.</p> 
backendGroups[].<br>http.<br>backends[].<br>tls.<br>validationContext | **object**<br><p>Validation context for TLS connections.</p> <p>A TLS validation context resource.</p> 
backendGroups[].<br>http.<br>backends[].<br>tls.<br>validationContext.<br>trustedCaId | **string** <br>`backendGroups[].http.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br>
backendGroups[].<br>http.<br>backends[].<br>tls.<br>validationContext.<br>trustedCaBytes | **string** <br>`backendGroups[].http.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br><p>X.509 certificate contents in PEM format.</p> 
backendGroups[].<br>http.<br>backends[].<br>useHttp2 | **boolean** (boolean)<br><p>Enables HTTP/2 usage in connections between load balancer nodes and backend targets.</p> <p>Default value: ``false``, HTTP/1.1 is used.</p> 
backendGroups[].<br>http.<br>backends[].<br>targetGroups | **object**<br>Target groups that belong to the backend. <br>`backendGroups[].http.backends[]` includes only one of the fields `targetGroups`, `storageBucket`<br><br><p>A resource for target groups that belong to the backend.</p> 
backendGroups[].<br>http.<br>backends[].<br>targetGroups.<br>targetGroupIds[] | **string**<br><p>Required. List of ID's of target groups that belong to the backend.</p> <p>To get the ID's of all available target groups, make a <a href="/docs/application-load-balancer/api-ref/TargetGroup/list">list</a> request.</p> <p>Must contain at least one element.</p> 
backendGroups[].<br>http.<br>backends[].<br>storageBucket | **object**<br>Storage bucket to use as a backend. <br>`backendGroups[].http.backends[]` includes only one of the fields `targetGroups`, `storageBucket`<br><br>
backendGroups[].<br>http.<br>backends[].<br>storageBucket.<br>bucket | **string**<br><p>Required. Cloud S3 bucket name. Should have public access.</p> 
backendGroups[].<br>grpc | **object**<br>List of gRPC backends that the backend group consists of. <br>`backendGroups[]` includes only one of the fields `http`, `grpc`<br><br><p>A gRPC backend group resource.</p> 
backendGroups[].<br>grpc.<br>backends[] | **object**<br>gRPC backend to add to the backend group.<br><p>A gRPC backend resource.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>name | **string**<br><p>Required. Name of the backend.</p> <p>Value must match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>backendWeight | **integer** (int64)<br><p>Backend weight. Traffic is distributed between backends of a backend group according to their weights.</p> <p>Weights must be set either for all backends of a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends.</p> <p>If set to ``0``, traffic is not sent to the backend.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>loadBalancingConfig | **object**<br>Load balancing configuration for the backend.<br><p>A load balancing configuration resource.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>loadBalancingConfig.<br>panicThreshold | **string** (int64)<br><p>Threshold for panic mode.</p> <p>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see <a href="/docs/application-load-balancer/concepts/backend-group#panic-mode">documentation</a>.</p> <p>If the value is ``0``, panic mode will never be activated and traffic is routed only to healthy backends at all times.</p> <p>Default value: ``0``.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>loadBalancingConfig.<br>localityAwareRoutingPercent | **string** (int64)<br><p>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see <a href="/docs/application-load-balancer/concepts/backend-group#locality">documentation</a>.</p> <p>If there are no healthy backends in an availability zone, all the traffic is divided between other zones.</p> <p>If ``strictLocality`` is ``true``, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health.</p> <p>Default value: ``0``.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>loadBalancingConfig.<br>strictLocality | **boolean** (boolean)<br><p>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones.</p> <p>If set to ``true`` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see <a href="/docs/application-load-balancer/concepts/backend-group#locality">documentation</a>.</p> <p>If ``strict_locality`` is ``true``, the value specified in ``localityAwareRoutingPercent`` is ignored.</p> <p>Default value: ``false``.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>port | **string** (int64)<br><p>Port used by all targets to receive traffic.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[] | **object**<br><p>A health check resource. For details about the concept, see <a href="/docs/application-load-balancer/concepts/backend-group#health-checks">documentation</a>.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>timeout | **string**<br><p>Required. Health check timeout.</p> <p>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>interval | **string**<br><p>Required. Base interval between consecutive health checks.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>intervalJitterPercent | **number** (double)<br>
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>healthyThreshold | **string** (int64)<br><p>Number of consecutive successful health checks required to mark an unhealthy target as healthy.</p> <p>Both ``0`` and ``1`` values amount to one successful check required.</p> <p>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check.</p> <p>Default value: ``0``.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>unhealthyThreshold | **string** (int64)<br><p>Number of consecutive failed health checks required to mark a healthy target as unhealthy.</p> <p>Both ``0`` and ``1`` values amount to one unsuccessful check required.</p> <p>The value is ignored if a health check is failed due to an HTTP ``503 Service Unavailable`` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy.</p> <p>Default value: ``0``.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>healthcheckPort | **string** (int64)<br><p>Port used for health checks.</p> <p>If not specified, the backend port (``port`` or ``port``) is used for health checks.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>stream | **object**<br>TCP stream health check settings. <br>`backendGroups[].grpc.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br><p>A resource for TCP stream health check settings.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>stream.<br>send | **object**<br><p>Message sent to targets during TCP data transfer.</p> <p>If not specified, no data is sent to the target.</p> <p>A health check payload resource.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>stream.<br>send.<br>text | **string**<br><p>Payload text.</p> <p>The string length in characters must be greater than 0.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>stream.<br>receive | **object**<br><p>Data that must be contained in the messages received from targets for a successful health check.</p> <p>If not specified, no messages are expected from targets, and those that are received are not checked.</p> <p>A health check payload resource.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>stream.<br>receive.<br>text | **string**<br><p>Payload text.</p> <p>The string length in characters must be greater than 0.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>http | **object**<br>HTTP health check settings. <br>`backendGroups[].grpc.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br><p>A resource for HTTP health check settings.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>http.<br>host | **string**<br><p>Value for the HTTP/1.1 ``Host`` header or the HTTP/2 ``:authority`` pseudo-header used in requests to targets.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>http.<br>path | **string**<br><p>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 ``:path`` pseudo-header.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>http.<br>useHttp2 | **boolean** (boolean)<br><p>Enables HTTP/2 usage in health checks.</p> <p>Default value: ``false``, HTTP/1.1 is used.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>grpc | **object**<br>gRPC health check settings. <br>`backendGroups[].grpc.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br><p>A resource for gRPC health check settings.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>healthchecks[].<br>grpc.<br>serviceName | **string**<br><p>Name of the gRPC service to be checked.</p> <p>If not specified, overall health is checked.</p> <p>For details about the concept, see <a href="https://github.com/grpc/grpc/blob/master/doc/health-checking.md">GRPC Health Checking Protocol</a>.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>tls | **object**<br>Settings for TLS connections between load balancer nodes and backend targets.  If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in `validationContext`. If not specified, the load balancer establishes unencrypted HTTP connections with targets.<br><p>A resource for backend TLS settings.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>tls.<br>sni | **string**<br><p>Server Name Indication (SNI) string for TLS connections.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>tls.<br>validationContext | **object**<br><p>Validation context for TLS connections.</p> <p>A TLS validation context resource.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>tls.<br>validationContext.<br>trustedCaId | **string** <br>`backendGroups[].grpc.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br>
backendGroups[].<br>grpc.<br>backends[].<br>tls.<br>validationContext.<br>trustedCaBytes | **string** <br>`backendGroups[].grpc.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br><p>X.509 certificate contents in PEM format.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>targetGroups | **object**<br>Target groups that belong to the backend.<br><p>A resource for target groups that belong to the backend.</p> 
backendGroups[].<br>grpc.<br>backends[].<br>targetGroups.<br>targetGroupIds[] | **string**<br><p>Required. List of ID's of target groups that belong to the backend.</p> <p>To get the ID's of all available target groups, make a <a href="/docs/application-load-balancer/api-ref/TargetGroup/list">list</a> request.</p> <p>Must contain at least one element.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/application-load-balancer/api-ref/BackendGroup/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/application-load-balancer/api-ref/BackendGroup/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 
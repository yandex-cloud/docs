---
editable: false
---

# Method create
Creates a backend group in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://alb.{{ api-host }}/apploadbalancer/v1/backendGroups
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",

  //  includes only one of the fields `http`, `grpc`, `stream`
  "http": {
    "backends": [
      {
        "name": "string",
        "backendWeight": "integer",
        "loadBalancingConfig": {
          "panicThreshold": "string",
          "localityAwareRoutingPercent": "string",
          "strictLocality": true,
          "mode": "string"
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

            // `http.backends[].healthchecks[]` includes only one of the fields `plaintext`, `tls`
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

            "plaintext": {},
            "tls": {
              "sni": "string",
              "validationContext": {

                // `http.backends[].healthchecks[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`
                "trustedCaId": "string",
                "trustedCaBytes": "string",
                // end of the list of possible fields`http.backends[].healthchecks[].tls.validationContext`

              }
            }
          }
        ],
        "tls": {
          "sni": "string",
          "validationContext": {

            // `http.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`
            "trustedCaId": "string",
            "trustedCaBytes": "string",
            // end of the list of possible fields`http.backends[].tls.validationContext`

          }
        },
        "useHttp2": true,

        // `http.backends[]` includes only one of the fields `targetGroups`, `storageBucket`
        "targetGroups": {
          "targetGroupIds": [
            "string"
          ]
        },
        "storageBucket": {
          "bucket": "string"
        },
        // end of the list of possible fields`http.backends[]`

      }
    ],

    // `http` includes only one of the fields `connection`, `header`, `cookie`
    "connection": {
      "sourceIp": true
    },
    "header": {
      "headerName": "string"
    },
    "cookie": {
      "name": "string",
      "ttl": "string"
    },
    // end of the list of possible fields`http`

  },
  "grpc": {
    "backends": [
      {
        "name": "string",
        "backendWeight": "integer",
        "loadBalancingConfig": {
          "panicThreshold": "string",
          "localityAwareRoutingPercent": "string",
          "strictLocality": true,
          "mode": "string"
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

            // `grpc.backends[].healthchecks[]` includes only one of the fields `plaintext`, `tls`
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

            "plaintext": {},
            "tls": {
              "sni": "string",
              "validationContext": {

                // `grpc.backends[].healthchecks[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`
                "trustedCaId": "string",
                "trustedCaBytes": "string",
                // end of the list of possible fields`grpc.backends[].healthchecks[].tls.validationContext`

              }
            }
          }
        ],
        "tls": {
          "sni": "string",
          "validationContext": {

            // `grpc.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`
            "trustedCaId": "string",
            "trustedCaBytes": "string",
            // end of the list of possible fields`grpc.backends[].tls.validationContext`

          }
        },
        "targetGroups": {
          "targetGroupIds": [
            "string"
          ]
        }
      }
    ],

    // `grpc` includes only one of the fields `connection`, `header`, `cookie`
    "connection": {
      "sourceIp": true
    },
    "header": {
      "headerName": "string"
    },
    "cookie": {
      "name": "string",
      "ttl": "string"
    },
    // end of the list of possible fields`grpc`

  },
  "stream": {
    "backends": [
      {
        "name": "string",
        "backendWeight": "integer",
        "loadBalancingConfig": {
          "panicThreshold": "string",
          "localityAwareRoutingPercent": "string",
          "strictLocality": true,
          "mode": "string"
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

            // `stream.backends[].healthchecks[]` includes only one of the fields `plaintext`, `tls`
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
            // end of the list of possible fields`stream.backends[].healthchecks[]`

            "plaintext": {},
            "tls": {
              "sni": "string",
              "validationContext": {

                // `stream.backends[].healthchecks[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`
                "trustedCaId": "string",
                "trustedCaBytes": "string",
                // end of the list of possible fields`stream.backends[].healthchecks[].tls.validationContext`

              }
            }
          }
        ],
        "tls": {
          "sni": "string",
          "validationContext": {

            // `stream.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`
            "trustedCaId": "string",
            "trustedCaBytes": "string",
            // end of the list of possible fields`stream.backends[].tls.validationContext`

          }
        },
        "enableProxyProtocol": true,
        "targetGroups": {
          "targetGroupIds": [
            "string"
          ]
        }
      }
    ],
    "connection": {
      "sourceIp": true
    }
  },
  // end of the list of possible fields

}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create a backend group in.</p> <p>To get the folder ID, make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> 
name | **string**<br><p>Name of the backend group. The name must be unique within the folder.</p> <p>Value must match the regular expression ``([a-z]([-a-z0-9]{0,61}[a-z0-9])?)?``.</p> 
description | **string**<br><p>Description of the backend group.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Backend group labels as ``key:value`` pairs. For details about the concept, see <a href="/docs/overview/concepts/services#labels">documentation</a>.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_./\@0-9a-z]*``.</p> 
http | **object**<br>List of HTTP backends that the backend group will consist of. <br> includes only one of the fields `http`, `grpc`, `stream`<br><br><p>An HTTP backend group resource.</p> 
http.<br>backends[] | **object**<br>HTTP backend to add to the backend group.<br><p>List of HTTP backends.</p> 
http.<br>backends[].<br>name | **string**<br><p>Required. Name of the backend.</p> <p>Value must match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
http.<br>backends[].<br>backendWeight | **integer** (int64)<br><p>Backend weight. Traffic is distributed between backends of a backend group according to their weights.</p> <p>Weights must be set either for all backends in a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends.</p> <p>If the weight is non-positive, traffic is not sent to the backend.</p> 
http.<br>backends[].<br>loadBalancingConfig | **object**<br>Load balancing configuration for the backend.<br><p>A load balancing configuration resource.</p> 
http.<br>backends[].<br>loadBalancingConfig.<br>panicThreshold | **string** (int64)<br><p>Threshold for panic mode.</p> <p>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see <a href="/docs/application-load-balancer/concepts/backend-group#panic-mode">documentation</a>.</p> <p>If the value is ``0``, panic mode will never be activated and traffic is routed only to healthy backends at all times.</p> <p>Default value: ``0``.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
http.<br>backends[].<br>loadBalancingConfig.<br>localityAwareRoutingPercent | **string** (int64)<br><p>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see <a href="/docs/application-load-balancer/concepts/backend-group#locality">documentation</a>.</p> <p>If there are no healthy backends in an availability zone, all the traffic is divided between other zones.</p> <p>If ``strictLocality`` is ``true``, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health.</p> <p>Default value: ``0``.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
http.<br>backends[].<br>loadBalancingConfig.<br>strictLocality | **boolean** (boolean)<br><p>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones.</p> <p>If set to ``true`` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see <a href="/docs/application-load-balancer/concepts/backend-group#locality">documentation</a>.</p> <p>If ``strict_locality`` is ``true``, the value specified in ``localityAwareRoutingPercent`` is ignored.</p> <p>Default value: ``false``.</p> 
http.<br>backends[].<br>loadBalancingConfig.<br>mode | **string**<br><p>Load balancing mode for the backend.</p> <p>For details about load balancing modes, see <a href="/docs/application-load-balancer/concepts/backend-group#balancing-mode">documentation</a>.</p> <p>A load balancing mode resource. For details about the concept, see <a href="/docs/application-load-balancer/concepts/backend-group#balancing-mode">documentation</a>.</p> <ul> <li> <p>ROUND_ROBIN: Round robin load balancing mode.</p> <p>All endpoints of the backend take their turns to receive requests attributed to the backend.</p> </li> <li> <p>RANDOM: Random load balancing mode. Default value.</p> <p>For a request attributed to the backend, an endpoint that receives it is picked at random.</p> </li> <li> <p>LEAST_REQUEST: Least request load balancing mode.</p> <p>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</p> </li> <li> <p>MAGLEV_HASH: Maglev hashing load balancing mode.</p> <p>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request is also hashed by the same function (if session affinity is enabled for the backend group, the attribute to hash is specified in session affinity configuration). The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request.</p> <p>If the backend group with session affinity enabled contains more than one backend with positive weight, endpoints for backends with ``MAGLEV_HASH`` load balancing mode are picked at ``RANDOM`` instead.</p> </li> </ul> 
http.<br>backends[].<br>port | **string** (int64)<br><p>Port used by all targets to receive traffic.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
http.<br>backends[].<br>healthchecks[] | **object**<br><p>Health checks to perform on targets from target groups. For details about health checking, see <a href="/docs/application-load-balancer/concepts/backend-group#health-checks">documentation</a>.</p> <p>If no health checks are specified, active health checking is not performed.</p> 
http.<br>backends[].<br>healthchecks[].<br>timeout | **string**<br><p>Required. Health check timeout.</p> <p>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed.</p> 
http.<br>backends[].<br>healthchecks[].<br>interval | **string**<br><p>Required. Base interval between consecutive health checks.</p> 
http.<br>backends[].<br>healthchecks[].<br>intervalJitterPercent | **number** (double)<br>
http.<br>backends[].<br>healthchecks[].<br>healthyThreshold | **string** (int64)<br><p>Number of consecutive successful health checks required to mark an unhealthy target as healthy.</p> <p>Both ``0`` and ``1`` values amount to one successful check required.</p> <p>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check.</p> <p>Default value: ``0``.</p> 
http.<br>backends[].<br>healthchecks[].<br>unhealthyThreshold | **string** (int64)<br><p>Number of consecutive failed health checks required to mark a healthy target as unhealthy.</p> <p>Both ``0`` and ``1`` values amount to one unsuccessful check required.</p> <p>The value is ignored if a health check is failed due to an HTTP ``503 Service Unavailable`` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy.</p> <p>Default value: ``0``.</p> 
http.<br>backends[].<br>healthchecks[].<br>healthcheckPort | **string** (int64)<br><p>Port used for health checks.</p> <p>If not specified, the backend port (``port`` or ``port``) is used for health checks.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
http.<br>backends[].<br>healthchecks[].<br>stream | **object**<br>TCP stream health check settings. <br>`http.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br><p>A resource for TCP stream health check settings.</p> 
http.<br>backends[].<br>healthchecks[].<br>stream.<br>send | **object**<br><p>Message sent to targets during TCP data transfer.</p> <p>If not specified, no data is sent to the target.</p> <p>A health check payload resource.</p> 
http.<br>backends[].<br>healthchecks[].<br>stream.<br>send.<br>text | **string**<br><p>Payload text.</p> <p>The string length in characters must be greater than 0.</p> 
http.<br>backends[].<br>healthchecks[].<br>stream.<br>receive | **object**<br><p>Data that must be contained in the messages received from targets for a successful health check.</p> <p>If not specified, no messages are expected from targets, and those that are received are not checked.</p> <p>A health check payload resource.</p> 
http.<br>backends[].<br>healthchecks[].<br>stream.<br>receive.<br>text | **string**<br><p>Payload text.</p> <p>The string length in characters must be greater than 0.</p> 
http.<br>backends[].<br>healthchecks[].<br>http | **object**<br>HTTP health check settings. <br>`http.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br><p>A resource for HTTP health check settings.</p> 
http.<br>backends[].<br>healthchecks[].<br>http.<br>host | **string**<br><p>Value for the HTTP/1.1 ``Host`` header or the HTTP/2 ``:authority`` pseudo-header used in requests to targets.</p> 
http.<br>backends[].<br>healthchecks[].<br>http.<br>path | **string**<br><p>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 ``:path`` pseudo-header.</p> 
http.<br>backends[].<br>healthchecks[].<br>http.<br>useHttp2 | **boolean** (boolean)<br><p>Enables HTTP/2 usage in health checks.</p> <p>Default value: ``false``, HTTP/1.1 is used.</p> 
http.<br>backends[].<br>healthchecks[].<br>grpc | **object**<br>gRPC health check settings. <br>`http.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br><p>A resource for gRPC health check settings.</p> 
http.<br>backends[].<br>healthchecks[].<br>grpc.<br>serviceName | **string**<br><p>Name of the gRPC service to be checked.</p> <p>If not specified, overall health is checked.</p> <p>For details about the concept, see <a href="https://github.com/grpc/grpc/blob/master/doc/health-checking.md">GRPC Health Checking Protocol</a>.</p> 
http.<br>backends[].<br>healthchecks[].<br>plaintext | **object** <br>`http.backends[].healthchecks[]` includes only one of the fields `plaintext`, `tls`<br><br><p>Transport settings to be used instead of the settings configured per-cluster</p> 
http.<br>backends[].<br>healthchecks[].<br>tls | **object** <br>`http.backends[].healthchecks[]` includes only one of the fields `plaintext`, `tls`<br><br><p>Transport settings to be used instead of the settings configured per-cluster</p> 
http.<br>backends[].<br>healthchecks[].<br>tls.<br>sni | **string**<br><p>SNI string for TLS connections.</p> 
http.<br>backends[].<br>healthchecks[].<br>tls.<br>validationContext | **object**<br><p>Validation context for backend TLS connections.</p> <p>A TLS validation context resource.</p> 
http.<br>backends[].<br>healthchecks[].<br>tls.<br>validationContext.<br>trustedCaId | **string** <br>`http.backends[].healthchecks[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br>
http.<br>backends[].<br>healthchecks[].<br>tls.<br>validationContext.<br>trustedCaBytes | **string** <br>`http.backends[].healthchecks[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br><p>X.509 certificate contents in PEM format.</p> 
http.<br>backends[].<br>tls | **object**<br>Settings for TLS connections between load balancer nodes and backend targets.  If specified, the load balancer establishes TLS-encrypted TCP connections with targets and compares received certificates with the one specified in `validationContext`. If not specified, the load balancer establishes unencrypted TCP connections with targets.<br><p>A resource for backend TLS settings.</p> 
http.<br>backends[].<br>tls.<br>sni | **string**<br><p>Server Name Indication (SNI) string for TLS connections.</p> 
http.<br>backends[].<br>tls.<br>validationContext | **object**<br><p>Validation context for TLS connections.</p> <p>A TLS validation context resource.</p> 
http.<br>backends[].<br>tls.<br>validationContext.<br>trustedCaId | **string** <br>`http.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br>
http.<br>backends[].<br>tls.<br>validationContext.<br>trustedCaBytes | **string** <br>`http.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br><p>X.509 certificate contents in PEM format.</p> 
http.<br>backends[].<br>useHttp2 | **boolean** (boolean)<br><p>Enables HTTP/2 usage in connections between load balancer nodes and backend targets.</p> <p>Default value: ``false``, HTTP/1.1 is used.</p> 
http.<br>backends[].<br>targetGroups | **object**<br>Target groups that belong to the backend. For details about target groups, see [documentation](/docs/application-load-balancer/concepts/target-group). <br>`http.backends[]` includes only one of the fields `targetGroups`, `storageBucket`<br><br><p>A resource for target groups that belong to the backend.</p> 
http.<br>backends[].<br>targetGroups.<br>targetGroupIds[] | **string**<br><p>Required. List of ID's of target groups that belong to the backend.</p> <p>To get the ID's of all available target groups, make a <a href="/docs/application-load-balancer/api-ref/TargetGroup/list">list</a> request.</p> <p>Must contain at least one element.</p> 
http.<br>backends[].<br>storageBucket | **object**<br>Object Storage bucket to use as the backend. For details about buckets, see [documentation](/docs/storage/concepts/bucket).  If a bucket is used as a backend, the list of bucket objects and the objects themselves must be publicly accessible. For instructions, see [documentation](/docs/storage/operations/buckets/bucket-availability). <br>`http.backends[]` includes only one of the fields `targetGroups`, `storageBucket`<br><br><p>A resource for Object Storage bucket used as a backend. For details about the concept, see <a href="/docs/storage/concepts/bucket">documentation</a>.</p> 
http.<br>backends[].<br>storageBucket.<br>bucket | **string**<br><p>Required. Name of the bucket.</p> 
http.<br>connection | **object**<br>Connection-based session affinity configuration.  For now, a connection is defined only by an IP address of the client. <br>`http` includes only one of the fields `connection`, `header`, `cookie`<br><br><p>A resource for connection-based session affinity configuration.</p> 
http.<br>connection.<br>sourceIp | **boolean** (boolean)<br><p>Specifies whether an IP address of the client is used to define a connection for session affinity.</p> 
http.<br>header | **object**<br>HTTP-header-field-based session affinity configuration. <br>`http` includes only one of the fields `connection`, `header`, `cookie`<br><br><p>A resource for HTTP-header-field-based session affinity configuration.</p> 
http.<br>header.<br>headerName | **string**<br><p>Name of the HTTP header field that is used for session affinity.</p> <p>The string length in characters must be 1-256.</p> 
http.<br>cookie | **object**<br>Cookie-based session affinity configuration. <br>`http` includes only one of the fields `connection`, `header`, `cookie`<br><br><p>A resource for cookie-based session affinity configuration.</p> 
http.<br>cookie.<br>name | **string**<br><p>Name of the cookie that is used for session affinity.</p> <p>The string length in characters must be 1-256.</p> 
http.<br>cookie.<br>ttl | **string**<br><p>Maximum age of cookies that are generated for sessions.</p> <p>If set to ``0``, session cookies are used, which are stored by clients in temporary memory and are deleted on client restarts.</p> <p>If not set, the balancer does not generate cookies and only uses incoming ones for establishing session affinity.</p> 
grpc | **object**<br>List of gRPC backends that the backend group consists of. <br> includes only one of the fields `http`, `grpc`, `stream`<br><br><p>A gRPC backend group resource.</p> 
grpc.<br>backends[] | **object**<br>gRPC backend to add to the backend group.<br><p>List of gRPC backends.</p> 
grpc.<br>backends[].<br>name | **string**<br><p>Required. Name of the backend.</p> <p>Value must match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
grpc.<br>backends[].<br>backendWeight | **integer** (int64)<br><p>Backend weight. Traffic is distributed between backends of a backend group according to their weights.</p> <p>Weights must be set either for all backends of a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends.</p> <p>If the weight is non-positive, traffic is not sent to the backend.</p> 
grpc.<br>backends[].<br>loadBalancingConfig | **object**<br>Load balancing configuration for the backend.<br><p>A load balancing configuration resource.</p> 
grpc.<br>backends[].<br>loadBalancingConfig.<br>panicThreshold | **string** (int64)<br><p>Threshold for panic mode.</p> <p>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see <a href="/docs/application-load-balancer/concepts/backend-group#panic-mode">documentation</a>.</p> <p>If the value is ``0``, panic mode will never be activated and traffic is routed only to healthy backends at all times.</p> <p>Default value: ``0``.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
grpc.<br>backends[].<br>loadBalancingConfig.<br>localityAwareRoutingPercent | **string** (int64)<br><p>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see <a href="/docs/application-load-balancer/concepts/backend-group#locality">documentation</a>.</p> <p>If there are no healthy backends in an availability zone, all the traffic is divided between other zones.</p> <p>If ``strictLocality`` is ``true``, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health.</p> <p>Default value: ``0``.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
grpc.<br>backends[].<br>loadBalancingConfig.<br>strictLocality | **boolean** (boolean)<br><p>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones.</p> <p>If set to ``true`` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see <a href="/docs/application-load-balancer/concepts/backend-group#locality">documentation</a>.</p> <p>If ``strict_locality`` is ``true``, the value specified in ``localityAwareRoutingPercent`` is ignored.</p> <p>Default value: ``false``.</p> 
grpc.<br>backends[].<br>loadBalancingConfig.<br>mode | **string**<br><p>Load balancing mode for the backend.</p> <p>For details about load balancing modes, see <a href="/docs/application-load-balancer/concepts/backend-group#balancing-mode">documentation</a>.</p> <p>A load balancing mode resource. For details about the concept, see <a href="/docs/application-load-balancer/concepts/backend-group#balancing-mode">documentation</a>.</p> <ul> <li> <p>ROUND_ROBIN: Round robin load balancing mode.</p> <p>All endpoints of the backend take their turns to receive requests attributed to the backend.</p> </li> <li> <p>RANDOM: Random load balancing mode. Default value.</p> <p>For a request attributed to the backend, an endpoint that receives it is picked at random.</p> </li> <li> <p>LEAST_REQUEST: Least request load balancing mode.</p> <p>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</p> </li> <li> <p>MAGLEV_HASH: Maglev hashing load balancing mode.</p> <p>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request is also hashed by the same function (if session affinity is enabled for the backend group, the attribute to hash is specified in session affinity configuration). The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request.</p> <p>If the backend group with session affinity enabled contains more than one backend with positive weight, endpoints for backends with ``MAGLEV_HASH`` load balancing mode are picked at ``RANDOM`` instead.</p> </li> </ul> 
grpc.<br>backends[].<br>port | **string** (int64)<br><p>Port used by all targets to receive traffic.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
grpc.<br>backends[].<br>healthchecks[] | **object**<br><p>Health checks to perform on targets from target groups. For details about health checking, see <a href="/docs/application-load-balancer/concepts/backend-group#health-checks">documentation</a>.</p> <p>If no health checks are specified, active health checking is not performed.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>timeout | **string**<br><p>Required. Health check timeout.</p> <p>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>interval | **string**<br><p>Required. Base interval between consecutive health checks.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>intervalJitterPercent | **number** (double)<br>
grpc.<br>backends[].<br>healthchecks[].<br>healthyThreshold | **string** (int64)<br><p>Number of consecutive successful health checks required to mark an unhealthy target as healthy.</p> <p>Both ``0`` and ``1`` values amount to one successful check required.</p> <p>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check.</p> <p>Default value: ``0``.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>unhealthyThreshold | **string** (int64)<br><p>Number of consecutive failed health checks required to mark a healthy target as unhealthy.</p> <p>Both ``0`` and ``1`` values amount to one unsuccessful check required.</p> <p>The value is ignored if a health check is failed due to an HTTP ``503 Service Unavailable`` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy.</p> <p>Default value: ``0``.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>healthcheckPort | **string** (int64)<br><p>Port used for health checks.</p> <p>If not specified, the backend port (``port`` or ``port``) is used for health checks.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>stream | **object**<br>TCP stream health check settings. <br>`grpc.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br><p>A resource for TCP stream health check settings.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>stream.<br>send | **object**<br><p>Message sent to targets during TCP data transfer.</p> <p>If not specified, no data is sent to the target.</p> <p>A health check payload resource.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>stream.<br>send.<br>text | **string**<br><p>Payload text.</p> <p>The string length in characters must be greater than 0.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>stream.<br>receive | **object**<br><p>Data that must be contained in the messages received from targets for a successful health check.</p> <p>If not specified, no messages are expected from targets, and those that are received are not checked.</p> <p>A health check payload resource.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>stream.<br>receive.<br>text | **string**<br><p>Payload text.</p> <p>The string length in characters must be greater than 0.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>http | **object**<br>HTTP health check settings. <br>`grpc.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br><p>A resource for HTTP health check settings.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>http.<br>host | **string**<br><p>Value for the HTTP/1.1 ``Host`` header or the HTTP/2 ``:authority`` pseudo-header used in requests to targets.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>http.<br>path | **string**<br><p>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 ``:path`` pseudo-header.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>http.<br>useHttp2 | **boolean** (boolean)<br><p>Enables HTTP/2 usage in health checks.</p> <p>Default value: ``false``, HTTP/1.1 is used.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>grpc | **object**<br>gRPC health check settings. <br>`grpc.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br><p>A resource for gRPC health check settings.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>grpc.<br>serviceName | **string**<br><p>Name of the gRPC service to be checked.</p> <p>If not specified, overall health is checked.</p> <p>For details about the concept, see <a href="https://github.com/grpc/grpc/blob/master/doc/health-checking.md">GRPC Health Checking Protocol</a>.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>plaintext | **object** <br>`grpc.backends[].healthchecks[]` includes only one of the fields `plaintext`, `tls`<br><br><p>Transport settings to be used instead of the settings configured per-cluster</p> 
grpc.<br>backends[].<br>healthchecks[].<br>tls | **object** <br>`grpc.backends[].healthchecks[]` includes only one of the fields `plaintext`, `tls`<br><br><p>Transport settings to be used instead of the settings configured per-cluster</p> 
grpc.<br>backends[].<br>healthchecks[].<br>tls.<br>sni | **string**<br><p>SNI string for TLS connections.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>tls.<br>validationContext | **object**<br><p>Validation context for backend TLS connections.</p> <p>A TLS validation context resource.</p> 
grpc.<br>backends[].<br>healthchecks[].<br>tls.<br>validationContext.<br>trustedCaId | **string** <br>`grpc.backends[].healthchecks[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br>
grpc.<br>backends[].<br>healthchecks[].<br>tls.<br>validationContext.<br>trustedCaBytes | **string** <br>`grpc.backends[].healthchecks[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br><p>X.509 certificate contents in PEM format.</p> 
grpc.<br>backends[].<br>tls | **object**<br>Settings for TLS connections between load balancer nodes and backend targets.  If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in `validationContext`. If not specified, the load balancer establishes unencrypted HTTP connections with targets.<br><p>A resource for backend TLS settings.</p> 
grpc.<br>backends[].<br>tls.<br>sni | **string**<br><p>Server Name Indication (SNI) string for TLS connections.</p> 
grpc.<br>backends[].<br>tls.<br>validationContext | **object**<br><p>Validation context for TLS connections.</p> <p>A TLS validation context resource.</p> 
grpc.<br>backends[].<br>tls.<br>validationContext.<br>trustedCaId | **string** <br>`grpc.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br>
grpc.<br>backends[].<br>tls.<br>validationContext.<br>trustedCaBytes | **string** <br>`grpc.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br><p>X.509 certificate contents in PEM format.</p> 
grpc.<br>backends[].<br>targetGroups | **object**<br>Target groups that belong to the backend. For details about target groups, see [documentation](/docs/application-load-balancer/concepts/target-group).<br><p>A resource for target groups that belong to the backend.</p> 
grpc.<br>backends[].<br>targetGroups.<br>targetGroupIds[] | **string**<br><p>Required. List of ID's of target groups that belong to the backend.</p> <p>To get the ID's of all available target groups, make a <a href="/docs/application-load-balancer/api-ref/TargetGroup/list">list</a> request.</p> <p>Must contain at least one element.</p> 
grpc.<br>connection | **object**<br>Connection-based session affinity configuration.  For now, a connection is defined only by an IP address of the client. <br>`grpc` includes only one of the fields `connection`, `header`, `cookie`<br><br><p>A resource for connection-based session affinity configuration.</p> 
grpc.<br>connection.<br>sourceIp | **boolean** (boolean)<br><p>Specifies whether an IP address of the client is used to define a connection for session affinity.</p> 
grpc.<br>header | **object**<br>HTTP-header-field-based session affinity configuration. <br>`grpc` includes only one of the fields `connection`, `header`, `cookie`<br><br><p>A resource for HTTP-header-field-based session affinity configuration.</p> 
grpc.<br>header.<br>headerName | **string**<br><p>Name of the HTTP header field that is used for session affinity.</p> <p>The string length in characters must be 1-256.</p> 
grpc.<br>cookie | **object**<br>Cookie-based session affinity configuration. <br>`grpc` includes only one of the fields `connection`, `header`, `cookie`<br><br><p>A resource for cookie-based session affinity configuration.</p> 
grpc.<br>cookie.<br>name | **string**<br><p>Name of the cookie that is used for session affinity.</p> <p>The string length in characters must be 1-256.</p> 
grpc.<br>cookie.<br>ttl | **string**<br><p>Maximum age of cookies that are generated for sessions.</p> <p>If set to ``0``, session cookies are used, which are stored by clients in temporary memory and are deleted on client restarts.</p> <p>If not set, the balancer does not generate cookies and only uses incoming ones for establishing session affinity.</p> 
stream | **object**<br>List of stream (TCP) backends that the backend group consists of. <br> includes only one of the fields `http`, `grpc`, `stream`<br><br><p>A stream (TCP) backend group resource.</p> 
stream.<br>backends[] | **object**<br>New settings for the Stream backend.<br><p>List of stream (TCP) backends.</p> 
stream.<br>backends[].<br>name | **string**<br><p>Name of the backend.</p> <p>Value must match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
stream.<br>backends[].<br>backendWeight | **integer** (int64)<br><p>Backend weight. Traffic is distributed between backends of a backend group according to their weights.</p> <p>Weights must be set either for all backends in a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends.</p> <p>If the weight is non-positive, traffic is not sent to the backend.</p> 
stream.<br>backends[].<br>loadBalancingConfig | **object**<br>Load balancing configuration for the backend.<br><p>A load balancing configuration resource.</p> 
stream.<br>backends[].<br>loadBalancingConfig.<br>panicThreshold | **string** (int64)<br><p>Threshold for panic mode.</p> <p>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see <a href="/docs/application-load-balancer/concepts/backend-group#panic-mode">documentation</a>.</p> <p>If the value is ``0``, panic mode will never be activated and traffic is routed only to healthy backends at all times.</p> <p>Default value: ``0``.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
stream.<br>backends[].<br>loadBalancingConfig.<br>localityAwareRoutingPercent | **string** (int64)<br><p>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see <a href="/docs/application-load-balancer/concepts/backend-group#locality">documentation</a>.</p> <p>If there are no healthy backends in an availability zone, all the traffic is divided between other zones.</p> <p>If ``strictLocality`` is ``true``, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health.</p> <p>Default value: ``0``.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
stream.<br>backends[].<br>loadBalancingConfig.<br>strictLocality | **boolean** (boolean)<br><p>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones.</p> <p>If set to ``true`` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see <a href="/docs/application-load-balancer/concepts/backend-group#locality">documentation</a>.</p> <p>If ``strict_locality`` is ``true``, the value specified in ``localityAwareRoutingPercent`` is ignored.</p> <p>Default value: ``false``.</p> 
stream.<br>backends[].<br>loadBalancingConfig.<br>mode | **string**<br><p>Load balancing mode for the backend.</p> <p>For details about load balancing modes, see <a href="/docs/application-load-balancer/concepts/backend-group#balancing-mode">documentation</a>.</p> <p>A load balancing mode resource. For details about the concept, see <a href="/docs/application-load-balancer/concepts/backend-group#balancing-mode">documentation</a>.</p> <ul> <li> <p>ROUND_ROBIN: Round robin load balancing mode.</p> <p>All endpoints of the backend take their turns to receive requests attributed to the backend.</p> </li> <li> <p>RANDOM: Random load balancing mode. Default value.</p> <p>For a request attributed to the backend, an endpoint that receives it is picked at random.</p> </li> <li> <p>LEAST_REQUEST: Least request load balancing mode.</p> <p>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</p> </li> <li> <p>MAGLEV_HASH: Maglev hashing load balancing mode.</p> <p>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request is also hashed by the same function (if session affinity is enabled for the backend group, the attribute to hash is specified in session affinity configuration). The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request.</p> <p>If the backend group with session affinity enabled contains more than one backend with positive weight, endpoints for backends with ``MAGLEV_HASH`` load balancing mode are picked at ``RANDOM`` instead.</p> </li> </ul> 
stream.<br>backends[].<br>port | **string** (int64)<br><p>Port used by all targets to receive traffic.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
stream.<br>backends[].<br>healthchecks[] | **object**<br><p>Health checks to perform on targets from target groups. For details about health checking, see <a href="/docs/application-load-balancer/concepts/backend-group#health-checks">documentation</a>.</p> <p>If no health checks are specified, active health checking is not performed.</p> 
stream.<br>backends[].<br>healthchecks[].<br>timeout | **string**<br><p>Required. Health check timeout.</p> <p>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed.</p> 
stream.<br>backends[].<br>healthchecks[].<br>interval | **string**<br><p>Required. Base interval between consecutive health checks.</p> 
stream.<br>backends[].<br>healthchecks[].<br>intervalJitterPercent | **number** (double)<br>
stream.<br>backends[].<br>healthchecks[].<br>healthyThreshold | **string** (int64)<br><p>Number of consecutive successful health checks required to mark an unhealthy target as healthy.</p> <p>Both ``0`` and ``1`` values amount to one successful check required.</p> <p>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check.</p> <p>Default value: ``0``.</p> 
stream.<br>backends[].<br>healthchecks[].<br>unhealthyThreshold | **string** (int64)<br><p>Number of consecutive failed health checks required to mark a healthy target as unhealthy.</p> <p>Both ``0`` and ``1`` values amount to one unsuccessful check required.</p> <p>The value is ignored if a health check is failed due to an HTTP ``503 Service Unavailable`` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy.</p> <p>Default value: ``0``.</p> 
stream.<br>backends[].<br>healthchecks[].<br>healthcheckPort | **string** (int64)<br><p>Port used for health checks.</p> <p>If not specified, the backend port (``port`` or ``port``) is used for health checks.</p> <p>Acceptable values are 0 to 65535, inclusive.</p> 
stream.<br>backends[].<br>healthchecks[].<br>stream | **object**<br>TCP stream health check settings. <br>`stream.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br><p>A resource for TCP stream health check settings.</p> 
stream.<br>backends[].<br>healthchecks[].<br>stream.<br>send | **object**<br><p>Message sent to targets during TCP data transfer.</p> <p>If not specified, no data is sent to the target.</p> <p>A health check payload resource.</p> 
stream.<br>backends[].<br>healthchecks[].<br>stream.<br>send.<br>text | **string**<br><p>Payload text.</p> <p>The string length in characters must be greater than 0.</p> 
stream.<br>backends[].<br>healthchecks[].<br>stream.<br>receive | **object**<br><p>Data that must be contained in the messages received from targets for a successful health check.</p> <p>If not specified, no messages are expected from targets, and those that are received are not checked.</p> <p>A health check payload resource.</p> 
stream.<br>backends[].<br>healthchecks[].<br>stream.<br>receive.<br>text | **string**<br><p>Payload text.</p> <p>The string length in characters must be greater than 0.</p> 
stream.<br>backends[].<br>healthchecks[].<br>http | **object**<br>HTTP health check settings. <br>`stream.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br><p>A resource for HTTP health check settings.</p> 
stream.<br>backends[].<br>healthchecks[].<br>http.<br>host | **string**<br><p>Value for the HTTP/1.1 ``Host`` header or the HTTP/2 ``:authority`` pseudo-header used in requests to targets.</p> 
stream.<br>backends[].<br>healthchecks[].<br>http.<br>path | **string**<br><p>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 ``:path`` pseudo-header.</p> 
stream.<br>backends[].<br>healthchecks[].<br>http.<br>useHttp2 | **boolean** (boolean)<br><p>Enables HTTP/2 usage in health checks.</p> <p>Default value: ``false``, HTTP/1.1 is used.</p> 
stream.<br>backends[].<br>healthchecks[].<br>grpc | **object**<br>gRPC health check settings. <br>`stream.backends[].healthchecks[]` includes only one of the fields `stream`, `http`, `grpc`<br><br><p>A resource for gRPC health check settings.</p> 
stream.<br>backends[].<br>healthchecks[].<br>grpc.<br>serviceName | **string**<br><p>Name of the gRPC service to be checked.</p> <p>If not specified, overall health is checked.</p> <p>For details about the concept, see <a href="https://github.com/grpc/grpc/blob/master/doc/health-checking.md">GRPC Health Checking Protocol</a>.</p> 
stream.<br>backends[].<br>healthchecks[].<br>plaintext | **object** <br>`stream.backends[].healthchecks[]` includes only one of the fields `plaintext`, `tls`<br><br><p>Transport settings to be used instead of the settings configured per-cluster</p> 
stream.<br>backends[].<br>healthchecks[].<br>tls | **object** <br>`stream.backends[].healthchecks[]` includes only one of the fields `plaintext`, `tls`<br><br><p>Transport settings to be used instead of the settings configured per-cluster</p> 
stream.<br>backends[].<br>healthchecks[].<br>tls.<br>sni | **string**<br><p>SNI string for TLS connections.</p> 
stream.<br>backends[].<br>healthchecks[].<br>tls.<br>validationContext | **object**<br><p>Validation context for backend TLS connections.</p> <p>A TLS validation context resource.</p> 
stream.<br>backends[].<br>healthchecks[].<br>tls.<br>validationContext.<br>trustedCaId | **string** <br>`stream.backends[].healthchecks[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br>
stream.<br>backends[].<br>healthchecks[].<br>tls.<br>validationContext.<br>trustedCaBytes | **string** <br>`stream.backends[].healthchecks[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br><p>X.509 certificate contents in PEM format.</p> 
stream.<br>backends[].<br>tls | **object**<br>Settings for TLS connections between load balancer nodes and backend targets.  If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in `validationContext`. If not specified, the load balancer establishes unencrypted HTTP connections with targets.<br><p>A resource for backend TLS settings.</p> 
stream.<br>backends[].<br>tls.<br>sni | **string**<br><p>Server Name Indication (SNI) string for TLS connections.</p> 
stream.<br>backends[].<br>tls.<br>validationContext | **object**<br><p>Validation context for TLS connections.</p> <p>A TLS validation context resource.</p> 
stream.<br>backends[].<br>tls.<br>validationContext.<br>trustedCaId | **string** <br>`stream.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br>
stream.<br>backends[].<br>tls.<br>validationContext.<br>trustedCaBytes | **string** <br>`stream.backends[].tls.validationContext` includes only one of the fields `trustedCaId`, `trustedCaBytes`<br><br><p>X.509 certificate contents in PEM format.</p> 
stream.<br>backends[].<br>enableProxyProtocol | **boolean** (boolean)<br><p>If set, proxy protocol will be enabled for this backend.</p> 
stream.<br>backends[].<br>targetGroups | **object**<br>Target groups that belong to the backend.<br><p>A resource for target groups that belong to the backend.</p> 
stream.<br>backends[].<br>targetGroups.<br>targetGroupIds[] | **string**<br><p>Required. List of ID's of target groups that belong to the backend.</p> <p>To get the ID's of all available target groups, make a <a href="/docs/application-load-balancer/api-ref/TargetGroup/list">list</a> request.</p> <p>Must contain at least one element.</p> 
stream.<br>connection | **object**<br>Connection-based session affinity configuration.  For now, a connection is defined only by an IP address of the client.<br><p>A resource for connection-based session affinity configuration.</p> 
stream.<br>connection.<br>sourceIp | **boolean** (boolean)<br><p>Specifies whether an IP address of the client is used to define a connection for session affinity.</p> 
 
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
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 
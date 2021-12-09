---
editable: false
sourcePath: en/_api-ref-grpc/application-load-balancer/api-ref/grpc/backend_group_service.md
---


# BackendGroupService

A set of methods for managing backend groups.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified backend group. |
| [List](#List) | Lists backend groups in the specified folder. |
| [Create](#Create) | Creates a backend group in the specified folder. |
| [Update](#Update) | Updates the specified backend group. |
| [Delete](#Delete) | Deletes the specified backend group. |
| [AddBackend](#AddBackend) | Adds backends to the specified backend group. |
| [RemoveBackend](#RemoveBackend) | Removes backends from the specified backend group. |
| [UpdateBackend](#UpdateBackend) | Updates the specified backend. |
| [ListOperations](#ListOperations) | Lists operations for the specified backend group. |

## Calls BackendGroupService {#calls}

## Get {#Get}

Returns the specified backend group. <br>To get the list of all available backend groups, make a [List](#List) request.

**rpc Get ([GetBackendGroupRequest](#GetBackendGroupRequest)) returns ([BackendGroup](#BackendGroup))**

### GetBackendGroupRequest {#GetBackendGroupRequest}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. ID of the backend group to return. <br>To get the backend group ID, make a [BackendGroupService.List](#List) request. 


### BackendGroup {#BackendGroup}

Field | Description
--- | ---
id | **string**<br>ID of the backend group. Generated at creation time. 
name | **string**<br>Name of the backend group. The name is unique within the folder. The string length in characters is 3-63. 
description | **string**<br>Description of the backend group. The string is 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the backend group belongs to. 
labels | **map<string,string>**<br>Backend group labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). The maximum number of labels is 64. 
backend | **oneof:** `http`, `grpc` or `stream`<br>Backends that the backend group consists of. <br>A backend group must consist of either HTTP backends or gRPC backends.
&nbsp;&nbsp;http | **[HttpBackendGroup](#HttpBackendGroup)**<br>List of HTTP backends that the backend group consists of. 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](#GrpcBackendGroup)**<br>List of gRPC backends that the backend group consists of. 
&nbsp;&nbsp;stream | **[StreamBackendGroup](#StreamBackendGroup)**<br>List of stream backends that the backend group consist of. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


### HttpBackendGroup {#HttpBackendGroup}

Field | Description
--- | ---
backends[] | **[HttpBackend](#HttpBackend)**<br>List of HTTP backends. 
session_affinity | **oneof:** `connection`, `header` or `cookie`<br>Session affinity configuration for the backend group. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity). <br>If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive [HttpBackend.backend_weight](#HttpBackend)), its [HttpBackend.backend_type](#HttpBackend) should be [TargetGroupsBackend](#TargetGroupsBackend), and its [LoadBalancingConfig.load_balancing_mode](#LoadBalancingConfig) should be `MAGLEV_HASH`. If any of these conditions are not met, session affinity will not work.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity)**<br>Connection-based session affinity configuration. <br>For now, a connection is defined only by an IP address of the client. 
&nbsp;&nbsp;header | **[HeaderSessionAffinity](#HeaderSessionAffinity)**<br>HTTP-header-field-based session affinity configuration. 
&nbsp;&nbsp;cookie | **[CookieSessionAffinity](#CookieSessionAffinity)**<br>Cookie-based session affinity configuration. 


### HttpBackend {#HttpBackend}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends in a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups` or `storage_bucket`<br>Reference to targets that belong to the backend. <br>A backend may be a set of target groups or an Object Storage bucket. For details about backend types, see [documentation](/docs/application-load-balancer/concepts/backend-group#types).
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend)**<br>Target groups that belong to the backend. For details about target groups, see [documentation](/docs/application-load-balancer/concepts/target-group). 
&nbsp;&nbsp;storage_bucket | **[StorageBucketBackend](#StorageBucketBackend)**<br>Object Storage bucket to use as the backend. For details about buckets, see [documentation](/docs/storage/concepts/bucket). <br>If a bucket is used as a backend, the list of bucket objects and the objects themselves must be publicly accessible. For instructions, see [documentation](/docs/storage/operations/buckets/bucket-availability). 
healthchecks[] | **[HealthCheck](#HealthCheck)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 
use_http2 | **bool**<br>Enables HTTP/2 usage in connections between load balancer nodes and backend targets. <br>Default value: `false`, HTTP/1.1 is used. 


### LoadBalancingConfig {#LoadBalancingConfig}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### StorageBucketBackend {#StorageBucketBackend}

Field | Description
--- | ---
bucket | **string**<br>Required. Name of the bucket. 


### HealthCheck {#HealthCheck}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend1) or [GrpcBackend.port](#GrpcBackend)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


### HeaderSessionAffinity {#HeaderSessionAffinity}

Field | Description
--- | ---
header_name | **string**<br>Name of the HTTP header field that is used for session affinity. The string length in characters must be 1-256.


### CookieSessionAffinity {#CookieSessionAffinity}

Field | Description
--- | ---
name | **string**<br>Name of the cookie that is used for session affinity. The string length in characters must be 1-256.
ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum age of cookies that are generated for sessions (persistent cookies). <br>If not set, session cookies are used, which are stored by clients in temporary memory and are deleted on client restarts. 


### GrpcBackendGroup {#GrpcBackendGroup}

Field | Description
--- | ---
backends[] | **[GrpcBackend](#GrpcBackend)**<br>List of gRPC backends. 
session_affinity | **oneof:** `connection`, `header` or `cookie`<br>Session affinity configuration for the backend group. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity). <br>If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive [GrpcBackend.backend_weight](#GrpcBackend)), and its [LoadBalancingConfig.load_balancing_mode](#LoadBalancingConfig1) should be `MAGLEV_HASH`. If any of these conditions are not met, session affinity will not work.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity1)**<br>Connection-based session affinity configuration. <br>For now, a connection is defined only by an IP address of the client. 
&nbsp;&nbsp;header | **[HeaderSessionAffinity](#HeaderSessionAffinity1)**<br>HTTP-header-field-based session affinity configuration. 
&nbsp;&nbsp;cookie | **[CookieSessionAffinity](#CookieSessionAffinity1)**<br>Cookie-based session affinity configuration. 


### GrpcBackend {#GrpcBackend}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends of a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig1)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>Reference to targets that belong to the backend. For now, targets are referenced via target groups.
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend1)**<br>Target groups that belong to the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck1)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls1)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls1). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 


### LoadBalancingConfig {#LoadBalancingConfig1}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend1}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### HealthCheck {#HealthCheck1}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend1) or [GrpcBackend.port](#GrpcBackend1)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck1)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck1)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck1)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck1}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck1}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck1}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls1}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext1)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext1}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity1}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


### HeaderSessionAffinity {#HeaderSessionAffinity1}

Field | Description
--- | ---
header_name | **string**<br>Name of the HTTP header field that is used for session affinity. The string length in characters must be 1-256.


### CookieSessionAffinity {#CookieSessionAffinity1}

Field | Description
--- | ---
name | **string**<br>Name of the cookie that is used for session affinity. The string length in characters must be 1-256.
ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum age of cookies that are generated for sessions (persistent cookies). <br>If not set, session cookies are used, which are stored by clients in temporary memory and are deleted on client restarts. 


### StreamBackendGroup {#StreamBackendGroup}

Field | Description
--- | ---
backends[] | **[StreamBackend](#StreamBackend)**<br> 
session_affinity | **oneof:** `connection`<br>session_affinity is applicable when load_balancing_mode of the selected backend is MAGLEV_HASH.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity2)**<br>session_affinity is applicable when load_balancing_mode of the selected backend is MAGLEV_HASH. 


### StreamBackend {#StreamBackend}

Field | Description
--- | ---
name | **string**<br> Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If not set, backend will be disabled. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig2)**<br> 
port | **int64**<br>Optional alternative port for all targets. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend2)**<br> 
healthchecks[] | **[HealthCheck](#HealthCheck2)**<br> 
tls | **[BackendTls](#BackendTls2)**<br> 


### LoadBalancingConfig {#LoadBalancingConfig2}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend2}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### HealthCheck {#HealthCheck2}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend1) or [GrpcBackend.port](#GrpcBackend1)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck2)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck2)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck2)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck2}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck2}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck2}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls2}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext2)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext2}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity2}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


## List {#List}

Lists backend groups in the specified folder.

**rpc List ([ListBackendGroupsRequest](#ListBackendGroupsRequest)) returns ([ListBackendGroupsResponse](#ListBackendGroupsResponse))**

### ListBackendGroupsRequest {#ListBackendGroupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list backend groups in. <br>To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListBackendGroupsResponse.next_page_token](#ListBackendGroupsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListBackendGroupsResponse.next_page_token](#ListBackendGroupsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br><ol><li>The field name. Currently you can use filtering only on [BackendGroup.name](#BackendGroup1) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol> The maximum string length in characters is 1000.


### ListBackendGroupsResponse {#ListBackendGroupsResponse}

Field | Description
--- | ---
backend_groups[] | **[BackendGroup](#BackendGroup1)**<br>List of backend groups in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListBackendGroupsRequest.page_size](#ListBackendGroupsRequest), use `next_page_token` as the value for the [ListBackendGroupsRequest.page_token](#ListBackendGroupsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### BackendGroup {#BackendGroup1}

Field | Description
--- | ---
id | **string**<br>ID of the backend group. Generated at creation time. 
name | **string**<br>Name of the backend group. The name is unique within the folder. The string length in characters is 3-63. 
description | **string**<br>Description of the backend group. The string is 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the backend group belongs to. 
labels | **map<string,string>**<br>Backend group labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). The maximum number of labels is 64. 
backend | **oneof:** `http`, `grpc` or `stream`<br>Backends that the backend group consists of. <br>A backend group must consist of either HTTP backends or gRPC backends.
&nbsp;&nbsp;http | **[HttpBackendGroup](#HttpBackendGroup1)**<br>List of HTTP backends that the backend group consists of. 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](#GrpcBackendGroup1)**<br>List of gRPC backends that the backend group consists of. 
&nbsp;&nbsp;stream | **[StreamBackendGroup](#StreamBackendGroup1)**<br>List of stream backends that the backend group consist of. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


### HttpBackendGroup {#HttpBackendGroup1}

Field | Description
--- | ---
backends[] | **[HttpBackend](#HttpBackend1)**<br>List of HTTP backends. 
session_affinity | **oneof:** `connection`, `header` or `cookie`<br>Session affinity configuration for the backend group. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity). <br>If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive [HttpBackend.backend_weight](#HttpBackend1)), its [HttpBackend.backend_type](#HttpBackend1) should be [TargetGroupsBackend](#TargetGroupsBackend3), and its [LoadBalancingConfig.load_balancing_mode](#LoadBalancingConfig3) should be `MAGLEV_HASH`. If any of these conditions are not met, session affinity will not work.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity3)**<br>Connection-based session affinity configuration. <br>For now, a connection is defined only by an IP address of the client. 
&nbsp;&nbsp;header | **[HeaderSessionAffinity](#HeaderSessionAffinity2)**<br>HTTP-header-field-based session affinity configuration. 
&nbsp;&nbsp;cookie | **[CookieSessionAffinity](#CookieSessionAffinity2)**<br>Cookie-based session affinity configuration. 


### HttpBackend {#HttpBackend1}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends in a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig3)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups` or `storage_bucket`<br>Reference to targets that belong to the backend. <br>A backend may be a set of target groups or an Object Storage bucket. For details about backend types, see [documentation](/docs/application-load-balancer/concepts/backend-group#types).
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend3)**<br>Target groups that belong to the backend. For details about target groups, see [documentation](/docs/application-load-balancer/concepts/target-group). 
&nbsp;&nbsp;storage_bucket | **[StorageBucketBackend](#StorageBucketBackend1)**<br>Object Storage bucket to use as the backend. For details about buckets, see [documentation](/docs/storage/concepts/bucket). <br>If a bucket is used as a backend, the list of bucket objects and the objects themselves must be publicly accessible. For instructions, see [documentation](/docs/storage/operations/buckets/bucket-availability). 
healthchecks[] | **[HealthCheck](#HealthCheck3)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls3)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls3). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 
use_http2 | **bool**<br>Enables HTTP/2 usage in connections between load balancer nodes and backend targets. <br>Default value: `false`, HTTP/1.1 is used. 


### LoadBalancingConfig {#LoadBalancingConfig3}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend3}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### StorageBucketBackend {#StorageBucketBackend1}

Field | Description
--- | ---
bucket | **string**<br>Required. Name of the bucket. 


### HealthCheck {#HealthCheck3}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend2) or [GrpcBackend.port](#GrpcBackend1)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck3)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck3)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck3)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck3}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck3}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck3}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls3}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext3)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext3}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity3}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


### HeaderSessionAffinity {#HeaderSessionAffinity2}

Field | Description
--- | ---
header_name | **string**<br>Name of the HTTP header field that is used for session affinity. The string length in characters must be 1-256.


### CookieSessionAffinity {#CookieSessionAffinity2}

Field | Description
--- | ---
name | **string**<br>Name of the cookie that is used for session affinity. The string length in characters must be 1-256.
ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum age of cookies that are generated for sessions (persistent cookies). <br>If not set, session cookies are used, which are stored by clients in temporary memory and are deleted on client restarts. 


### GrpcBackendGroup {#GrpcBackendGroup1}

Field | Description
--- | ---
backends[] | **[GrpcBackend](#GrpcBackend1)**<br>List of gRPC backends. 
session_affinity | **oneof:** `connection`, `header` or `cookie`<br>Session affinity configuration for the backend group. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity). <br>If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive [GrpcBackend.backend_weight](#GrpcBackend1)), and its [LoadBalancingConfig.load_balancing_mode](#LoadBalancingConfig4) should be `MAGLEV_HASH`. If any of these conditions are not met, session affinity will not work.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity4)**<br>Connection-based session affinity configuration. <br>For now, a connection is defined only by an IP address of the client. 
&nbsp;&nbsp;header | **[HeaderSessionAffinity](#HeaderSessionAffinity3)**<br>HTTP-header-field-based session affinity configuration. 
&nbsp;&nbsp;cookie | **[CookieSessionAffinity](#CookieSessionAffinity3)**<br>Cookie-based session affinity configuration. 


### GrpcBackend {#GrpcBackend1}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends of a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig4)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>Reference to targets that belong to the backend. For now, targets are referenced via target groups.
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend4)**<br>Target groups that belong to the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck4)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls4)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls4). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 


### LoadBalancingConfig {#LoadBalancingConfig4}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend4}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### HealthCheck {#HealthCheck4}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend2) or [GrpcBackend.port](#GrpcBackend2)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck4)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck4)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck4)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck4}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck4}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck4}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls4}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext4)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext4}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity4}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


### HeaderSessionAffinity {#HeaderSessionAffinity3}

Field | Description
--- | ---
header_name | **string**<br>Name of the HTTP header field that is used for session affinity. The string length in characters must be 1-256.


### CookieSessionAffinity {#CookieSessionAffinity3}

Field | Description
--- | ---
name | **string**<br>Name of the cookie that is used for session affinity. The string length in characters must be 1-256.
ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum age of cookies that are generated for sessions (persistent cookies). <br>If not set, session cookies are used, which are stored by clients in temporary memory and are deleted on client restarts. 


### StreamBackendGroup {#StreamBackendGroup1}

Field | Description
--- | ---
backends[] | **[StreamBackend](#StreamBackend1)**<br> 
session_affinity | **oneof:** `connection`<br>session_affinity is applicable when load_balancing_mode of the selected backend is MAGLEV_HASH.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity5)**<br>session_affinity is applicable when load_balancing_mode of the selected backend is MAGLEV_HASH. 


### StreamBackend {#StreamBackend1}

Field | Description
--- | ---
name | **string**<br> Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If not set, backend will be disabled. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig5)**<br> 
port | **int64**<br>Optional alternative port for all targets. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend5)**<br> 
healthchecks[] | **[HealthCheck](#HealthCheck5)**<br> 
tls | **[BackendTls](#BackendTls5)**<br> 


### LoadBalancingConfig {#LoadBalancingConfig5}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend5}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### HealthCheck {#HealthCheck5}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend2) or [GrpcBackend.port](#GrpcBackend2)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck5)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck5)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck5)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck5}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck5}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck5}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls5}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext5)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext5}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity5}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


## Create {#Create}

Creates a backend group in the specified folder.

**rpc Create ([CreateBackendGroupRequest](#CreateBackendGroupRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateBackendGroupMetadata](#CreateBackendGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[BackendGroup](#BackendGroup2)<br>

### CreateBackendGroupRequest {#CreateBackendGroupRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a backend group in. <br>To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
name | **string**<br>Name of the backend group. The name must be unique within the folder. Value must match the regular expression ` ([a-z]([-a-z0-9]{0,61}[a-z0-9])?)? `.
description | **string**<br>Description of the backend group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Backend group labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
backend | **oneof:** `http` or `grpc`<br>Backends that the backend group will consist of. <br>A backend group must consist of either HTTP backends or gRPC backends.
&nbsp;&nbsp;http | **[HttpBackendGroup](#HttpBackendGroup2)**<br>List of HTTP backends that the backend group will consist of. 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](#GrpcBackendGroup2)**<br>List of gRPC backends that the backend group consists of. 


### HttpBackendGroup {#HttpBackendGroup2}

Field | Description
--- | ---
backends[] | **[HttpBackend](#HttpBackend2)**<br>List of HTTP backends. 
session_affinity | **oneof:** `connection`, `header` or `cookie`<br>Session affinity configuration for the backend group. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity). <br>If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive [HttpBackend.backend_weight](#HttpBackend2)), its [HttpBackend.backend_type](#HttpBackend2) should be [TargetGroupsBackend](#TargetGroupsBackend6), and its [LoadBalancingConfig.load_balancing_mode](#LoadBalancingConfig6) should be `MAGLEV_HASH`. If any of these conditions are not met, session affinity will not work.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity6)**<br>Connection-based session affinity configuration. <br>For now, a connection is defined only by an IP address of the client. 
&nbsp;&nbsp;header | **[HeaderSessionAffinity](#HeaderSessionAffinity4)**<br>HTTP-header-field-based session affinity configuration. 
&nbsp;&nbsp;cookie | **[CookieSessionAffinity](#CookieSessionAffinity4)**<br>Cookie-based session affinity configuration. 


### HttpBackend {#HttpBackend2}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends in a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig6)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups` or `storage_bucket`<br>Reference to targets that belong to the backend. <br>A backend may be a set of target groups or an Object Storage bucket. For details about backend types, see [documentation](/docs/application-load-balancer/concepts/backend-group#types).
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend6)**<br>Target groups that belong to the backend. For details about target groups, see [documentation](/docs/application-load-balancer/concepts/target-group). 
&nbsp;&nbsp;storage_bucket | **[StorageBucketBackend](#StorageBucketBackend2)**<br>Object Storage bucket to use as the backend. For details about buckets, see [documentation](/docs/storage/concepts/bucket). <br>If a bucket is used as a backend, the list of bucket objects and the objects themselves must be publicly accessible. For instructions, see [documentation](/docs/storage/operations/buckets/bucket-availability). 
healthchecks[] | **[HealthCheck](#HealthCheck6)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls6)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls6). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 
use_http2 | **bool**<br>Enables HTTP/2 usage in connections between load balancer nodes and backend targets. <br>Default value: `false`, HTTP/1.1 is used. 


### LoadBalancingConfig {#LoadBalancingConfig6}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend6}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### StorageBucketBackend {#StorageBucketBackend2}

Field | Description
--- | ---
bucket | **string**<br>Required. Name of the bucket. 


### HealthCheck {#HealthCheck6}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend3) or [GrpcBackend.port](#GrpcBackend2)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck6)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck6)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck6)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck6}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck6}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck6}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls6}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext6)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext6}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity6}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


### HeaderSessionAffinity {#HeaderSessionAffinity4}

Field | Description
--- | ---
header_name | **string**<br>Name of the HTTP header field that is used for session affinity. The string length in characters must be 1-256.


### CookieSessionAffinity {#CookieSessionAffinity4}

Field | Description
--- | ---
name | **string**<br>Name of the cookie that is used for session affinity. The string length in characters must be 1-256.
ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum age of cookies that are generated for sessions (persistent cookies). <br>If not set, session cookies are used, which are stored by clients in temporary memory and are deleted on client restarts. 


### GrpcBackendGroup {#GrpcBackendGroup2}

Field | Description
--- | ---
backends[] | **[GrpcBackend](#GrpcBackend2)**<br>List of gRPC backends. 
session_affinity | **oneof:** `connection`, `header` or `cookie`<br>Session affinity configuration for the backend group. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity). <br>If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive [GrpcBackend.backend_weight](#GrpcBackend2)), and its [LoadBalancingConfig.load_balancing_mode](#LoadBalancingConfig7) should be `MAGLEV_HASH`. If any of these conditions are not met, session affinity will not work.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity7)**<br>Connection-based session affinity configuration. <br>For now, a connection is defined only by an IP address of the client. 
&nbsp;&nbsp;header | **[HeaderSessionAffinity](#HeaderSessionAffinity5)**<br>HTTP-header-field-based session affinity configuration. 
&nbsp;&nbsp;cookie | **[CookieSessionAffinity](#CookieSessionAffinity5)**<br>Cookie-based session affinity configuration. 


### GrpcBackend {#GrpcBackend2}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends of a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig7)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>Reference to targets that belong to the backend. For now, targets are referenced via target groups.
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend7)**<br>Target groups that belong to the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck7)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls7)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls7). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 


### LoadBalancingConfig {#LoadBalancingConfig7}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend7}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### HealthCheck {#HealthCheck7}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend3) or [GrpcBackend.port](#GrpcBackend3)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck7)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck7)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck7)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck7}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck7}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck7}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls7}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext7)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext7}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity7}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


### HeaderSessionAffinity {#HeaderSessionAffinity5}

Field | Description
--- | ---
header_name | **string**<br>Name of the HTTP header field that is used for session affinity. The string length in characters must be 1-256.


### CookieSessionAffinity {#CookieSessionAffinity5}

Field | Description
--- | ---
name | **string**<br>Name of the cookie that is used for session affinity. The string length in characters must be 1-256.
ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum age of cookies that are generated for sessions (persistent cookies). <br>If not set, session cookies are used, which are stored by clients in temporary memory and are deleted on client restarts. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateBackendGroupMetadata](#CreateBackendGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[BackendGroup](#BackendGroup2)>**<br>if operation finished successfully. 


### CreateBackendGroupMetadata {#CreateBackendGroupMetadata}

Field | Description
--- | ---
backend_group_id | **string**<br>ID of the backend group that is being created. 


### BackendGroup {#BackendGroup2}

Field | Description
--- | ---
id | **string**<br>ID of the backend group. Generated at creation time. 
name | **string**<br>Name of the backend group. The name is unique within the folder. The string length in characters is 3-63. 
description | **string**<br>Description of the backend group. The string is 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the backend group belongs to. 
labels | **map<string,string>**<br>Backend group labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). The maximum number of labels is 64. 
backend | **oneof:** `http`, `grpc` or `stream`<br>Backends that the backend group consists of. <br>A backend group must consist of either HTTP backends or gRPC backends.
&nbsp;&nbsp;http | **[HttpBackendGroup](#HttpBackendGroup3)**<br>List of HTTP backends that the backend group consists of. 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](#GrpcBackendGroup3)**<br>List of gRPC backends that the backend group consists of. 
&nbsp;&nbsp;stream | **[StreamBackendGroup](#StreamBackendGroup2)**<br>List of stream backends that the backend group consist of. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


### HttpBackendGroup {#HttpBackendGroup3}

Field | Description
--- | ---
backends[] | **[HttpBackend](#HttpBackend3)**<br>List of HTTP backends. 
session_affinity | **oneof:** `connection`, `header` or `cookie`<br>Session affinity configuration for the backend group. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity). <br>If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive [HttpBackend.backend_weight](#HttpBackend3)), its [HttpBackend.backend_type](#HttpBackend3) should be [TargetGroupsBackend](#TargetGroupsBackend8), and its [LoadBalancingConfig.load_balancing_mode](#LoadBalancingConfig8) should be `MAGLEV_HASH`. If any of these conditions are not met, session affinity will not work.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity8)**<br>Connection-based session affinity configuration. <br>For now, a connection is defined only by an IP address of the client. 
&nbsp;&nbsp;header | **[HeaderSessionAffinity](#HeaderSessionAffinity6)**<br>HTTP-header-field-based session affinity configuration. 
&nbsp;&nbsp;cookie | **[CookieSessionAffinity](#CookieSessionAffinity6)**<br>Cookie-based session affinity configuration. 


### HttpBackend {#HttpBackend3}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends in a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig8)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups` or `storage_bucket`<br>Reference to targets that belong to the backend. <br>A backend may be a set of target groups or an Object Storage bucket. For details about backend types, see [documentation](/docs/application-load-balancer/concepts/backend-group#types).
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend8)**<br>Target groups that belong to the backend. For details about target groups, see [documentation](/docs/application-load-balancer/concepts/target-group). 
&nbsp;&nbsp;storage_bucket | **[StorageBucketBackend](#StorageBucketBackend3)**<br>Object Storage bucket to use as the backend. For details about buckets, see [documentation](/docs/storage/concepts/bucket). <br>If a bucket is used as a backend, the list of bucket objects and the objects themselves must be publicly accessible. For instructions, see [documentation](/docs/storage/operations/buckets/bucket-availability). 
healthchecks[] | **[HealthCheck](#HealthCheck8)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls8)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls8). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 
use_http2 | **bool**<br>Enables HTTP/2 usage in connections between load balancer nodes and backend targets. <br>Default value: `false`, HTTP/1.1 is used. 


### LoadBalancingConfig {#LoadBalancingConfig8}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend8}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### StorageBucketBackend {#StorageBucketBackend3}

Field | Description
--- | ---
bucket | **string**<br>Required. Name of the bucket. 


### HealthCheck {#HealthCheck8}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend4) or [GrpcBackend.port](#GrpcBackend3)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck8)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck8)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck8)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck8}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck8}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck8}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls8}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext8)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext8}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity8}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


### HeaderSessionAffinity {#HeaderSessionAffinity6}

Field | Description
--- | ---
header_name | **string**<br>Name of the HTTP header field that is used for session affinity. The string length in characters must be 1-256.


### CookieSessionAffinity {#CookieSessionAffinity6}

Field | Description
--- | ---
name | **string**<br>Name of the cookie that is used for session affinity. The string length in characters must be 1-256.
ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum age of cookies that are generated for sessions (persistent cookies). <br>If not set, session cookies are used, which are stored by clients in temporary memory and are deleted on client restarts. 


### GrpcBackendGroup {#GrpcBackendGroup3}

Field | Description
--- | ---
backends[] | **[GrpcBackend](#GrpcBackend3)**<br>List of gRPC backends. 
session_affinity | **oneof:** `connection`, `header` or `cookie`<br>Session affinity configuration for the backend group. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity). <br>If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive [GrpcBackend.backend_weight](#GrpcBackend3)), and its [LoadBalancingConfig.load_balancing_mode](#LoadBalancingConfig9) should be `MAGLEV_HASH`. If any of these conditions are not met, session affinity will not work.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity9)**<br>Connection-based session affinity configuration. <br>For now, a connection is defined only by an IP address of the client. 
&nbsp;&nbsp;header | **[HeaderSessionAffinity](#HeaderSessionAffinity7)**<br>HTTP-header-field-based session affinity configuration. 
&nbsp;&nbsp;cookie | **[CookieSessionAffinity](#CookieSessionAffinity7)**<br>Cookie-based session affinity configuration. 


### GrpcBackend {#GrpcBackend3}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends of a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig9)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>Reference to targets that belong to the backend. For now, targets are referenced via target groups.
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend9)**<br>Target groups that belong to the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck9)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls9)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls9). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 


### LoadBalancingConfig {#LoadBalancingConfig9}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend9}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### HealthCheck {#HealthCheck9}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend4) or [GrpcBackend.port](#GrpcBackend4)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck9)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck9)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck9)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck9}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck9}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck9}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls9}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext9)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext9}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity9}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


### HeaderSessionAffinity {#HeaderSessionAffinity7}

Field | Description
--- | ---
header_name | **string**<br>Name of the HTTP header field that is used for session affinity. The string length in characters must be 1-256.


### CookieSessionAffinity {#CookieSessionAffinity7}

Field | Description
--- | ---
name | **string**<br>Name of the cookie that is used for session affinity. The string length in characters must be 1-256.
ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum age of cookies that are generated for sessions (persistent cookies). <br>If not set, session cookies are used, which are stored by clients in temporary memory and are deleted on client restarts. 


### StreamBackendGroup {#StreamBackendGroup2}

Field | Description
--- | ---
backends[] | **[StreamBackend](#StreamBackend2)**<br> 
session_affinity | **oneof:** `connection`<br>session_affinity is applicable when load_balancing_mode of the selected backend is MAGLEV_HASH.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity10)**<br>session_affinity is applicable when load_balancing_mode of the selected backend is MAGLEV_HASH. 


### StreamBackend {#StreamBackend2}

Field | Description
--- | ---
name | **string**<br> Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If not set, backend will be disabled. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig10)**<br> 
port | **int64**<br>Optional alternative port for all targets. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend10)**<br> 
healthchecks[] | **[HealthCheck](#HealthCheck10)**<br> 
tls | **[BackendTls](#BackendTls10)**<br> 


### LoadBalancingConfig {#LoadBalancingConfig10}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend10}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### HealthCheck {#HealthCheck10}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend4) or [GrpcBackend.port](#GrpcBackend4)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck10)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck10)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck10)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck10}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck10}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck10}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls10}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext10)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext10}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity10}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


## Update {#Update}

Updates the specified backend group.

**rpc Update ([UpdateBackendGroupRequest](#UpdateBackendGroupRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateBackendGroupMetadata](#UpdateBackendGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[BackendGroup](#BackendGroup3)<br>

### UpdateBackendGroupRequest {#UpdateBackendGroupRequest}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. ID of the backend group to update. <br>To get the backend group ID, make a [BackendGroupService.List](#List) request. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the backend group should be updated. 
name | **string**<br>New name for the backend group. The name must be unique within the folder. Value must match the regular expression ` ([a-z]([-a-z0-9]{0,61}[a-z0-9])?)? `.
description | **string**<br>New description of the backend group. The maximum string length in characters is 256.
labels | **map<string,string>**<br><ol><li>Get the current set of labels with a [BackendGroupService.Get](#Get) request. </li><li>Add or remove a label in this set. </li><li>Send the new set in this field.</li></ol> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
backend | **oneof:** `http` or `grpc`<br>New list of backends in the backend group. <br>A backend group must consist of either HTTP backends or gRPC backends. <br>Existing list of backends is completely replaced by the specified list, so if you just want to add or remove a target, make a [BackendGroupService.AddBackend](#AddBackend) request or a [BackendGroupService.RemoveBackend](#RemoveBackend) request.
&nbsp;&nbsp;http | **[HttpBackendGroup](#HttpBackendGroup4)**<br>New list of HTTP backends that the backend group will consist of. 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](#GrpcBackendGroup4)**<br>New list of gRPC backends that the backend group will consist of. 


### HttpBackendGroup {#HttpBackendGroup4}

Field | Description
--- | ---
backends[] | **[HttpBackend](#HttpBackend4)**<br>List of HTTP backends. 
session_affinity | **oneof:** `connection`, `header` or `cookie`<br>Session affinity configuration for the backend group. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity). <br>If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive [HttpBackend.backend_weight](#HttpBackend4)), its [HttpBackend.backend_type](#HttpBackend4) should be [TargetGroupsBackend](#TargetGroupsBackend11), and its [LoadBalancingConfig.load_balancing_mode](#LoadBalancingConfig11) should be `MAGLEV_HASH`. If any of these conditions are not met, session affinity will not work.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity11)**<br>Connection-based session affinity configuration. <br>For now, a connection is defined only by an IP address of the client. 
&nbsp;&nbsp;header | **[HeaderSessionAffinity](#HeaderSessionAffinity8)**<br>HTTP-header-field-based session affinity configuration. 
&nbsp;&nbsp;cookie | **[CookieSessionAffinity](#CookieSessionAffinity8)**<br>Cookie-based session affinity configuration. 


### HttpBackend {#HttpBackend4}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends in a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig11)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups` or `storage_bucket`<br>Reference to targets that belong to the backend. <br>A backend may be a set of target groups or an Object Storage bucket. For details about backend types, see [documentation](/docs/application-load-balancer/concepts/backend-group#types).
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend11)**<br>Target groups that belong to the backend. For details about target groups, see [documentation](/docs/application-load-balancer/concepts/target-group). 
&nbsp;&nbsp;storage_bucket | **[StorageBucketBackend](#StorageBucketBackend4)**<br>Object Storage bucket to use as the backend. For details about buckets, see [documentation](/docs/storage/concepts/bucket). <br>If a bucket is used as a backend, the list of bucket objects and the objects themselves must be publicly accessible. For instructions, see [documentation](/docs/storage/operations/buckets/bucket-availability). 
healthchecks[] | **[HealthCheck](#HealthCheck11)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls11)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls11). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 
use_http2 | **bool**<br>Enables HTTP/2 usage in connections between load balancer nodes and backend targets. <br>Default value: `false`, HTTP/1.1 is used. 


### LoadBalancingConfig {#LoadBalancingConfig11}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend11}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### StorageBucketBackend {#StorageBucketBackend4}

Field | Description
--- | ---
bucket | **string**<br>Required. Name of the bucket. 


### HealthCheck {#HealthCheck11}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend5) or [GrpcBackend.port](#GrpcBackend4)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck11)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck11)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck11)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck11}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck11}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck11}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls11}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext11)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext11}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity11}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


### HeaderSessionAffinity {#HeaderSessionAffinity8}

Field | Description
--- | ---
header_name | **string**<br>Name of the HTTP header field that is used for session affinity. The string length in characters must be 1-256.


### CookieSessionAffinity {#CookieSessionAffinity8}

Field | Description
--- | ---
name | **string**<br>Name of the cookie that is used for session affinity. The string length in characters must be 1-256.
ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum age of cookies that are generated for sessions (persistent cookies). <br>If not set, session cookies are used, which are stored by clients in temporary memory and are deleted on client restarts. 


### GrpcBackendGroup {#GrpcBackendGroup4}

Field | Description
--- | ---
backends[] | **[GrpcBackend](#GrpcBackend4)**<br>List of gRPC backends. 
session_affinity | **oneof:** `connection`, `header` or `cookie`<br>Session affinity configuration for the backend group. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity). <br>If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive [GrpcBackend.backend_weight](#GrpcBackend4)), and its [LoadBalancingConfig.load_balancing_mode](#LoadBalancingConfig12) should be `MAGLEV_HASH`. If any of these conditions are not met, session affinity will not work.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity12)**<br>Connection-based session affinity configuration. <br>For now, a connection is defined only by an IP address of the client. 
&nbsp;&nbsp;header | **[HeaderSessionAffinity](#HeaderSessionAffinity9)**<br>HTTP-header-field-based session affinity configuration. 
&nbsp;&nbsp;cookie | **[CookieSessionAffinity](#CookieSessionAffinity9)**<br>Cookie-based session affinity configuration. 


### GrpcBackend {#GrpcBackend4}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends of a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig12)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>Reference to targets that belong to the backend. For now, targets are referenced via target groups.
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend12)**<br>Target groups that belong to the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck12)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls12)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls12). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 


### LoadBalancingConfig {#LoadBalancingConfig12}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend12}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### HealthCheck {#HealthCheck12}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend5) or [GrpcBackend.port](#GrpcBackend5)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck12)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck12)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck12)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck12}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck12}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck12}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls12}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext12)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext12}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity12}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


### HeaderSessionAffinity {#HeaderSessionAffinity9}

Field | Description
--- | ---
header_name | **string**<br>Name of the HTTP header field that is used for session affinity. The string length in characters must be 1-256.


### CookieSessionAffinity {#CookieSessionAffinity9}

Field | Description
--- | ---
name | **string**<br>Name of the cookie that is used for session affinity. The string length in characters must be 1-256.
ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum age of cookies that are generated for sessions (persistent cookies). <br>If not set, session cookies are used, which are stored by clients in temporary memory and are deleted on client restarts. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateBackendGroupMetadata](#UpdateBackendGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[BackendGroup](#BackendGroup3)>**<br>if operation finished successfully. 


### UpdateBackendGroupMetadata {#UpdateBackendGroupMetadata}

Field | Description
--- | ---
backend_group_id | **string**<br>ID of the backend group that is being updated. 


### BackendGroup {#BackendGroup3}

Field | Description
--- | ---
id | **string**<br>ID of the backend group. Generated at creation time. 
name | **string**<br>Name of the backend group. The name is unique within the folder. The string length in characters is 3-63. 
description | **string**<br>Description of the backend group. The string is 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the backend group belongs to. 
labels | **map<string,string>**<br>Backend group labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). The maximum number of labels is 64. 
backend | **oneof:** `http`, `grpc` or `stream`<br>Backends that the backend group consists of. <br>A backend group must consist of either HTTP backends or gRPC backends.
&nbsp;&nbsp;http | **[HttpBackendGroup](#HttpBackendGroup5)**<br>List of HTTP backends that the backend group consists of. 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](#GrpcBackendGroup5)**<br>List of gRPC backends that the backend group consists of. 
&nbsp;&nbsp;stream | **[StreamBackendGroup](#StreamBackendGroup3)**<br>List of stream backends that the backend group consist of. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


### HttpBackendGroup {#HttpBackendGroup5}

Field | Description
--- | ---
backends[] | **[HttpBackend](#HttpBackend5)**<br>List of HTTP backends. 
session_affinity | **oneof:** `connection`, `header` or `cookie`<br>Session affinity configuration for the backend group. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity). <br>If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive [HttpBackend.backend_weight](#HttpBackend5)), its [HttpBackend.backend_type](#HttpBackend5) should be [TargetGroupsBackend](#TargetGroupsBackend13), and its [LoadBalancingConfig.load_balancing_mode](#LoadBalancingConfig13) should be `MAGLEV_HASH`. If any of these conditions are not met, session affinity will not work.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity13)**<br>Connection-based session affinity configuration. <br>For now, a connection is defined only by an IP address of the client. 
&nbsp;&nbsp;header | **[HeaderSessionAffinity](#HeaderSessionAffinity10)**<br>HTTP-header-field-based session affinity configuration. 
&nbsp;&nbsp;cookie | **[CookieSessionAffinity](#CookieSessionAffinity10)**<br>Cookie-based session affinity configuration. 


### HttpBackend {#HttpBackend5}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends in a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig13)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups` or `storage_bucket`<br>Reference to targets that belong to the backend. <br>A backend may be a set of target groups or an Object Storage bucket. For details about backend types, see [documentation](/docs/application-load-balancer/concepts/backend-group#types).
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend13)**<br>Target groups that belong to the backend. For details about target groups, see [documentation](/docs/application-load-balancer/concepts/target-group). 
&nbsp;&nbsp;storage_bucket | **[StorageBucketBackend](#StorageBucketBackend5)**<br>Object Storage bucket to use as the backend. For details about buckets, see [documentation](/docs/storage/concepts/bucket). <br>If a bucket is used as a backend, the list of bucket objects and the objects themselves must be publicly accessible. For instructions, see [documentation](/docs/storage/operations/buckets/bucket-availability). 
healthchecks[] | **[HealthCheck](#HealthCheck13)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls13)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls13). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 
use_http2 | **bool**<br>Enables HTTP/2 usage in connections between load balancer nodes and backend targets. <br>Default value: `false`, HTTP/1.1 is used. 


### LoadBalancingConfig {#LoadBalancingConfig13}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend13}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### StorageBucketBackend {#StorageBucketBackend5}

Field | Description
--- | ---
bucket | **string**<br>Required. Name of the bucket. 


### HealthCheck {#HealthCheck13}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend6) or [GrpcBackend.port](#GrpcBackend5)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck13)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck13)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck13)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck13}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck13}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck13}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls13}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext13)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext13}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity13}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


### HeaderSessionAffinity {#HeaderSessionAffinity10}

Field | Description
--- | ---
header_name | **string**<br>Name of the HTTP header field that is used for session affinity. The string length in characters must be 1-256.


### CookieSessionAffinity {#CookieSessionAffinity10}

Field | Description
--- | ---
name | **string**<br>Name of the cookie that is used for session affinity. The string length in characters must be 1-256.
ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum age of cookies that are generated for sessions (persistent cookies). <br>If not set, session cookies are used, which are stored by clients in temporary memory and are deleted on client restarts. 


### GrpcBackendGroup {#GrpcBackendGroup5}

Field | Description
--- | ---
backends[] | **[GrpcBackend](#GrpcBackend5)**<br>List of gRPC backends. 
session_affinity | **oneof:** `connection`, `header` or `cookie`<br>Session affinity configuration for the backend group. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity). <br>If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive [GrpcBackend.backend_weight](#GrpcBackend5)), and its [LoadBalancingConfig.load_balancing_mode](#LoadBalancingConfig14) should be `MAGLEV_HASH`. If any of these conditions are not met, session affinity will not work.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity14)**<br>Connection-based session affinity configuration. <br>For now, a connection is defined only by an IP address of the client. 
&nbsp;&nbsp;header | **[HeaderSessionAffinity](#HeaderSessionAffinity11)**<br>HTTP-header-field-based session affinity configuration. 
&nbsp;&nbsp;cookie | **[CookieSessionAffinity](#CookieSessionAffinity11)**<br>Cookie-based session affinity configuration. 


### GrpcBackend {#GrpcBackend5}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends of a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig14)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>Reference to targets that belong to the backend. For now, targets are referenced via target groups.
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend14)**<br>Target groups that belong to the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck14)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls14)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls14). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 


### LoadBalancingConfig {#LoadBalancingConfig14}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend14}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### HealthCheck {#HealthCheck14}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend6) or [GrpcBackend.port](#GrpcBackend6)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck14)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck14)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck14)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck14}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck14}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck14}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls14}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext14)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext14}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity14}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


### HeaderSessionAffinity {#HeaderSessionAffinity11}

Field | Description
--- | ---
header_name | **string**<br>Name of the HTTP header field that is used for session affinity. The string length in characters must be 1-256.


### CookieSessionAffinity {#CookieSessionAffinity11}

Field | Description
--- | ---
name | **string**<br>Name of the cookie that is used for session affinity. The string length in characters must be 1-256.
ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum age of cookies that are generated for sessions (persistent cookies). <br>If not set, session cookies are used, which are stored by clients in temporary memory and are deleted on client restarts. 


### StreamBackendGroup {#StreamBackendGroup3}

Field | Description
--- | ---
backends[] | **[StreamBackend](#StreamBackend3)**<br> 
session_affinity | **oneof:** `connection`<br>session_affinity is applicable when load_balancing_mode of the selected backend is MAGLEV_HASH.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity15)**<br>session_affinity is applicable when load_balancing_mode of the selected backend is MAGLEV_HASH. 


### StreamBackend {#StreamBackend3}

Field | Description
--- | ---
name | **string**<br> Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If not set, backend will be disabled. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig15)**<br> 
port | **int64**<br>Optional alternative port for all targets. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend15)**<br> 
healthchecks[] | **[HealthCheck](#HealthCheck15)**<br> 
tls | **[BackendTls](#BackendTls15)**<br> 


### LoadBalancingConfig {#LoadBalancingConfig15}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend15}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### HealthCheck {#HealthCheck15}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend6) or [GrpcBackend.port](#GrpcBackend6)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck15)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck15)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck15)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck15}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck15}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck15}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls15}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext15)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext15}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity15}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


## Delete {#Delete}

Deletes the specified backend group.

**rpc Delete ([DeleteBackendGroupRequest](#DeleteBackendGroupRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteBackendGroupMetadata](#DeleteBackendGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteBackendGroupRequest {#DeleteBackendGroupRequest}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. ID of the backend group to delete. <br>To get the backend group ID, make a [BackendGroupService.List](#List) request. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteBackendGroupMetadata](#DeleteBackendGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteBackendGroupMetadata {#DeleteBackendGroupMetadata}

Field | Description
--- | ---
backend_group_id | **string**<br>ID of the backend group that is being deleted. 


## AddBackend {#AddBackend}

Adds backends to the specified backend group.

**rpc AddBackend ([AddBackendRequest](#AddBackendRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddBackendMetadata](#AddBackendMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[BackendGroup](#BackendGroup4)<br>

### AddBackendRequest {#AddBackendRequest}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. ID of the backend group to add a backend to. <br>To get the backend group ID, make a [BackendGroupService.List](#List) request. 
backend | **oneof:** `http` or `grpc`<br>Backend to add to the backend group. <br>A backend group must consist of either HTTP backends or gRPC backends.
&nbsp;&nbsp;http | **[HttpBackend](#HttpBackend6)**<br>HTTP backend to add to the backend group. 
&nbsp;&nbsp;grpc | **[GrpcBackend](#GrpcBackend6)**<br>gRPC backend to add to the backend group. 


### HttpBackend {#HttpBackend6}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends in a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig16)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups` or `storage_bucket`<br>Reference to targets that belong to the backend. <br>A backend may be a set of target groups or an Object Storage bucket. For details about backend types, see [documentation](/docs/application-load-balancer/concepts/backend-group#types).
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend16)**<br>Target groups that belong to the backend. For details about target groups, see [documentation](/docs/application-load-balancer/concepts/target-group). 
&nbsp;&nbsp;storage_bucket | **[StorageBucketBackend](#StorageBucketBackend6)**<br>Object Storage bucket to use as the backend. For details about buckets, see [documentation](/docs/storage/concepts/bucket). <br>If a bucket is used as a backend, the list of bucket objects and the objects themselves must be publicly accessible. For instructions, see [documentation](/docs/storage/operations/buckets/bucket-availability). 
healthchecks[] | **[HealthCheck](#HealthCheck16)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls16)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls16). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 
use_http2 | **bool**<br>Enables HTTP/2 usage in connections between load balancer nodes and backend targets. <br>Default value: `false`, HTTP/1.1 is used. 


### LoadBalancingConfig {#LoadBalancingConfig16}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend16}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### StorageBucketBackend {#StorageBucketBackend6}

Field | Description
--- | ---
bucket | **string**<br>Required. Name of the bucket. 


### HealthCheck {#HealthCheck16}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend7) or [GrpcBackend.port](#GrpcBackend6)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck16)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck16)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck16)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck16}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck16}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck16}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls16}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext16)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext16}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### GrpcBackend {#GrpcBackend6}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends of a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig17)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>Reference to targets that belong to the backend. For now, targets are referenced via target groups.
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend17)**<br>Target groups that belong to the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck17)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls17)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls17). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 


### LoadBalancingConfig {#LoadBalancingConfig17}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend17}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### HealthCheck {#HealthCheck17}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend7) or [GrpcBackend.port](#GrpcBackend7)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck17)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck17)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck17)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck17}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck17}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck17}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls17}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext17)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext17}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddBackendMetadata](#AddBackendMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[BackendGroup](#BackendGroup4)>**<br>if operation finished successfully. 


### AddBackendMetadata {#AddBackendMetadata}

Field | Description
--- | ---
backend_group_id | **string**<br>ID of the backend group that the backend is being added to. 
backend_name | **string**<br>Name of the backend that is being added to the backend group. 


### BackendGroup {#BackendGroup4}

Field | Description
--- | ---
id | **string**<br>ID of the backend group. Generated at creation time. 
name | **string**<br>Name of the backend group. The name is unique within the folder. The string length in characters is 3-63. 
description | **string**<br>Description of the backend group. The string is 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the backend group belongs to. 
labels | **map<string,string>**<br>Backend group labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). The maximum number of labels is 64. 
backend | **oneof:** `http`, `grpc` or `stream`<br>Backends that the backend group consists of. <br>A backend group must consist of either HTTP backends or gRPC backends.
&nbsp;&nbsp;http | **[HttpBackendGroup](#HttpBackendGroup6)**<br>List of HTTP backends that the backend group consists of. 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](#GrpcBackendGroup6)**<br>List of gRPC backends that the backend group consists of. 
&nbsp;&nbsp;stream | **[StreamBackendGroup](#StreamBackendGroup4)**<br>List of stream backends that the backend group consist of. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


### HttpBackendGroup {#HttpBackendGroup6}

Field | Description
--- | ---
backends[] | **[HttpBackend](#HttpBackend7)**<br>List of HTTP backends. 
session_affinity | **oneof:** `connection`, `header` or `cookie`<br>Session affinity configuration for the backend group. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity). <br>If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive [HttpBackend.backend_weight](#HttpBackend7)), its [HttpBackend.backend_type](#HttpBackend7) should be [TargetGroupsBackend](#TargetGroupsBackend18), and its [LoadBalancingConfig.load_balancing_mode](#LoadBalancingConfig18) should be `MAGLEV_HASH`. If any of these conditions are not met, session affinity will not work.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity16)**<br>Connection-based session affinity configuration. <br>For now, a connection is defined only by an IP address of the client. 
&nbsp;&nbsp;header | **[HeaderSessionAffinity](#HeaderSessionAffinity12)**<br>HTTP-header-field-based session affinity configuration. 
&nbsp;&nbsp;cookie | **[CookieSessionAffinity](#CookieSessionAffinity12)**<br>Cookie-based session affinity configuration. 


### HttpBackend {#HttpBackend7}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends in a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig18)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups` or `storage_bucket`<br>Reference to targets that belong to the backend. <br>A backend may be a set of target groups or an Object Storage bucket. For details about backend types, see [documentation](/docs/application-load-balancer/concepts/backend-group#types).
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend18)**<br>Target groups that belong to the backend. For details about target groups, see [documentation](/docs/application-load-balancer/concepts/target-group). 
&nbsp;&nbsp;storage_bucket | **[StorageBucketBackend](#StorageBucketBackend7)**<br>Object Storage bucket to use as the backend. For details about buckets, see [documentation](/docs/storage/concepts/bucket). <br>If a bucket is used as a backend, the list of bucket objects and the objects themselves must be publicly accessible. For instructions, see [documentation](/docs/storage/operations/buckets/bucket-availability). 
healthchecks[] | **[HealthCheck](#HealthCheck18)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls18)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls18). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 
use_http2 | **bool**<br>Enables HTTP/2 usage in connections between load balancer nodes and backend targets. <br>Default value: `false`, HTTP/1.1 is used. 


### LoadBalancingConfig {#LoadBalancingConfig18}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend18}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### StorageBucketBackend {#StorageBucketBackend7}

Field | Description
--- | ---
bucket | **string**<br>Required. Name of the bucket. 


### HealthCheck {#HealthCheck18}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend8) or [GrpcBackend.port](#GrpcBackend7)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck18)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck18)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck18)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck18}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck18}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck18}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls18}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext18)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext18}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity16}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


### HeaderSessionAffinity {#HeaderSessionAffinity12}

Field | Description
--- | ---
header_name | **string**<br>Name of the HTTP header field that is used for session affinity. The string length in characters must be 1-256.


### CookieSessionAffinity {#CookieSessionAffinity12}

Field | Description
--- | ---
name | **string**<br>Name of the cookie that is used for session affinity. The string length in characters must be 1-256.
ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum age of cookies that are generated for sessions (persistent cookies). <br>If not set, session cookies are used, which are stored by clients in temporary memory and are deleted on client restarts. 


### GrpcBackendGroup {#GrpcBackendGroup6}

Field | Description
--- | ---
backends[] | **[GrpcBackend](#GrpcBackend7)**<br>List of gRPC backends. 
session_affinity | **oneof:** `connection`, `header` or `cookie`<br>Session affinity configuration for the backend group. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity). <br>If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive [GrpcBackend.backend_weight](#GrpcBackend7)), and its [LoadBalancingConfig.load_balancing_mode](#LoadBalancingConfig19) should be `MAGLEV_HASH`. If any of these conditions are not met, session affinity will not work.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity17)**<br>Connection-based session affinity configuration. <br>For now, a connection is defined only by an IP address of the client. 
&nbsp;&nbsp;header | **[HeaderSessionAffinity](#HeaderSessionAffinity13)**<br>HTTP-header-field-based session affinity configuration. 
&nbsp;&nbsp;cookie | **[CookieSessionAffinity](#CookieSessionAffinity13)**<br>Cookie-based session affinity configuration. 


### GrpcBackend {#GrpcBackend7}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends of a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig19)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>Reference to targets that belong to the backend. For now, targets are referenced via target groups.
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend19)**<br>Target groups that belong to the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck19)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls19)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls19). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 


### LoadBalancingConfig {#LoadBalancingConfig19}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend19}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### HealthCheck {#HealthCheck19}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend8) or [GrpcBackend.port](#GrpcBackend8)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck19)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck19)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck19)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck19}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck19}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck19}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls19}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext19)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext19}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity17}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


### HeaderSessionAffinity {#HeaderSessionAffinity13}

Field | Description
--- | ---
header_name | **string**<br>Name of the HTTP header field that is used for session affinity. The string length in characters must be 1-256.


### CookieSessionAffinity {#CookieSessionAffinity13}

Field | Description
--- | ---
name | **string**<br>Name of the cookie that is used for session affinity. The string length in characters must be 1-256.
ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum age of cookies that are generated for sessions (persistent cookies). <br>If not set, session cookies are used, which are stored by clients in temporary memory and are deleted on client restarts. 


### StreamBackendGroup {#StreamBackendGroup4}

Field | Description
--- | ---
backends[] | **[StreamBackend](#StreamBackend4)**<br> 
session_affinity | **oneof:** `connection`<br>session_affinity is applicable when load_balancing_mode of the selected backend is MAGLEV_HASH.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity18)**<br>session_affinity is applicable when load_balancing_mode of the selected backend is MAGLEV_HASH. 


### StreamBackend {#StreamBackend4}

Field | Description
--- | ---
name | **string**<br> Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If not set, backend will be disabled. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig20)**<br> 
port | **int64**<br>Optional alternative port for all targets. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend20)**<br> 
healthchecks[] | **[HealthCheck](#HealthCheck20)**<br> 
tls | **[BackendTls](#BackendTls20)**<br> 


### LoadBalancingConfig {#LoadBalancingConfig20}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend20}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### HealthCheck {#HealthCheck20}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend8) or [GrpcBackend.port](#GrpcBackend8)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck20)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck20)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck20)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck20}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck20}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck20}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls20}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext20)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext20}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity18}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


## RemoveBackend {#RemoveBackend}

Removes backends from the specified backend group.

**rpc RemoveBackend ([RemoveBackendRequest](#RemoveBackendRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveBackendMetadata](#RemoveBackendMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[BackendGroup](#BackendGroup5)<br>

### RemoveBackendRequest {#RemoveBackendRequest}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. ID of the backend group to remove a backend from. <br>To get the backend group ID, make a [BackendGroupService.List](#List) request. 
backend_name | **string**<br>Required. Name of the backend to remove. <br>To get the backend name, make a [BackendGroupService.Get](#Get) request. 


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RemoveBackendMetadata](#RemoveBackendMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[BackendGroup](#BackendGroup5)>**<br>if operation finished successfully. 


### RemoveBackendMetadata {#RemoveBackendMetadata}

Field | Description
--- | ---
backend_group_id | **string**<br>ID of the backend group that the backend is being removed from. 
backend_name | **string**<br>Name of the backend that is being removed. 


### BackendGroup {#BackendGroup5}

Field | Description
--- | ---
id | **string**<br>ID of the backend group. Generated at creation time. 
name | **string**<br>Name of the backend group. The name is unique within the folder. The string length in characters is 3-63. 
description | **string**<br>Description of the backend group. The string is 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the backend group belongs to. 
labels | **map<string,string>**<br>Backend group labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). The maximum number of labels is 64. 
backend | **oneof:** `http`, `grpc` or `stream`<br>Backends that the backend group consists of. <br>A backend group must consist of either HTTP backends or gRPC backends.
&nbsp;&nbsp;http | **[HttpBackendGroup](#HttpBackendGroup7)**<br>List of HTTP backends that the backend group consists of. 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](#GrpcBackendGroup7)**<br>List of gRPC backends that the backend group consists of. 
&nbsp;&nbsp;stream | **[StreamBackendGroup](#StreamBackendGroup5)**<br>List of stream backends that the backend group consist of. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


### HttpBackendGroup {#HttpBackendGroup7}

Field | Description
--- | ---
backends[] | **[HttpBackend](#HttpBackend8)**<br>List of HTTP backends. 
session_affinity | **oneof:** `connection`, `header` or `cookie`<br>Session affinity configuration for the backend group. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity). <br>If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive [HttpBackend.backend_weight](#HttpBackend8)), its [HttpBackend.backend_type](#HttpBackend8) should be [TargetGroupsBackend](#TargetGroupsBackend21), and its [LoadBalancingConfig.load_balancing_mode](#LoadBalancingConfig21) should be `MAGLEV_HASH`. If any of these conditions are not met, session affinity will not work.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity19)**<br>Connection-based session affinity configuration. <br>For now, a connection is defined only by an IP address of the client. 
&nbsp;&nbsp;header | **[HeaderSessionAffinity](#HeaderSessionAffinity14)**<br>HTTP-header-field-based session affinity configuration. 
&nbsp;&nbsp;cookie | **[CookieSessionAffinity](#CookieSessionAffinity14)**<br>Cookie-based session affinity configuration. 


### HttpBackend {#HttpBackend8}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends in a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig21)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups` or `storage_bucket`<br>Reference to targets that belong to the backend. <br>A backend may be a set of target groups or an Object Storage bucket. For details about backend types, see [documentation](/docs/application-load-balancer/concepts/backend-group#types).
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend21)**<br>Target groups that belong to the backend. For details about target groups, see [documentation](/docs/application-load-balancer/concepts/target-group). 
&nbsp;&nbsp;storage_bucket | **[StorageBucketBackend](#StorageBucketBackend8)**<br>Object Storage bucket to use as the backend. For details about buckets, see [documentation](/docs/storage/concepts/bucket). <br>If a bucket is used as a backend, the list of bucket objects and the objects themselves must be publicly accessible. For instructions, see [documentation](/docs/storage/operations/buckets/bucket-availability). 
healthchecks[] | **[HealthCheck](#HealthCheck21)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls21)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls21). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 
use_http2 | **bool**<br>Enables HTTP/2 usage in connections between load balancer nodes and backend targets. <br>Default value: `false`, HTTP/1.1 is used. 


### LoadBalancingConfig {#LoadBalancingConfig21}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend21}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### StorageBucketBackend {#StorageBucketBackend8}

Field | Description
--- | ---
bucket | **string**<br>Required. Name of the bucket. 


### HealthCheck {#HealthCheck21}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend9) or [GrpcBackend.port](#GrpcBackend8)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck21)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck21)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck21)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck21}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck21}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck21}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls21}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext21)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext21}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity19}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


### HeaderSessionAffinity {#HeaderSessionAffinity14}

Field | Description
--- | ---
header_name | **string**<br>Name of the HTTP header field that is used for session affinity. The string length in characters must be 1-256.


### CookieSessionAffinity {#CookieSessionAffinity14}

Field | Description
--- | ---
name | **string**<br>Name of the cookie that is used for session affinity. The string length in characters must be 1-256.
ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum age of cookies that are generated for sessions (persistent cookies). <br>If not set, session cookies are used, which are stored by clients in temporary memory and are deleted on client restarts. 


### GrpcBackendGroup {#GrpcBackendGroup7}

Field | Description
--- | ---
backends[] | **[GrpcBackend](#GrpcBackend8)**<br>List of gRPC backends. 
session_affinity | **oneof:** `connection`, `header` or `cookie`<br>Session affinity configuration for the backend group. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity). <br>If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive [GrpcBackend.backend_weight](#GrpcBackend8)), and its [LoadBalancingConfig.load_balancing_mode](#LoadBalancingConfig22) should be `MAGLEV_HASH`. If any of these conditions are not met, session affinity will not work.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity20)**<br>Connection-based session affinity configuration. <br>For now, a connection is defined only by an IP address of the client. 
&nbsp;&nbsp;header | **[HeaderSessionAffinity](#HeaderSessionAffinity15)**<br>HTTP-header-field-based session affinity configuration. 
&nbsp;&nbsp;cookie | **[CookieSessionAffinity](#CookieSessionAffinity15)**<br>Cookie-based session affinity configuration. 


### GrpcBackend {#GrpcBackend8}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends of a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig22)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>Reference to targets that belong to the backend. For now, targets are referenced via target groups.
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend22)**<br>Target groups that belong to the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck22)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls22)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls22). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 


### LoadBalancingConfig {#LoadBalancingConfig22}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend22}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### HealthCheck {#HealthCheck22}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend9) or [GrpcBackend.port](#GrpcBackend9)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck22)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck22)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck22)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck22}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck22}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck22}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls22}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext22)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext22}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity20}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


### HeaderSessionAffinity {#HeaderSessionAffinity15}

Field | Description
--- | ---
header_name | **string**<br>Name of the HTTP header field that is used for session affinity. The string length in characters must be 1-256.


### CookieSessionAffinity {#CookieSessionAffinity15}

Field | Description
--- | ---
name | **string**<br>Name of the cookie that is used for session affinity. The string length in characters must be 1-256.
ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum age of cookies that are generated for sessions (persistent cookies). <br>If not set, session cookies are used, which are stored by clients in temporary memory and are deleted on client restarts. 


### StreamBackendGroup {#StreamBackendGroup5}

Field | Description
--- | ---
backends[] | **[StreamBackend](#StreamBackend5)**<br> 
session_affinity | **oneof:** `connection`<br>session_affinity is applicable when load_balancing_mode of the selected backend is MAGLEV_HASH.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity21)**<br>session_affinity is applicable when load_balancing_mode of the selected backend is MAGLEV_HASH. 


### StreamBackend {#StreamBackend5}

Field | Description
--- | ---
name | **string**<br> Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If not set, backend will be disabled. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig23)**<br> 
port | **int64**<br>Optional alternative port for all targets. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend23)**<br> 
healthchecks[] | **[HealthCheck](#HealthCheck23)**<br> 
tls | **[BackendTls](#BackendTls23)**<br> 


### LoadBalancingConfig {#LoadBalancingConfig23}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend23}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### HealthCheck {#HealthCheck23}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend9) or [GrpcBackend.port](#GrpcBackend9)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck23)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck23)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck23)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck23}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck23}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck23}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls23}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext23)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext23}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity21}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


## UpdateBackend {#UpdateBackend}

Updates the specified backend.

**rpc UpdateBackend ([UpdateBackendRequest](#UpdateBackendRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateBackendMetadata](#UpdateBackendMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[BackendGroup](#BackendGroup6)<br>

### UpdateBackendRequest {#UpdateBackendRequest}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. ID of the backend group to update the backend in. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the backend should be updated. 
backend | **oneof:** `http` or `grpc`<br>Name of the backend to update (required) and new settings for the backend.
&nbsp;&nbsp;http | **[HttpBackend](#HttpBackend9)**<br>New settings for the HTTP backend. 
&nbsp;&nbsp;grpc | **[GrpcBackend](#GrpcBackend9)**<br>New settings for the gRPC backend. 


### HttpBackend {#HttpBackend9}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends in a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig24)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups` or `storage_bucket`<br>Reference to targets that belong to the backend. <br>A backend may be a set of target groups or an Object Storage bucket. For details about backend types, see [documentation](/docs/application-load-balancer/concepts/backend-group#types).
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend24)**<br>Target groups that belong to the backend. For details about target groups, see [documentation](/docs/application-load-balancer/concepts/target-group). 
&nbsp;&nbsp;storage_bucket | **[StorageBucketBackend](#StorageBucketBackend9)**<br>Object Storage bucket to use as the backend. For details about buckets, see [documentation](/docs/storage/concepts/bucket). <br>If a bucket is used as a backend, the list of bucket objects and the objects themselves must be publicly accessible. For instructions, see [documentation](/docs/storage/operations/buckets/bucket-availability). 
healthchecks[] | **[HealthCheck](#HealthCheck24)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls24)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls24). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 
use_http2 | **bool**<br>Enables HTTP/2 usage in connections between load balancer nodes and backend targets. <br>Default value: `false`, HTTP/1.1 is used. 


### LoadBalancingConfig {#LoadBalancingConfig24}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend24}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### StorageBucketBackend {#StorageBucketBackend9}

Field | Description
--- | ---
bucket | **string**<br>Required. Name of the bucket. 


### HealthCheck {#HealthCheck24}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend10) or [GrpcBackend.port](#GrpcBackend9)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck24)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck24)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck24)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck24}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck24}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck24}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls24}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext24)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext24}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### GrpcBackend {#GrpcBackend9}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends of a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig25)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>Reference to targets that belong to the backend. For now, targets are referenced via target groups.
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend25)**<br>Target groups that belong to the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck25)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls25)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls25). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 


### LoadBalancingConfig {#LoadBalancingConfig25}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend25}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### HealthCheck {#HealthCheck25}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend10) or [GrpcBackend.port](#GrpcBackend10)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck25)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck25)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck25)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck25}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck25}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck25}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls25}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext25)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext25}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### Operation {#Operation5}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateBackendMetadata](#UpdateBackendMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[BackendGroup](#BackendGroup6)>**<br>if operation finished successfully. 


### UpdateBackendMetadata {#UpdateBackendMetadata}

Field | Description
--- | ---
backend_group_id | **string**<br>ID of the backend group that the backend is being updated it. 
backend_name | **string**<br>Name of the backend that is being updated. 


### BackendGroup {#BackendGroup6}

Field | Description
--- | ---
id | **string**<br>ID of the backend group. Generated at creation time. 
name | **string**<br>Name of the backend group. The name is unique within the folder. The string length in characters is 3-63. 
description | **string**<br>Description of the backend group. The string is 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the backend group belongs to. 
labels | **map<string,string>**<br>Backend group labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). The maximum number of labels is 64. 
backend | **oneof:** `http`, `grpc` or `stream`<br>Backends that the backend group consists of. <br>A backend group must consist of either HTTP backends or gRPC backends.
&nbsp;&nbsp;http | **[HttpBackendGroup](#HttpBackendGroup8)**<br>List of HTTP backends that the backend group consists of. 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](#GrpcBackendGroup8)**<br>List of gRPC backends that the backend group consists of. 
&nbsp;&nbsp;stream | **[StreamBackendGroup](#StreamBackendGroup6)**<br>List of stream backends that the backend group consist of. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


### HttpBackendGroup {#HttpBackendGroup8}

Field | Description
--- | ---
backends[] | **[HttpBackend](#HttpBackend10)**<br>List of HTTP backends. 
session_affinity | **oneof:** `connection`, `header` or `cookie`<br>Session affinity configuration for the backend group. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity). <br>If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive [HttpBackend.backend_weight](#HttpBackend10)), its [HttpBackend.backend_type](#HttpBackend10) should be [TargetGroupsBackend](#TargetGroupsBackend26), and its [LoadBalancingConfig.load_balancing_mode](#LoadBalancingConfig26) should be `MAGLEV_HASH`. If any of these conditions are not met, session affinity will not work.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity22)**<br>Connection-based session affinity configuration. <br>For now, a connection is defined only by an IP address of the client. 
&nbsp;&nbsp;header | **[HeaderSessionAffinity](#HeaderSessionAffinity16)**<br>HTTP-header-field-based session affinity configuration. 
&nbsp;&nbsp;cookie | **[CookieSessionAffinity](#CookieSessionAffinity16)**<br>Cookie-based session affinity configuration. 


### HttpBackend {#HttpBackend10}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends in a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig26)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups` or `storage_bucket`<br>Reference to targets that belong to the backend. <br>A backend may be a set of target groups or an Object Storage bucket. For details about backend types, see [documentation](/docs/application-load-balancer/concepts/backend-group#types).
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend26)**<br>Target groups that belong to the backend. For details about target groups, see [documentation](/docs/application-load-balancer/concepts/target-group). 
&nbsp;&nbsp;storage_bucket | **[StorageBucketBackend](#StorageBucketBackend10)**<br>Object Storage bucket to use as the backend. For details about buckets, see [documentation](/docs/storage/concepts/bucket). <br>If a bucket is used as a backend, the list of bucket objects and the objects themselves must be publicly accessible. For instructions, see [documentation](/docs/storage/operations/buckets/bucket-availability). 
healthchecks[] | **[HealthCheck](#HealthCheck26)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls26)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls26). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 
use_http2 | **bool**<br>Enables HTTP/2 usage in connections between load balancer nodes and backend targets. <br>Default value: `false`, HTTP/1.1 is used. 


### LoadBalancingConfig {#LoadBalancingConfig26}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend26}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### StorageBucketBackend {#StorageBucketBackend10}

Field | Description
--- | ---
bucket | **string**<br>Required. Name of the bucket. 


### HealthCheck {#HealthCheck26}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend11) or [GrpcBackend.port](#GrpcBackend10)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck26)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck26)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck26)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck26}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck26}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck26}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls26}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext26)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext26}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity22}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


### HeaderSessionAffinity {#HeaderSessionAffinity16}

Field | Description
--- | ---
header_name | **string**<br>Name of the HTTP header field that is used for session affinity. The string length in characters must be 1-256.


### CookieSessionAffinity {#CookieSessionAffinity16}

Field | Description
--- | ---
name | **string**<br>Name of the cookie that is used for session affinity. The string length in characters must be 1-256.
ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum age of cookies that are generated for sessions (persistent cookies). <br>If not set, session cookies are used, which are stored by clients in temporary memory and are deleted on client restarts. 


### GrpcBackendGroup {#GrpcBackendGroup8}

Field | Description
--- | ---
backends[] | **[GrpcBackend](#GrpcBackend10)**<br>List of gRPC backends. 
session_affinity | **oneof:** `connection`, `header` or `cookie`<br>Session affinity configuration for the backend group. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/backend-group#session-affinity). <br>If session affinity is configured, the backend group should contain exactly one active backend (i.e. with positive [GrpcBackend.backend_weight](#GrpcBackend10)), and its [LoadBalancingConfig.load_balancing_mode](#LoadBalancingConfig27) should be `MAGLEV_HASH`. If any of these conditions are not met, session affinity will not work.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity23)**<br>Connection-based session affinity configuration. <br>For now, a connection is defined only by an IP address of the client. 
&nbsp;&nbsp;header | **[HeaderSessionAffinity](#HeaderSessionAffinity17)**<br>HTTP-header-field-based session affinity configuration. 
&nbsp;&nbsp;cookie | **[CookieSessionAffinity](#CookieSessionAffinity17)**<br>Cookie-based session affinity configuration. 


### GrpcBackend {#GrpcBackend10}

Field | Description
--- | ---
name | **string**<br>Required. Name of the backend. Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Backend weight. Traffic is distributed between backends of a backend group according to their weights. <br>Weights must be set either for all backends of a group or for none of them. Setting no weights is the same as setting equal non-zero weights for all backends. <br>If the weight is non-positive, traffic is not sent to the backend. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig27)**<br>Load balancing configuration for the backend. 
port | **int64**<br>Port used by all targets to receive traffic. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>Reference to targets that belong to the backend. For now, targets are referenced via target groups.
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend27)**<br>Target groups that belong to the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck27)**<br>Health checks to perform on targets from target groups. For details about health checking, see [documentation](/docs/application-load-balancer/concepts/backend-group#health-checks). <br>If no health checks are specified, active health checking is not performed. 
tls | **[BackendTls](#BackendTls27)**<br>Settings for TLS connections between load balancer nodes and backend targets. <br>If specified, the load balancer establishes HTTPS (HTTP over TLS) connections with targets and compares received certificates with the one specified in [BackendTls.validation_context](#BackendTls27). If not specified, the load balancer establishes unencrypted HTTP connections with targets. 


### LoadBalancingConfig {#LoadBalancingConfig27}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend27}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### HealthCheck {#HealthCheck27}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend11) or [GrpcBackend.port](#GrpcBackend11)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck27)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck27)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck27)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck27}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck27}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck27}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls27}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext27)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext27}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity23}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


### HeaderSessionAffinity {#HeaderSessionAffinity17}

Field | Description
--- | ---
header_name | **string**<br>Name of the HTTP header field that is used for session affinity. The string length in characters must be 1-256.


### CookieSessionAffinity {#CookieSessionAffinity17}

Field | Description
--- | ---
name | **string**<br>Name of the cookie that is used for session affinity. The string length in characters must be 1-256.
ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum age of cookies that are generated for sessions (persistent cookies). <br>If not set, session cookies are used, which are stored by clients in temporary memory and are deleted on client restarts. 


### StreamBackendGroup {#StreamBackendGroup6}

Field | Description
--- | ---
backends[] | **[StreamBackend](#StreamBackend6)**<br> 
session_affinity | **oneof:** `connection`<br>session_affinity is applicable when load_balancing_mode of the selected backend is MAGLEV_HASH.
&nbsp;&nbsp;connection | **[ConnectionSessionAffinity](#ConnectionSessionAffinity24)**<br>session_affinity is applicable when load_balancing_mode of the selected backend is MAGLEV_HASH. 


### StreamBackend {#StreamBackend6}

Field | Description
--- | ---
name | **string**<br> Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>If not set, backend will be disabled. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig28)**<br> 
port | **int64**<br>Optional alternative port for all targets. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend28)**<br> 
healthchecks[] | **[HealthCheck](#HealthCheck28)**<br> 
tls | **[BackendTls](#BackendTls28)**<br> 


### LoadBalancingConfig {#LoadBalancingConfig28}

Field | Description
--- | ---
panic_threshold | **int64**<br>Threshold for panic mode. <br>If percentage of healthy backends in the group drops below threshold, panic mode will be activated and traffic will be routed to all backends, regardless of their health check status. This helps to avoid overloading healthy backends. For details about panic mode, see [documentation](/docs/application-load-balancer/concepts/backend-group#panic-mode). <br>If the value is `0`, panic mode will never be activated and traffic is routed only to healthy backends at all times. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percentage of traffic that a load balancer node sends to healthy backends in its availability zone. The rest is divided equally between other zones. For details about zone-aware routing, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If there are no healthy backends in an availability zone, all the traffic is divided between other zones. <br>If `strict_locality` is `true`, the specified value is ignored. A load balancer node sends all the traffic within its availability zone, regardless of backends' health. <br>Default value: `0`. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>Specifies whether a load balancer node should only send traffic to backends in its availability zone, regardless of their health, and ignore backends in other zones. <br>If set to `true` and there are no healthy backends in the zone, the node in this zone will respond to incoming traffic with errors. For details about strict locality, see [documentation](/docs/application-load-balancer/concepts/backend-group#locality). <br>If `strict_locality` is `true`, the value specified in `locality_aware_routing_percent` is ignored. <br>Default value: `false`. 
mode | enum **LoadBalancingMode**<br>Load balancing mode for the backend. <br>For detals about load balancing modes, see [documentation](/docs/application-load-balancer/concepts/backend-group#balancing-mode). <ul><li>`ROUND_ROBIN`: Round robin load balancing mode. <br>All endpoints of the backend take their turns to receive requests attributed to the backend.</li><li>`RANDOM`: Random load balancing mode. Default value. <br>For a request attributed to the backend, an endpoint that receives it is picked at random.</li><li>`LEAST_REQUEST`: Least request load balancing mode. <br>To pick an endpoint that receives a request attributed to the backend, the power of two choices algorithm is used; that is, two endpoints are picked at random, and the request is sent to the one which has the fewest active requests.</li><li>`MAGLEV_HASH`: Maglev hashing load balancing mode, used only if session affinity is working for the backend group. <br>Each endpoint is hashed, and a hash table with 65537 rows is filled accordingly, so that every endpoint occupies the same amount of rows. An attribute of each request, specified in session affinity configuration of the backend group, is also hashed by the same function. The row with the same number as the resulting value is looked up in the table to determine the endpoint that receives the request. <br>If session affinity is not working for the backend group (i.e. it is not configured or the group contains more than one backend with positive weight), endpoints for backends with `MAGLEV_HASH` load balancing mode are picked at `RANDOM` instead.</li><ul/>


### TargetGroupsBackend {#TargetGroupsBackend28}

Field | Description
--- | ---
target_group_ids[] | **string**<br>List of ID's of target groups that belong to the backend. <br>To get the ID's of all available target groups, make a [TargetGroupService.List](./target_group_service#List) request. The number of elements must be greater than 0.


### HealthCheck {#HealthCheck28}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Health check timeout. <br>The timeout is the time allowed for the target to respond to a check. If the target doesn't respond in time, the check is considered failed. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Base interval between consecutive health checks. 
interval_jitter_percent | **double**<br> 
healthy_threshold | **int64**<br>Number of consecutive successful health checks required to mark an unhealthy target as healthy. <br>Both `0` and `1` values amount to one successful check required. <br>The value is ignored when a load balancer is initialized; a target is marked healthy after one successful check. <br>Default value: `0`. 
unhealthy_threshold | **int64**<br>Number of consecutive failed health checks required to mark a healthy target as unhealthy. <br>Both `0` and `1` values amount to one unsuccessful check required. <br>The value is ignored if a health check is failed due to an HTTP `503 Service Unavailable` response from the target (not applicable to TCP stream health checks). The target is immediately marked unhealthy. <br>Default value: `0`. 
healthcheck_port | **int64**<br>Port used for health checks. <br>If not specified, the backend port ([HttpBackend.port](#HttpBackend11) or [GrpcBackend.port](#GrpcBackend11)) is used for health checks. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>Protocol-specific health check settings. <br>The protocols of the backend and of its health check may differ, e.g. a gRPC health check may be specified for an HTTP backend.
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck28)**<br>TCP stream health check settings. 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck28)**<br>HTTP health check settings. 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck28)**<br>gRPC health check settings. 


### StreamHealthCheck {#StreamHealthCheck28}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Message sent to targets during TCP data transfer. <br>If not specified, no data is sent to the target. 
receive | **[Payload](#Payload)**<br>Data that must be contained in the messages received from targets for a successful health check. <br>If not specified, no messages are expected from targets, and those that are received are not checked. 


### HttpHealthCheck {#HttpHealthCheck28}

Field | Description
--- | ---
host | **string**<br>Value for the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header used in requests to targets. 
path | **string**<br>Required. HTTP path used in requests to targets: request URI for HTTP/1.1 request line or value for the HTTP/2 `:path` pseudo-header. 
use_http2 | **bool**<br>Enables HTTP/2 usage in health checks. <br>Default value: `false`, HTTP/1.1 is used. 


### GrpcHealthCheck {#GrpcHealthCheck28}

Field | Description
--- | ---
service_name | **string**<br>Name of the gRPC service to be checked. <br>If not specified, overall health is checked. <br>For details about the concept, see [GRPC Health Checking Protocol](https://github.com/grpc/grpc/blob/master/doc/health-checking.md). 


### BackendTls {#BackendTls28}

Field | Description
--- | ---
sni | **string**<br>Server Name Indication (SNI) string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext28)**<br>Validation context for TLS connections. 


### ValidationContext {#ValidationContext28}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>TLS certificate issued by a trusted certificate authority (CA).
&nbsp;&nbsp;trusted_ca_id | **string**<br>TLS certificate issued by a trusted certificate authority (CA). 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>X.509 certificate contents in PEM format. 


### ConnectionSessionAffinity {#ConnectionSessionAffinity24}

Field | Description
--- | ---
source_ip | **bool**<br>Specifies whether an IP address of the client is used to define a connection for session affinity. 


## ListOperations {#ListOperations}

Lists operations for the specified backend group.

**rpc ListOperations ([ListBackendGroupOperationsRequest](#ListBackendGroupOperationsRequest)) returns ([ListBackendGroupOperationsResponse](#ListBackendGroupOperationsResponse))**

### ListBackendGroupOperationsRequest {#ListBackendGroupOperationsRequest}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. ID of the backend group to get operations for. <br>To get the backend group ID, use a [BackendGroupService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListBackendGroupOperationsResponse.next_page_token](#ListBackendGroupOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListBackendGroupOperationsResponse.next_page_token](#ListBackendGroupOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListBackendGroupOperationsResponse {#ListBackendGroupOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation6)**<br>List of operations for the specified backend group. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListBackendGroupOperationsRequest.page_size](#ListBackendGroupOperationsRequest), use `next_page_token` as the value for the [ListBackendGroupOperationsRequest.page_token](#ListBackendGroupOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation6}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any. 



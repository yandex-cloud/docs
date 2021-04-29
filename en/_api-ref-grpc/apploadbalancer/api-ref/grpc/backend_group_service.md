---
editable: false
---

# BackendGroupService



| Call | Description |
| --- | --- |
| [Get](#Get) |  |
| [List](#List) |  |
| [Create](#Create) |  |
| [Update](#Update) |  |
| [Delete](#Delete) |  |
| [AddBackend](#AddBackend) | AddBackend/RemoveBackend technically do the same, but have different semantics. |
| [RemoveBackend](#RemoveBackend) |  |
| [UpdateBackend](#UpdateBackend) |  |
| [ListOperations](#ListOperations) | Lists operations for the specified backend group. |

## Calls BackendGroupService {#calls}

## Get {#Get}



**rpc Get ([GetBackendGroupRequest](#GetBackendGroupRequest)) returns ([BackendGroup](#BackendGroup))**

### GetBackendGroupRequest {#GetBackendGroupRequest}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### BackendGroup {#BackendGroup}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the backend group. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the backend group. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the backend group belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackendGroup](#HttpBackendGroup)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](#GrpcBackendGroup)**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the backend group. 


### HttpBackendGroup {#HttpBackendGroup}

Field | Description
--- | ---
backends[] | **[HttpBackend](#HttpBackend)**<br> 


### HttpBackend {#HttpBackend}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls)**<br>TLS settings for the upstream. 
use_http2 | **bool**<br>Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default. 


### LoadBalancingConfig {#LoadBalancingConfig}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


### GrpcBackendGroup {#GrpcBackendGroup}

Field | Description
--- | ---
backends[] | **[GrpcBackend](#GrpcBackend)**<br> 


### GrpcBackend {#GrpcBackend}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig1)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend1)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck1)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls1)**<br>TLS settings for the upstream. 


### LoadBalancingConfig {#LoadBalancingConfig1}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend1}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck1}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck1)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck1)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck1)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck1}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck1}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck1}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls1}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext1)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext1}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


## List {#List}



**rpc List ([ListBackendGroupsRequest](#ListBackendGroupsRequest)) returns ([ListBackendGroupsResponse](#ListBackendGroupsResponse))**

### ListBackendGroupsRequest {#ListBackendGroupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required.  
page_size | **int64**<br> Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br> The maximum string length in characters is 100.
filter | **string**<br> The maximum string length in characters is 1000.


### ListBackendGroupsResponse {#ListBackendGroupsResponse}

Field | Description
--- | ---
backend_groups[] | **[BackendGroup](#BackendGroup1)**<br> 
next_page_token | **string**<br> 


### BackendGroup {#BackendGroup1}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the backend group. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the backend group. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the backend group belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackendGroup](#HttpBackendGroup1)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](#GrpcBackendGroup1)**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the backend group. 


### HttpBackendGroup {#HttpBackendGroup1}

Field | Description
--- | ---
backends[] | **[HttpBackend](#HttpBackend1)**<br> 


### HttpBackend {#HttpBackend1}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig2)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend2)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck2)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls2)**<br>TLS settings for the upstream. 
use_http2 | **bool**<br>Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default. 


### LoadBalancingConfig {#LoadBalancingConfig2}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend2}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck2}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck2)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck2)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck2)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck2}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck2}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck2}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls2}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext2)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext2}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


### GrpcBackendGroup {#GrpcBackendGroup1}

Field | Description
--- | ---
backends[] | **[GrpcBackend](#GrpcBackend1)**<br> 


### GrpcBackend {#GrpcBackend1}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig3)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend3)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck3)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls3)**<br>TLS settings for the upstream. 


### LoadBalancingConfig {#LoadBalancingConfig3}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend3}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck3}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck3)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck3)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck3)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck3}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck3}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck3}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls3}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext3)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext3}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


## Create {#Create}



**rpc Create ([CreateBackendGroupRequest](#CreateBackendGroupRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateBackendGroupMetadata](#CreateBackendGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[BackendGroup](#BackendGroup2)<br>

### CreateBackendGroupRequest {#CreateBackendGroupRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required.  
name | **string**<br> Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br> The maximum string length in characters is 256.
labels | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackendGroup](#HttpBackendGroup2)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](#GrpcBackendGroup2)**<br> 


### HttpBackendGroup {#HttpBackendGroup2}

Field | Description
--- | ---
backends[] | **[HttpBackend](#HttpBackend2)**<br> 


### HttpBackend {#HttpBackend2}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig4)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend4)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck4)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls4)**<br>TLS settings for the upstream. 
use_http2 | **bool**<br>Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default. 


### LoadBalancingConfig {#LoadBalancingConfig4}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend4}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck4}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck4)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck4)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck4)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck4}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck4}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck4}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls4}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext4)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext4}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


### GrpcBackendGroup {#GrpcBackendGroup2}

Field | Description
--- | ---
backends[] | **[GrpcBackend](#GrpcBackend2)**<br> 


### GrpcBackend {#GrpcBackend2}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig5)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend5)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck5)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls5)**<br>TLS settings for the upstream. 


### LoadBalancingConfig {#LoadBalancingConfig5}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend5}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck5}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck5)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck5)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck5)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck5}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck5}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck5}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls5}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext5)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext5}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


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
backend_group_id | **string**<br> 


### BackendGroup {#BackendGroup2}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the backend group. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the backend group. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the backend group belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackendGroup](#HttpBackendGroup3)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](#GrpcBackendGroup3)**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the backend group. 


### HttpBackendGroup {#HttpBackendGroup3}

Field | Description
--- | ---
backends[] | **[HttpBackend](#HttpBackend3)**<br> 


### HttpBackend {#HttpBackend3}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig6)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend6)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck6)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls6)**<br>TLS settings for the upstream. 
use_http2 | **bool**<br>Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default. 


### LoadBalancingConfig {#LoadBalancingConfig6}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend6}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck6}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck6)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck6)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck6)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck6}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck6}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck6}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls6}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext6)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext6}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


### GrpcBackendGroup {#GrpcBackendGroup3}

Field | Description
--- | ---
backends[] | **[GrpcBackend](#GrpcBackend3)**<br> 


### GrpcBackend {#GrpcBackend3}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig7)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend7)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck7)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls7)**<br>TLS settings for the upstream. 


### LoadBalancingConfig {#LoadBalancingConfig7}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend7}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck7}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck7)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck7)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck7)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck7}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck7}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck7}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls7}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext7)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext7}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


## Update {#Update}



**rpc Update ([UpdateBackendGroupRequest](#UpdateBackendGroupRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateBackendGroupMetadata](#UpdateBackendGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[BackendGroup](#BackendGroup3)<br>

### UpdateBackendGroupRequest {#UpdateBackendGroupRequest}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
name | **string**<br> Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br> The maximum string length in characters is 256.
labels | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackendGroup](#HttpBackendGroup4)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](#GrpcBackendGroup4)**<br> 


### HttpBackendGroup {#HttpBackendGroup4}

Field | Description
--- | ---
backends[] | **[HttpBackend](#HttpBackend4)**<br> 


### HttpBackend {#HttpBackend4}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig8)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend8)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck8)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls8)**<br>TLS settings for the upstream. 
use_http2 | **bool**<br>Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default. 


### LoadBalancingConfig {#LoadBalancingConfig8}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend8}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck8}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck8)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck8)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck8)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck8}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck8}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck8}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls8}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext8)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext8}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


### GrpcBackendGroup {#GrpcBackendGroup4}

Field | Description
--- | ---
backends[] | **[GrpcBackend](#GrpcBackend4)**<br> 


### GrpcBackend {#GrpcBackend4}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig9)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend9)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck9)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls9)**<br>TLS settings for the upstream. 


### LoadBalancingConfig {#LoadBalancingConfig9}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend9}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck9}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck9)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck9)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck9)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck9}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck9}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck9}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls9}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext9)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext9}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


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
backend_group_id | **string**<br> 


### BackendGroup {#BackendGroup3}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the backend group. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the backend group. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the backend group belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackendGroup](#HttpBackendGroup5)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](#GrpcBackendGroup5)**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the backend group. 


### HttpBackendGroup {#HttpBackendGroup5}

Field | Description
--- | ---
backends[] | **[HttpBackend](#HttpBackend5)**<br> 


### HttpBackend {#HttpBackend5}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig10)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend10)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck10)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls10)**<br>TLS settings for the upstream. 
use_http2 | **bool**<br>Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default. 


### LoadBalancingConfig {#LoadBalancingConfig10}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend10}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck10}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck10)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck10)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck10)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck10}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck10}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck10}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls10}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext10)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext10}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


### GrpcBackendGroup {#GrpcBackendGroup5}

Field | Description
--- | ---
backends[] | **[GrpcBackend](#GrpcBackend5)**<br> 


### GrpcBackend {#GrpcBackend5}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig11)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend11)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck11)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls11)**<br>TLS settings for the upstream. 


### LoadBalancingConfig {#LoadBalancingConfig11}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend11}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck11}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck11)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck11)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck11)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck11}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck11}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck11}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls11}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext11)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext11}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


## Delete {#Delete}



**rpc Delete ([DeleteBackendGroupRequest](#DeleteBackendGroupRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteBackendGroupMetadata](#DeleteBackendGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteBackendGroupRequest {#DeleteBackendGroupRequest}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


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
backend_group_id | **string**<br> 


## AddBackend {#AddBackend}

AddBackend/RemoveBackend technically do the same, but have different semantics.

**rpc AddBackend ([AddBackendRequest](#AddBackendRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddBackendMetadata](#AddBackendMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[BackendGroup](#BackendGroup4)<br>

### AddBackendRequest {#AddBackendRequest}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackend](#HttpBackend6)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackend](#GrpcBackend6)**<br> 


### HttpBackend {#HttpBackend6}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig12)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend12)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck12)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls12)**<br>TLS settings for the upstream. 
use_http2 | **bool**<br>Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default. 


### LoadBalancingConfig {#LoadBalancingConfig12}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend12}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck12}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck12)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck12)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck12)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck12}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck12}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck12}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls12}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext12)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext12}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


### GrpcBackend {#GrpcBackend6}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig13)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend13)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck13)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls13)**<br>TLS settings for the upstream. 


### LoadBalancingConfig {#LoadBalancingConfig13}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend13}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck13}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck13)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck13)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck13)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck13}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck13}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck13}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls13}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext13)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext13}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


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
backend_group_id | **string**<br> 
backend_name | **string**<br> 


### BackendGroup {#BackendGroup4}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the backend group. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the backend group. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the backend group belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackendGroup](#HttpBackendGroup6)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](#GrpcBackendGroup6)**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the backend group. 


### HttpBackendGroup {#HttpBackendGroup6}

Field | Description
--- | ---
backends[] | **[HttpBackend](#HttpBackend7)**<br> 


### HttpBackend {#HttpBackend7}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig14)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend14)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck14)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls14)**<br>TLS settings for the upstream. 
use_http2 | **bool**<br>Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default. 


### LoadBalancingConfig {#LoadBalancingConfig14}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend14}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck14}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck14)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck14)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck14)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck14}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck14}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck14}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls14}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext14)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext14}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


### GrpcBackendGroup {#GrpcBackendGroup6}

Field | Description
--- | ---
backends[] | **[GrpcBackend](#GrpcBackend7)**<br> 


### GrpcBackend {#GrpcBackend7}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig15)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend15)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck15)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls15)**<br>TLS settings for the upstream. 


### LoadBalancingConfig {#LoadBalancingConfig15}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend15}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck15}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck15)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck15)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck15)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck15}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck15}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck15}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls15}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext15)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext15}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


## RemoveBackend {#RemoveBackend}



**rpc RemoveBackend ([RemoveBackendRequest](#RemoveBackendRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveBackendMetadata](#RemoveBackendMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[BackendGroup](#BackendGroup5)<br>

### RemoveBackendRequest {#RemoveBackendRequest}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  
backend_name | **string**<br>Required.  


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
backend_group_id | **string**<br> 
backend_name | **string**<br> 


### BackendGroup {#BackendGroup5}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the backend group. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the backend group. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the backend group belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackendGroup](#HttpBackendGroup7)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](#GrpcBackendGroup7)**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the backend group. 


### HttpBackendGroup {#HttpBackendGroup7}

Field | Description
--- | ---
backends[] | **[HttpBackend](#HttpBackend8)**<br> 


### HttpBackend {#HttpBackend8}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig16)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend16)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck16)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls16)**<br>TLS settings for the upstream. 
use_http2 | **bool**<br>Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default. 


### LoadBalancingConfig {#LoadBalancingConfig16}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend16}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck16}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck16)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck16)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck16)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck16}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck16}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck16}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls16}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext16)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext16}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


### GrpcBackendGroup {#GrpcBackendGroup7}

Field | Description
--- | ---
backends[] | **[GrpcBackend](#GrpcBackend8)**<br> 


### GrpcBackend {#GrpcBackend8}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig17)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend17)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck17)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls17)**<br>TLS settings for the upstream. 


### LoadBalancingConfig {#LoadBalancingConfig17}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend17}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck17}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck17)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck17)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck17)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck17}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck17}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck17}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls17}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext17)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext17}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


## UpdateBackend {#UpdateBackend}



**rpc UpdateBackend ([UpdateBackendRequest](#UpdateBackendRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateBackendMetadata](#UpdateBackendMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[BackendGroup](#BackendGroup6)<br>

### UpdateBackendRequest {#UpdateBackendRequest}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackend](#HttpBackend9)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackend](#GrpcBackend9)**<br> 


### HttpBackend {#HttpBackend9}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig18)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend18)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck18)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls18)**<br>TLS settings for the upstream. 
use_http2 | **bool**<br>Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default. 


### LoadBalancingConfig {#LoadBalancingConfig18}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend18}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck18}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck18)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck18)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck18)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck18}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck18}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck18}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls18}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext18)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext18}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


### GrpcBackend {#GrpcBackend9}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig19)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend19)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck19)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls19)**<br>TLS settings for the upstream. 


### LoadBalancingConfig {#LoadBalancingConfig19}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend19}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck19}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck19)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck19)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck19)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck19}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck19}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck19}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls19}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext19)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext19}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


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
backend_group_id | **string**<br> 
backend_name | **string**<br> 


### BackendGroup {#BackendGroup6}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the backend group. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the backend group. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the backend group belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackendGroup](#HttpBackendGroup8)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](#GrpcBackendGroup8)**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the backend group. 


### HttpBackendGroup {#HttpBackendGroup8}

Field | Description
--- | ---
backends[] | **[HttpBackend](#HttpBackend10)**<br> 


### HttpBackend {#HttpBackend10}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig20)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend20)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck20)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls20)**<br>TLS settings for the upstream. 
use_http2 | **bool**<br>Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default. 


### LoadBalancingConfig {#LoadBalancingConfig20}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend20}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck20}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck20)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck20)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck20)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck20}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck20}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck20}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls20}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext20)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext20}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


### GrpcBackendGroup {#GrpcBackendGroup8}

Field | Description
--- | ---
backends[] | **[GrpcBackend](#GrpcBackend10)**<br> 


### GrpcBackend {#GrpcBackend10}

Field | Description
--- | ---
name | **string**<br>Required. Name. 
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If set to zero, backend will be disabled. If not set in all backends, they all will have equal weights. Must either set or unset in all backeds of the group. 
load_balancing_config | **[LoadBalancingConfig](#LoadBalancingConfig21)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](#TargetGroupsBackend21)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](#HealthCheck21)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](#BackendTls21)**<br>TLS settings for the upstream. 


### LoadBalancingConfig {#LoadBalancingConfig21}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.
strict_locality | **bool**<br>If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones. 


### TargetGroupsBackend {#TargetGroupsBackend21}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck21}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. 
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. 
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](#StreamHealthCheck21)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](#HttpHealthCheck21)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](#GrpcHealthCheck21)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck21}

Field | Description
--- | ---
send | **[Payload](#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck21}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. 
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck21}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls21}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
validation_context | **[ValidationContext](#ValidationContext21)**<br>Validation context for backend TLS connections. 


### ValidationContext {#ValidationContext21}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


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
operations[] | **[operation.Operation](#Operation6)**<br>List of operations for the specified target group. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListBackendGroupOperationsRequest.page_size](#ListBackendGroupOperationsRequest), use the `next_page_token` as the value for the [ListBackendGroupOperationsRequest.page_token](#ListBackendGroupOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


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



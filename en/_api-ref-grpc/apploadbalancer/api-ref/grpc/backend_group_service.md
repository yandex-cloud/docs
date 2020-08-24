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



**rpc Get ([GetBackendGroupRequest](#GetBackendGroupRequest)) returns ([BackendGroup](../backend_group.proto#BackendGroup))**

### GetBackendGroupRequest {#GetBackendGroupRequest}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  false


### BackendGroup {#BackendGroup}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the backend group. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the backend group. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the backend group belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackendGroup](../backend_group.proto#HttpBackendGroup)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](../backend_group.proto#GrpcBackendGroup)**<br> 


### HttpBackendGroup {#HttpBackendGroup}

Field | Description
--- | ---
backends[] | **[HttpBackend](../backend_group.proto#HttpBackend)**<br> 


### HttpBackend {#HttpBackend}

Field | Description
--- | ---
name | **string**<br>Required. Name. false
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If not set, backend will be disabled. 
load_balancing_config | **[LoadBalancingConfig](../backend_group.proto#LoadBalancingConfig)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](../backend_group.proto#TargetGroupsBackend)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](../backend_group.proto#HealthCheck)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](../backend_group.proto#BackendTls)**<br>TLS settings for the upstream. 
use_http2 | **bool**<br>Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default. 


### LoadBalancingConfig {#LoadBalancingConfig}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.


### TargetGroupsBackend {#TargetGroupsBackend}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. false
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. false
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](../backend_group.proto#StreamHealthCheck)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](../backend_group.proto#HttpHealthCheck)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](../backend_group.proto#GrpcHealthCheck)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck}

Field | Description
--- | ---
send | **[Payload](../payload.proto#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](../payload.proto#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. false
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
tls_options | **[TlsOptions](../tls.proto#TlsOptions)**<br>Common TLS options used for backend TLS connections. 
validation_context | **[ValidationContext](../tls.proto#ValidationContext)**<br>Validation context for backend TLS connections. 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### ValidationContext {#ValidationContext}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


### GrpcBackendGroup {#GrpcBackendGroup}

Field | Description
--- | ---
backends[] | **[GrpcBackend](../backend_group.proto#GrpcBackend)**<br> 


### GrpcBackend {#GrpcBackend}

Field | Description
--- | ---
name | **string**<br>Required. Name. false
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If not set, backend will be disabled. 
load_balancing_config | **[LoadBalancingConfig](../backend_group.proto#LoadBalancingConfig1)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](../backend_group.proto#TargetGroupsBackend1)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](../backend_group.proto#HealthCheck1)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](../backend_group.proto#BackendTls1)**<br>TLS settings for the upstream. 


### LoadBalancingConfig {#LoadBalancingConfig}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.


### TargetGroupsBackend {#TargetGroupsBackend}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. false
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. false
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](../backend_group.proto#StreamHealthCheck1)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](../backend_group.proto#HttpHealthCheck1)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](../backend_group.proto#GrpcHealthCheck1)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck}

Field | Description
--- | ---
send | **[Payload](../payload.proto#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](../payload.proto#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. false
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
tls_options | **[TlsOptions](../tls.proto#TlsOptions1)**<br>Common TLS options used for backend TLS connections. 
validation_context | **[ValidationContext](../tls.proto#ValidationContext1)**<br>Validation context for backend TLS connections. 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### ValidationContext {#ValidationContext}

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
folder_id | **string**<br>Required.  false
page_size | **int64**<br> Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br> The maximum string length in characters is 100.
filter | **string**<br> The maximum string length in characters is 1000.


### ListBackendGroupsResponse {#ListBackendGroupsResponse}

Field | Description
--- | ---
backend_groups[] | **[BackendGroup](../backend_group.proto#BackendGroup1)**<br> 
next_page_token | **string**<br> 


### BackendGroup {#BackendGroup}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the backend group. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the backend group. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the backend group belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackendGroup](../backend_group.proto#HttpBackendGroup1)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](../backend_group.proto#GrpcBackendGroup1)**<br> 


### HttpBackendGroup {#HttpBackendGroup}

Field | Description
--- | ---
backends[] | **[HttpBackend](../backend_group.proto#HttpBackend1)**<br> 


### HttpBackend {#HttpBackend}

Field | Description
--- | ---
name | **string**<br>Required. Name. false
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If not set, backend will be disabled. 
load_balancing_config | **[LoadBalancingConfig](../backend_group.proto#LoadBalancingConfig2)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](../backend_group.proto#TargetGroupsBackend2)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](../backend_group.proto#HealthCheck2)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](../backend_group.proto#BackendTls2)**<br>TLS settings for the upstream. 
use_http2 | **bool**<br>Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default. 


### LoadBalancingConfig {#LoadBalancingConfig}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.


### TargetGroupsBackend {#TargetGroupsBackend}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. false
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. false
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](../backend_group.proto#StreamHealthCheck2)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](../backend_group.proto#HttpHealthCheck2)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](../backend_group.proto#GrpcHealthCheck2)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck}

Field | Description
--- | ---
send | **[Payload](../payload.proto#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](../payload.proto#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. false
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
tls_options | **[TlsOptions](../tls.proto#TlsOptions2)**<br>Common TLS options used for backend TLS connections. 
validation_context | **[ValidationContext](../tls.proto#ValidationContext2)**<br>Validation context for backend TLS connections. 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### ValidationContext {#ValidationContext}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


### GrpcBackendGroup {#GrpcBackendGroup}

Field | Description
--- | ---
backends[] | **[GrpcBackend](../backend_group.proto#GrpcBackend1)**<br> 


### GrpcBackend {#GrpcBackend}

Field | Description
--- | ---
name | **string**<br>Required. Name. false
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If not set, backend will be disabled. 
load_balancing_config | **[LoadBalancingConfig](../backend_group.proto#LoadBalancingConfig3)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](../backend_group.proto#TargetGroupsBackend3)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](../backend_group.proto#HealthCheck3)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](../backend_group.proto#BackendTls3)**<br>TLS settings for the upstream. 


### LoadBalancingConfig {#LoadBalancingConfig}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.


### TargetGroupsBackend {#TargetGroupsBackend}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. false
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. false
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](../backend_group.proto#StreamHealthCheck3)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](../backend_group.proto#HttpHealthCheck3)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](../backend_group.proto#GrpcHealthCheck3)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck}

Field | Description
--- | ---
send | **[Payload](../payload.proto#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](../payload.proto#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. false
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
tls_options | **[TlsOptions](../tls.proto#TlsOptions3)**<br>Common TLS options used for backend TLS connections. 
validation_context | **[ValidationContext](../tls.proto#ValidationContext3)**<br>Validation context for backend TLS connections. 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### ValidationContext {#ValidationContext}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


## Create {#Create}



**rpc Create ([CreateBackendGroupRequest](#CreateBackendGroupRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateBackendGroupMetadata](#CreateBackendGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[BackendGroup](../backend_group.proto#BackendGroup2)<br>

### CreateBackendGroupRequest {#CreateBackendGroupRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required.  false
name | **string**<br> Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br> The maximum string length in characters is 256.
labels | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackendGroup](../backend_group.proto#HttpBackendGroup2)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](../backend_group.proto#GrpcBackendGroup2)**<br> 


### HttpBackendGroup {#HttpBackendGroup}

Field | Description
--- | ---
backends[] | **[HttpBackend](../backend_group.proto#HttpBackend2)**<br> 


### HttpBackend {#HttpBackend}

Field | Description
--- | ---
name | **string**<br>Required. Name. false
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If not set, backend will be disabled. 
load_balancing_config | **[LoadBalancingConfig](../backend_group.proto#LoadBalancingConfig4)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](../backend_group.proto#TargetGroupsBackend4)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](../backend_group.proto#HealthCheck4)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](../backend_group.proto#BackendTls4)**<br>TLS settings for the upstream. 
use_http2 | **bool**<br>Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default. 


### LoadBalancingConfig {#LoadBalancingConfig}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.


### TargetGroupsBackend {#TargetGroupsBackend}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. false
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. false
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](../backend_group.proto#StreamHealthCheck4)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](../backend_group.proto#HttpHealthCheck4)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](../backend_group.proto#GrpcHealthCheck4)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck}

Field | Description
--- | ---
send | **[Payload](../payload.proto#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](../payload.proto#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. false
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
tls_options | **[TlsOptions](../tls.proto#TlsOptions4)**<br>Common TLS options used for backend TLS connections. 
validation_context | **[ValidationContext](../tls.proto#ValidationContext4)**<br>Validation context for backend TLS connections. 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### ValidationContext {#ValidationContext}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


### GrpcBackendGroup {#GrpcBackendGroup}

Field | Description
--- | ---
backends[] | **[GrpcBackend](../backend_group.proto#GrpcBackend2)**<br> 


### GrpcBackend {#GrpcBackend}

Field | Description
--- | ---
name | **string**<br>Required. Name. false
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If not set, backend will be disabled. 
load_balancing_config | **[LoadBalancingConfig](../backend_group.proto#LoadBalancingConfig5)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](../backend_group.proto#TargetGroupsBackend5)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](../backend_group.proto#HealthCheck5)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](../backend_group.proto#BackendTls5)**<br>TLS settings for the upstream. 


### LoadBalancingConfig {#LoadBalancingConfig}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.


### TargetGroupsBackend {#TargetGroupsBackend}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. false
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. false
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](../backend_group.proto#StreamHealthCheck5)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](../backend_group.proto#HttpHealthCheck5)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](../backend_group.proto#GrpcHealthCheck5)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck}

Field | Description
--- | ---
send | **[Payload](../payload.proto#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](../payload.proto#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. false
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
tls_options | **[TlsOptions](../tls.proto#TlsOptions5)**<br>Common TLS options used for backend TLS connections. 
validation_context | **[ValidationContext](../tls.proto#ValidationContext5)**<br>Validation context for backend TLS connections. 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### ValidationContext {#ValidationContext}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[BackendGroup](../backend_group.proto#BackendGroup2)>**<br>if operation finished successfully. 


### CreateBackendGroupMetadata {#CreateBackendGroupMetadata}

Field | Description
--- | ---
backend_group_id | **string**<br> 


### BackendGroup {#BackendGroup}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the backend group. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the backend group. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the backend group belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackendGroup](../backend_group.proto#HttpBackendGroup3)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](../backend_group.proto#GrpcBackendGroup3)**<br> 


## Update {#Update}



**rpc Update ([UpdateBackendGroupRequest](#UpdateBackendGroupRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateBackendGroupMetadata](#UpdateBackendGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[BackendGroup](../backend_group.proto#BackendGroup3)<br>

### UpdateBackendGroupRequest {#UpdateBackendGroupRequest}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  false
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
name | **string**<br> Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br> The maximum string length in characters is 256.
labels | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackendGroup](../backend_group.proto#HttpBackendGroup3)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](../backend_group.proto#GrpcBackendGroup3)**<br> 


### HttpBackendGroup {#HttpBackendGroup}

Field | Description
--- | ---
backends[] | **[HttpBackend](../backend_group.proto#HttpBackend3)**<br> 


### HttpBackend {#HttpBackend}

Field | Description
--- | ---
name | **string**<br>Required. Name. false
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If not set, backend will be disabled. 
load_balancing_config | **[LoadBalancingConfig](../backend_group.proto#LoadBalancingConfig6)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](../backend_group.proto#TargetGroupsBackend6)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](../backend_group.proto#HealthCheck6)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](../backend_group.proto#BackendTls6)**<br>TLS settings for the upstream. 
use_http2 | **bool**<br>Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default. 


### LoadBalancingConfig {#LoadBalancingConfig}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.


### TargetGroupsBackend {#TargetGroupsBackend}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. false
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. false
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](../backend_group.proto#StreamHealthCheck6)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](../backend_group.proto#HttpHealthCheck6)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](../backend_group.proto#GrpcHealthCheck6)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck}

Field | Description
--- | ---
send | **[Payload](../payload.proto#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](../payload.proto#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. false
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
tls_options | **[TlsOptions](../tls.proto#TlsOptions6)**<br>Common TLS options used for backend TLS connections. 
validation_context | **[ValidationContext](../tls.proto#ValidationContext6)**<br>Validation context for backend TLS connections. 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### ValidationContext {#ValidationContext}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


### GrpcBackendGroup {#GrpcBackendGroup}

Field | Description
--- | ---
backends[] | **[GrpcBackend](../backend_group.proto#GrpcBackend3)**<br> 


### GrpcBackend {#GrpcBackend}

Field | Description
--- | ---
name | **string**<br>Required. Name. false
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If not set, backend will be disabled. 
load_balancing_config | **[LoadBalancingConfig](../backend_group.proto#LoadBalancingConfig7)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](../backend_group.proto#TargetGroupsBackend7)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](../backend_group.proto#HealthCheck7)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](../backend_group.proto#BackendTls7)**<br>TLS settings for the upstream. 


### LoadBalancingConfig {#LoadBalancingConfig}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.


### TargetGroupsBackend {#TargetGroupsBackend}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. false
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. false
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](../backend_group.proto#StreamHealthCheck7)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](../backend_group.proto#HttpHealthCheck7)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](../backend_group.proto#GrpcHealthCheck7)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck}

Field | Description
--- | ---
send | **[Payload](../payload.proto#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](../payload.proto#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. false
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
tls_options | **[TlsOptions](../tls.proto#TlsOptions7)**<br>Common TLS options used for backend TLS connections. 
validation_context | **[ValidationContext](../tls.proto#ValidationContext7)**<br>Validation context for backend TLS connections. 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### ValidationContext {#ValidationContext}

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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateBackendGroupMetadata](#UpdateBackendGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[BackendGroup](../backend_group.proto#BackendGroup3)>**<br>if operation finished successfully. 


### UpdateBackendGroupMetadata {#UpdateBackendGroupMetadata}

Field | Description
--- | ---
backend_group_id | **string**<br> 


### BackendGroup {#BackendGroup}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the backend group. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the backend group. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the backend group belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackendGroup](../backend_group.proto#HttpBackendGroup4)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](../backend_group.proto#GrpcBackendGroup4)**<br> 


## Delete {#Delete}



**rpc Delete ([DeleteBackendGroupRequest](#DeleteBackendGroupRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteBackendGroupMetadata](#DeleteBackendGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteBackendGroupRequest {#DeleteBackendGroupRequest}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  false


### Operation {#Operation}

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
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[BackendGroup](../backend_group.proto#BackendGroup4)<br>

### AddBackendRequest {#AddBackendRequest}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  false
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackend](../backend_group.proto#HttpBackend4)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackend](../backend_group.proto#GrpcBackend4)**<br> 


### HttpBackend {#HttpBackend}

Field | Description
--- | ---
name | **string**<br>Required. Name. false
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If not set, backend will be disabled. 
load_balancing_config | **[LoadBalancingConfig](../backend_group.proto#LoadBalancingConfig8)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](../backend_group.proto#TargetGroupsBackend8)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](../backend_group.proto#HealthCheck8)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](../backend_group.proto#BackendTls8)**<br>TLS settings for the upstream. 
use_http2 | **bool**<br>Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default. 


### LoadBalancingConfig {#LoadBalancingConfig}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.


### TargetGroupsBackend {#TargetGroupsBackend}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. false
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. false
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](../backend_group.proto#StreamHealthCheck8)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](../backend_group.proto#HttpHealthCheck8)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](../backend_group.proto#GrpcHealthCheck8)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck}

Field | Description
--- | ---
send | **[Payload](../payload.proto#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](../payload.proto#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. false
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
tls_options | **[TlsOptions](../tls.proto#TlsOptions8)**<br>Common TLS options used for backend TLS connections. 
validation_context | **[ValidationContext](../tls.proto#ValidationContext8)**<br>Validation context for backend TLS connections. 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### ValidationContext {#ValidationContext}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


### GrpcBackend {#GrpcBackend}

Field | Description
--- | ---
name | **string**<br>Required. Name. false
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If not set, backend will be disabled. 
load_balancing_config | **[LoadBalancingConfig](../backend_group.proto#LoadBalancingConfig9)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](../backend_group.proto#TargetGroupsBackend9)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](../backend_group.proto#HealthCheck9)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](../backend_group.proto#BackendTls9)**<br>TLS settings for the upstream. 


### LoadBalancingConfig {#LoadBalancingConfig}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.


### TargetGroupsBackend {#TargetGroupsBackend}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. false
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. false
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](../backend_group.proto#StreamHealthCheck9)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](../backend_group.proto#HttpHealthCheck9)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](../backend_group.proto#GrpcHealthCheck9)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck}

Field | Description
--- | ---
send | **[Payload](../payload.proto#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](../payload.proto#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. false
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
tls_options | **[TlsOptions](../tls.proto#TlsOptions9)**<br>Common TLS options used for backend TLS connections. 
validation_context | **[ValidationContext](../tls.proto#ValidationContext9)**<br>Validation context for backend TLS connections. 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### ValidationContext {#ValidationContext}

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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddBackendMetadata](#AddBackendMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[BackendGroup](../backend_group.proto#BackendGroup4)>**<br>if operation finished successfully. 


### AddBackendMetadata {#AddBackendMetadata}

Field | Description
--- | ---
backend_group_id | **string**<br> 
backend_name | **string**<br> 


### BackendGroup {#BackendGroup}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the backend group. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the backend group. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the backend group belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackendGroup](../backend_group.proto#HttpBackendGroup4)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](../backend_group.proto#GrpcBackendGroup4)**<br> 


## RemoveBackend {#RemoveBackend}



**rpc RemoveBackend ([RemoveBackendRequest](#RemoveBackendRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveBackendMetadata](#RemoveBackendMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[BackendGroup](../backend_group.proto#BackendGroup5)<br>

### RemoveBackendRequest {#RemoveBackendRequest}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  false
backend_name | **string**<br>Required.  false


### Operation {#Operation}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[BackendGroup](../backend_group.proto#BackendGroup5)>**<br>if operation finished successfully. 


### RemoveBackendMetadata {#RemoveBackendMetadata}

Field | Description
--- | ---
backend_group_id | **string**<br> 
backend_name | **string**<br> 


### BackendGroup {#BackendGroup}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the backend group. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the backend group. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the backend group belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackendGroup](../backend_group.proto#HttpBackendGroup4)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](../backend_group.proto#GrpcBackendGroup4)**<br> 


## UpdateBackend {#UpdateBackend}



**rpc UpdateBackend ([UpdateBackendRequest](#UpdateBackendRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateBackendMetadata](#UpdateBackendMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[BackendGroup](../backend_group.proto#BackendGroup6)<br>

### UpdateBackendRequest {#UpdateBackendRequest}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  false
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackend](../backend_group.proto#HttpBackend5)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackend](../backend_group.proto#GrpcBackend5)**<br> 


### HttpBackend {#HttpBackend}

Field | Description
--- | ---
name | **string**<br>Required. Name. false
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If not set, backend will be disabled. 
load_balancing_config | **[LoadBalancingConfig](../backend_group.proto#LoadBalancingConfig10)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](../backend_group.proto#TargetGroupsBackend10)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](../backend_group.proto#HealthCheck10)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](../backend_group.proto#BackendTls10)**<br>TLS settings for the upstream. 
use_http2 | **bool**<br>Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default. 


### LoadBalancingConfig {#LoadBalancingConfig}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.


### TargetGroupsBackend {#TargetGroupsBackend}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. false
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. false
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](../backend_group.proto#StreamHealthCheck10)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](../backend_group.proto#HttpHealthCheck10)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](../backend_group.proto#GrpcHealthCheck10)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck}

Field | Description
--- | ---
send | **[Payload](../payload.proto#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](../payload.proto#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. false
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
tls_options | **[TlsOptions](../tls.proto#TlsOptions10)**<br>Common TLS options used for backend TLS connections. 
validation_context | **[ValidationContext](../tls.proto#ValidationContext10)**<br>Validation context for backend TLS connections. 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### ValidationContext {#ValidationContext}

Field | Description
--- | ---
trusted_ca | **oneof:** `trusted_ca_id` or `trusted_ca_bytes`<br>
&nbsp;&nbsp;trusted_ca_id | **string**<br>Trusted CA certificate ID in the Certificate Manager. 
&nbsp;&nbsp;trusted_ca_bytes | **string**<br>Trusted CA blob. 


### GrpcBackend {#GrpcBackend}

Field | Description
--- | ---
name | **string**<br>Required. Name. false
backend_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Traffic will be split between backends of the same BackendGroup according to their weights. If not set, backend will be disabled. 
load_balancing_config | **[LoadBalancingConfig](../backend_group.proto#LoadBalancingConfig11)**<br> 
port | **int64**<br>Port for all targets from target group. Acceptable values are 0 to 65535, inclusive.
backend_type | **oneof:** `target_groups`<br>
&nbsp;&nbsp;target_groups | **[TargetGroupsBackend](../backend_group.proto#TargetGroupsBackend11)**<br>References target groups for the backend. 
healthchecks[] | **[HealthCheck](../backend_group.proto#HealthCheck11)**<br>No health checks means no active health checking will be performed. 
tls | **[BackendTls](../backend_group.proto#BackendTls11)**<br>TLS settings for the upstream. 


### LoadBalancingConfig {#LoadBalancingConfig}

Field | Description
--- | ---
panic_threshold | **int64**<br>If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading  when everything is bad. zero means no panic threshold. Acceptable values are 0 to 100, inclusive.
locality_aware_routing_percent | **int64**<br>Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones. Acceptable values are 0 to 100, inclusive.


### TargetGroupsBackend {#TargetGroupsBackend}

Field | Description
--- | ---
target_group_ids[] | **string**<br> The number of elements must be greater than 0.


### HealthCheck {#HealthCheck}

Field | Description
--- | ---
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time to wait for a health check response. false
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Interval between health checks. false
interval_jitter_percent | **double**<br><ul><li> * interval_jitter_percent / 100) will be added to the wait time.</li></ul> 
healthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
unhealthy_threshold | **int64**<br><ul><li> 1. </li></ul> 
healthcheck_port | **int64**<br>Optional alternative port for health checking. Acceptable values are 0 to 65535, inclusive.
healthcheck | **oneof:** `stream`, `http` or `grpc`<br>TCP (+TLS) health check ("Stream protocol HC").
&nbsp;&nbsp;stream | **[StreamHealthCheck](../backend_group.proto#StreamHealthCheck11)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;http | **[HttpHealthCheck](../backend_group.proto#HttpHealthCheck11)**<br>TCP (+TLS) health check ("Stream protocol HC"). 
&nbsp;&nbsp;grpc | **[GrpcHealthCheck](../backend_group.proto#GrpcHealthCheck11)**<br>TCP (+TLS) health check ("Stream protocol HC"). 


### StreamHealthCheck {#StreamHealthCheck}

Field | Description
--- | ---
send | **[Payload](../payload.proto#Payload)**<br>Optional message to send. If empty, it's a connect-only health check. 
receive | **[Payload](../payload.proto#Payload)**<br>Optional text to search in reply. 


### HttpHealthCheck {#HttpHealthCheck}

Field | Description
--- | ---
host | **string**<br>Optional "Host" HTTP header value. 
path | **string**<br>Required. HTTP path. false
use_http2 | **bool**<br>If set, health checks will use HTTP/2. 


### GrpcHealthCheck {#GrpcHealthCheck}

Field | Description
--- | ---
service_name | **string**<br>Optional service name for grpc.health.v1.HealthCheckRequest message. 


### BackendTls {#BackendTls}

Field | Description
--- | ---
sni | **string**<br>SNI string for TLS connections. 
tls_options | **[TlsOptions](../tls.proto#TlsOptions11)**<br>Common TLS options used for backend TLS connections. 
validation_context | **[ValidationContext](../tls.proto#ValidationContext11)**<br>Validation context for backend TLS connections. 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### ValidationContext {#ValidationContext}

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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateBackendMetadata](#UpdateBackendMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[BackendGroup](../backend_group.proto#BackendGroup6)>**<br>if operation finished successfully. 


### UpdateBackendMetadata {#UpdateBackendMetadata}

Field | Description
--- | ---
backend_group_id | **string**<br> 
backend_name | **string**<br> 


### BackendGroup {#BackendGroup}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the backend group. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the backend group. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the backend group belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
backend | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpBackendGroup](../backend_group.proto#HttpBackendGroup4)**<br> 
&nbsp;&nbsp;grpc | **[GrpcBackendGroup](../backend_group.proto#GrpcBackendGroup4)**<br> 


## ListOperations {#ListOperations}

Lists operations for the specified backend group.

**rpc ListOperations ([ListBackendGroupOperationsRequest](#ListBackendGroupOperationsRequest)) returns ([ListBackendGroupOperationsResponse](#ListBackendGroupOperationsResponse))**

### ListBackendGroupOperationsRequest {#ListBackendGroupOperationsRequest}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. ID of the backend group to get operations for. <br>To get the backend group ID, use a [BackendGroupService.List](#List) request. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListBackendGroupOperationsResponse.next_page_token](#ListBackendGroupOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListBackendGroupOperationsResponse.next_page_token](#ListBackendGroupOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListBackendGroupOperationsResponse {#ListBackendGroupOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation6)**<br>List of operations for the specified target group. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListBackendGroupOperationsRequest.page_size](#ListBackendGroupOperationsRequest1), use the `next_page_token` as the value for the [ListBackendGroupOperationsRequest.page_token](#ListBackendGroupOperationsRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation}

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



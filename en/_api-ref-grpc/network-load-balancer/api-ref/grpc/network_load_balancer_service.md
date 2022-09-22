---
editable: false
---

# NetworkLoadBalancerService

A set of methods for managing NetworkLoadBalancer resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified NetworkLoadBalancer resource. |
| [List](#List) | Retrieves the list of NetworkLoadBalancer resources in the specified folder. |
| [Create](#Create) | Creates a network load balancer in the specified folder using the data specified in the request. |
| [Update](#Update) | Updates the specified network load balancer. |
| [Delete](#Delete) | Deletes the specified network load balancer. |
| [Start](#Start) | Starts load balancing and health checking with the specified network load balancer with specified settings. |
| [Stop](#Stop) | Stops load balancing and health checking with the specified network load balancer. |
| [AttachTargetGroup](#AttachTargetGroup) | Attaches a target group to the specified network load balancer. |
| [DetachTargetGroup](#DetachTargetGroup) | Detaches the target group from the specified network load balancer. |
| [GetTargetStates](#GetTargetStates) | Gets states of target resources in the attached target group. |
| [AddListener](#AddListener) | Adds a listener to the specified network load balancer. |
| [RemoveListener](#RemoveListener) | Removes the listener from the specified network load balancer. |
| [ListOperations](#ListOperations) | Lists operations for the specified network load balancer. |

## Calls NetworkLoadBalancerService {#calls}

## Get {#Get}

Returns the specified NetworkLoadBalancer resource. <br>Get the list of available NetworkLoadBalancer resources by making a [List](#List) request.

**rpc Get ([GetNetworkLoadBalancerRequest](#GetNetworkLoadBalancerRequest)) returns ([NetworkLoadBalancer](#NetworkLoadBalancer))**

### GetNetworkLoadBalancerRequest {#GetNetworkLoadBalancerRequest}

Field | Description
--- | ---
network_load_balancer_id | **string**<br>ID of the NetworkLoadBalancer resource to return. To get the network load balancer ID, use a [NetworkLoadBalancerService.List](#List) request. The maximum string length in characters is 50.


### NetworkLoadBalancer {#NetworkLoadBalancer}

Field | Description
--- | ---
id | **string**<br>ID of the network load balancer. 
folder_id | **string**<br>ID of the folder that the network load balancer belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the network load balancer. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Optional description of the network load balancer. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
region_id | **string**<br>ID of the region that the network load balancer belongs to. 
status | enum **Status**<br>Status of the network load balancer. <ul><li>`CREATING`: Network load balancer is being created.</li><li>`STARTING`: Network load balancer is being started.</li><li>`ACTIVE`: Network load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: Network load balancer is being stopped.</li><li>`STOPPED`: Network load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: Network load balancer is being deleted.</li><li>`INACTIVE`: The load balancer doesn't have any listeners or target groups, or attached target groups are empty. The load balancer doesn't perform any health checks or send traffic in this state.</li></ul>
type | enum **Type**<br>Type of the network load balancer. Only external network load balancers are available now. <ul><li>`EXTERNAL`: External network load balancer.</li><li>`INTERNAL`: Internal network load balancer.</li></ul>
session_affinity | enum **SessionAffinity**<br>Type of the session affinity. Only 5-tuple affinity is available now. <ul><li>`CLIENT_IP_PORT_PROTO`: 5-tuple affinity.</li></ul>
listeners[] | **[Listener](#Listener)**<br>List of listeners for the network load balancer. 
attached_target_groups[] | **[AttachedTargetGroup](#AttachedTargetGroup)**<br>List of target groups attached to the network load balancer. 


### Listener {#Listener}

Field | Description
--- | ---
name | **string**<br>Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. 
address | **string**<br>IP address for the listener. 
port | **int64**<br>Port. 
protocol | enum **Protocol**<br>Network protocol for incoming traffic. 
target_port | **int64**<br>Port of a target. 
subnet_id | **string**<br>ID of the subnet. 
ip_version | enum **IpVersion**<br>IP version of the external address. <ul><li>`IPV4`: IPv4</li><li>`IPV6`: IPv6</li></ul>


### AttachedTargetGroup {#AttachedTargetGroup}

Field | Description
--- | ---
target_group_id | **string**<br>Required. ID of the target group. The maximum string length in characters is 50.
health_checks[] | **[HealthCheck](#HealthCheck)**<br>A health check to perform on the target group. For now we accept only one health check per AttachedTargetGroup. The number of elemets must be exactly 1.


### HealthCheck {#HealthCheck}

Field | Description
--- | ---
name | **string**<br>Required. Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for a target to return a response for the health check. The default is 1 second. 
unhealthy_threshold | **int64**<br>Number of failed health checks before changing the status to `` UNHEALTHY ``. The default is 2. Acceptable values are 2 to 10, inclusive.
healthy_threshold | **int64**<br>Number of successful health checks required in order to set the `` HEALTHY `` status for the target. The default is 2. Acceptable values are 2 to 10, inclusive.
options | **oneof:** `tcp_options` or `http_options`<br>Protocol to use for the health check. Either TCP or HTTP.
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions)**<br>Options for TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions)**<br>Options for HTTP health check. 


### TcpOptions {#TcpOptions}

Field | Description
--- | ---
port | **int64**<br>Port to use for TCP health checks. Acceptable values are 1 to 65535, inclusive.


### HttpOptions {#HttpOptions}

Field | Description
--- | ---
port | **int64**<br>Port to use for HTTP health checks. Acceptable values are 1 to 65535, inclusive.
path | **string**<br>URL path to set for health checking requests for every target in the target group. For example `` /ping ``. The default path is `` / ``. 


## List {#List}

Retrieves the list of NetworkLoadBalancer resources in the specified folder.

**rpc List ([ListNetworkLoadBalancersRequest](#ListNetworkLoadBalancersRequest)) returns ([ListNetworkLoadBalancersResponse](#ListNetworkLoadBalancersResponse))**

### ListNetworkLoadBalancersRequest {#ListNetworkLoadBalancersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder that the network load balancer belongs to. To get the folder ID, use a [NetworkLoadBalancerService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [<ResponseMessage>.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListNetworkLoadBalancersResponse.next_page_token](#ListNetworkLoadBalancersResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can only filter by the [NetworkLoadBalancer.name](#NetworkLoadBalancer1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.</li></ol> The maximum string length in characters is 1000.


### ListNetworkLoadBalancersResponse {#ListNetworkLoadBalancersResponse}

Field | Description
--- | ---
network_load_balancers[] | **[NetworkLoadBalancer](#NetworkLoadBalancer1)**<br>List of NetworkLoadBalancer resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListNetworkLoadBalancersRequest.page_size](#ListNetworkLoadBalancersRequest), use the `next_page_token` as the value for the [ListNetworkLoadBalancersRequest.page_token](#ListNetworkLoadBalancersRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### NetworkLoadBalancer {#NetworkLoadBalancer1}

Field | Description
--- | ---
id | **string**<br>ID of the network load balancer. 
folder_id | **string**<br>ID of the folder that the network load balancer belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the network load balancer. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Optional description of the network load balancer. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
region_id | **string**<br>ID of the region that the network load balancer belongs to. 
status | enum **Status**<br>Status of the network load balancer. <ul><li>`CREATING`: Network load balancer is being created.</li><li>`STARTING`: Network load balancer is being started.</li><li>`ACTIVE`: Network load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: Network load balancer is being stopped.</li><li>`STOPPED`: Network load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: Network load balancer is being deleted.</li><li>`INACTIVE`: The load balancer doesn't have any listeners or target groups, or attached target groups are empty. The load balancer doesn't perform any health checks or send traffic in this state.</li></ul>
type | enum **Type**<br>Type of the network load balancer. Only external network load balancers are available now. <ul><li>`EXTERNAL`: External network load balancer.</li><li>`INTERNAL`: Internal network load balancer.</li></ul>
session_affinity | enum **SessionAffinity**<br>Type of the session affinity. Only 5-tuple affinity is available now. <ul><li>`CLIENT_IP_PORT_PROTO`: 5-tuple affinity.</li></ul>
listeners[] | **[Listener](#Listener1)**<br>List of listeners for the network load balancer. 
attached_target_groups[] | **[AttachedTargetGroup](#AttachedTargetGroup1)**<br>List of target groups attached to the network load balancer. 


### Listener {#Listener1}

Field | Description
--- | ---
name | **string**<br>Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. 
address | **string**<br>IP address for the listener. 
port | **int64**<br>Port. 
protocol | enum **Protocol**<br>Network protocol for incoming traffic. 
target_port | **int64**<br>Port of a target. 
subnet_id | **string**<br>ID of the subnet. 
ip_version | enum **IpVersion**<br>IP version of the external address. <ul><li>`IPV4`: IPv4</li><li>`IPV6`: IPv6</li></ul>


### AttachedTargetGroup {#AttachedTargetGroup1}

Field | Description
--- | ---
target_group_id | **string**<br>Required. ID of the target group. The maximum string length in characters is 50.
health_checks[] | **[HealthCheck](#HealthCheck1)**<br>A health check to perform on the target group. For now we accept only one health check per AttachedTargetGroup. The number of elemets must be exactly 1.


### HealthCheck {#HealthCheck1}

Field | Description
--- | ---
name | **string**<br>Required. Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for a target to return a response for the health check. The default is 1 second. 
unhealthy_threshold | **int64**<br>Number of failed health checks before changing the status to `` UNHEALTHY ``. The default is 2. Acceptable values are 2 to 10, inclusive.
healthy_threshold | **int64**<br>Number of successful health checks required in order to set the `` HEALTHY `` status for the target. The default is 2. Acceptable values are 2 to 10, inclusive.
options | **oneof:** `tcp_options` or `http_options`<br>Protocol to use for the health check. Either TCP or HTTP.
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions1)**<br>Options for TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions1)**<br>Options for HTTP health check. 


### TcpOptions {#TcpOptions1}

Field | Description
--- | ---
port | **int64**<br>Port to use for TCP health checks. Acceptable values are 1 to 65535, inclusive.


### HttpOptions {#HttpOptions1}

Field | Description
--- | ---
port | **int64**<br>Port to use for HTTP health checks. Acceptable values are 1 to 65535, inclusive.
path | **string**<br>URL path to set for health checking requests for every target in the target group. For example `` /ping ``. The default path is `` / ``. 


## Create {#Create}

Creates a network load balancer in the specified folder using the data specified in the request.

**rpc Create ([CreateNetworkLoadBalancerRequest](#CreateNetworkLoadBalancerRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateNetworkLoadBalancerMetadata](#CreateNetworkLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[NetworkLoadBalancer](#NetworkLoadBalancer2)<br>

### CreateNetworkLoadBalancerRequest {#CreateNetworkLoadBalancerRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a network load balancer in. To get the folder ID, use a [NetworkLoadBalancerService.List](#List) request. The maximum string length in characters is 50.
name | **string**<br>Name of the network load balancer. The name must be unique within the folder. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the network load balancer. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
region_id | **string**<br>ID of the region where the network load balancer resides. The maximum string length in characters is 50.
type | **[NetworkLoadBalancer.Type](#NetworkLoadBalancer2)**<br>Required. Type of the network load balancer. Only external network load balancers are currently available. 
listener_specs[] | **[ListenerSpec](#ListenerSpec)**<br>List of listeners and their specs for the network load balancer. The maximum number of elements is 1000.
attached_target_groups[] | **[AttachedTargetGroup](#AttachedTargetGroup2)**<br>List of attached target groups for the network load balancer. The maximum number of elements is 1000.


### ListenerSpec {#ListenerSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
port | **int64**<br>Port for incoming traffic. Acceptable values are 1 to 65535, inclusive.
protocol | **[Listener.Protocol](#Listener2)**<br>Required. Protocol for incoming traffic. 
address | **oneof:** `external_address_spec` or `internal_address_spec`<br>IP address for incoming traffic. Either the ID of the previously created address or the address specification.
&nbsp;&nbsp;external_address_spec | **[ExternalAddressSpec](#ExternalAddressSpec)**<br>External IP address specification. 
&nbsp;&nbsp;internal_address_spec | **[InternalAddressSpec](#InternalAddressSpec)**<br>Internal IP address specification. 
target_port | **int64**<br>Port of a target. Acceptable values are 1 to 65535, inclusive. 


### ExternalAddressSpec {#ExternalAddressSpec}

Field | Description
--- | ---
address | **string**<br>Public IP address for a listener. If you provide a static public IP address for the [NetworkLoadBalancerService.Update](#Update) method, it will replace the existing listener address. 
ip_version | enum **IpVersion**<br>IP version. <ul><li>`IPV4`: IPv4</li><li>`IPV6`: IPv6</li></ul>


### InternalAddressSpec {#InternalAddressSpec}

Field | Description
--- | ---
address | **string**<br>Internal IP address for a listener. 
subnet_id | **string**<br>ID of the subnet. 
ip_version | enum **IpVersion**<br>IP version. <ul><li>`IPV4`: IPv4</li><li>`IPV6`: IPv6</li></ul>


### AttachedTargetGroup {#AttachedTargetGroup2}

Field | Description
--- | ---
target_group_id | **string**<br>Required. ID of the target group. The maximum string length in characters is 50.
health_checks[] | **[HealthCheck](#HealthCheck2)**<br>A health check to perform on the target group. For now we accept only one health check per AttachedTargetGroup. The number of elemets must be exactly 1.


### HealthCheck {#HealthCheck2}

Field | Description
--- | ---
name | **string**<br>Required. Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for a target to return a response for the health check. The default is 1 second. 
unhealthy_threshold | **int64**<br>Number of failed health checks before changing the status to `` UNHEALTHY ``. The default is 2. Acceptable values are 2 to 10, inclusive.
healthy_threshold | **int64**<br>Number of successful health checks required in order to set the `` HEALTHY `` status for the target. The default is 2. Acceptable values are 2 to 10, inclusive.
options | **oneof:** `tcp_options` or `http_options`<br>Protocol to use for the health check. Either TCP or HTTP.
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions2)**<br>Options for TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions2)**<br>Options for HTTP health check. 


### TcpOptions {#TcpOptions2}

Field | Description
--- | ---
port | **int64**<br>Port to use for TCP health checks. Acceptable values are 1 to 65535, inclusive.


### HttpOptions {#HttpOptions2}

Field | Description
--- | ---
port | **int64**<br>Port to use for HTTP health checks. Acceptable values are 1 to 65535, inclusive.
path | **string**<br>URL path to set for health checking requests for every target in the target group. For example `` /ping ``. The default path is `` / ``. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateNetworkLoadBalancerMetadata](#CreateNetworkLoadBalancerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[NetworkLoadBalancer](#NetworkLoadBalancer2)>**<br>if operation finished successfully. 


### CreateNetworkLoadBalancerMetadata {#CreateNetworkLoadBalancerMetadata}

Field | Description
--- | ---
network_load_balancer_id | **string**<br>ID of the network load balancer that is being created. 


### NetworkLoadBalancer {#NetworkLoadBalancer2}

Field | Description
--- | ---
id | **string**<br>ID of the network load balancer. 
folder_id | **string**<br>ID of the folder that the network load balancer belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the network load balancer. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Optional description of the network load balancer. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
region_id | **string**<br>ID of the region that the network load balancer belongs to. 
status | enum **Status**<br>Status of the network load balancer. <ul><li>`CREATING`: Network load balancer is being created.</li><li>`STARTING`: Network load balancer is being started.</li><li>`ACTIVE`: Network load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: Network load balancer is being stopped.</li><li>`STOPPED`: Network load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: Network load balancer is being deleted.</li><li>`INACTIVE`: The load balancer doesn't have any listeners or target groups, or attached target groups are empty. The load balancer doesn't perform any health checks or send traffic in this state.</li></ul>
type | enum **Type**<br>Type of the network load balancer. Only external network load balancers are available now. <ul><li>`EXTERNAL`: External network load balancer.</li><li>`INTERNAL`: Internal network load balancer.</li></ul>
session_affinity | enum **SessionAffinity**<br>Type of the session affinity. Only 5-tuple affinity is available now. <ul><li>`CLIENT_IP_PORT_PROTO`: 5-tuple affinity.</li></ul>
listeners[] | **[Listener](#Listener2)**<br>List of listeners for the network load balancer. 
attached_target_groups[] | **[AttachedTargetGroup](#AttachedTargetGroup3)**<br>List of target groups attached to the network load balancer. 


### Listener {#Listener2}

Field | Description
--- | ---
name | **string**<br>Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. 
address | **string**<br>IP address for the listener. 
port | **int64**<br>Port. 
protocol | enum **Protocol**<br>Network protocol for incoming traffic. 
target_port | **int64**<br>Port of a target. 
subnet_id | **string**<br>ID of the subnet. 
ip_version | enum **IpVersion**<br>IP version of the external address. <ul><li>`IPV4`: IPv4</li><li>`IPV6`: IPv6</li></ul>


## Update {#Update}

Updates the specified network load balancer.

**rpc Update ([UpdateNetworkLoadBalancerRequest](#UpdateNetworkLoadBalancerRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateNetworkLoadBalancerMetadata](#UpdateNetworkLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[NetworkLoadBalancer](#NetworkLoadBalancer3)<br>

### UpdateNetworkLoadBalancerRequest {#UpdateNetworkLoadBalancerRequest}

Field | Description
--- | ---
network_load_balancer_id | **string**<br>Required. ID of the network load balancer to update. To get the network load balancer ID, use a [NetworkLoadBalancerService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the NetworkLoadBalancer resource are going to be updated. 
name | **string**<br>Name of the network load balancer. The name must be unique within the folder. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the network load balancer. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. <br>The existing set of `` labels `` is completely replaced with the provided set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
listener_specs[] | **[ListenerSpec](#ListenerSpec)**<br>A list of listeners and their specs for the network load balancer. The maximum number of elements is 1000.
attached_target_groups[] | **[AttachedTargetGroup](#AttachedTargetGroup3)**<br>A list of attached target groups for the network load balancer. The maximum number of elements is 1000.


### ListenerSpec {#ListenerSpec1}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
port | **int64**<br>Port for incoming traffic. Acceptable values are 1 to 65535, inclusive.
protocol | **[Listener.Protocol](#Listener3)**<br>Required. Protocol for incoming traffic. 
address | **oneof:** `external_address_spec` or `internal_address_spec`<br>IP address for incoming traffic. Either the ID of the previously created address or the address specification.
&nbsp;&nbsp;external_address_spec | **[ExternalAddressSpec](#ExternalAddressSpec)**<br>External IP address specification. 
&nbsp;&nbsp;internal_address_spec | **[InternalAddressSpec](#InternalAddressSpec)**<br>Internal IP address specification. 
target_port | **int64**<br>Port of a target. Acceptable values are 1 to 65535, inclusive. 


### ExternalAddressSpec {#ExternalAddressSpec1}

Field | Description
--- | ---
address | **string**<br>Public IP address for a listener. If you provide a static public IP address for the [NetworkLoadBalancerService.Update](#Update) method, it will replace the existing listener address. 
ip_version | enum **IpVersion**<br>IP version. <ul><li>`IPV4`: IPv4</li><li>`IPV6`: IPv6</li></ul>


### InternalAddressSpec {#InternalAddressSpec1}

Field | Description
--- | ---
address | **string**<br>Internal IP address for a listener. 
subnet_id | **string**<br>ID of the subnet. 
ip_version | enum **IpVersion**<br>IP version. <ul><li>`IPV4`: IPv4</li><li>`IPV6`: IPv6</li></ul>


### AttachedTargetGroup {#AttachedTargetGroup3}

Field | Description
--- | ---
target_group_id | **string**<br>Required. ID of the target group. The maximum string length in characters is 50.
health_checks[] | **[HealthCheck](#HealthCheck3)**<br>A health check to perform on the target group. For now we accept only one health check per AttachedTargetGroup. The number of elemets must be exactly 1.


### HealthCheck {#HealthCheck3}

Field | Description
--- | ---
name | **string**<br>Required. Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for a target to return a response for the health check. The default is 1 second. 
unhealthy_threshold | **int64**<br>Number of failed health checks before changing the status to `` UNHEALTHY ``. The default is 2. Acceptable values are 2 to 10, inclusive.
healthy_threshold | **int64**<br>Number of successful health checks required in order to set the `` HEALTHY `` status for the target. The default is 2. Acceptable values are 2 to 10, inclusive.
options | **oneof:** `tcp_options` or `http_options`<br>Protocol to use for the health check. Either TCP or HTTP.
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions3)**<br>Options for TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions3)**<br>Options for HTTP health check. 


### TcpOptions {#TcpOptions3}

Field | Description
--- | ---
port | **int64**<br>Port to use for TCP health checks. Acceptable values are 1 to 65535, inclusive.


### HttpOptions {#HttpOptions3}

Field | Description
--- | ---
port | **int64**<br>Port to use for HTTP health checks. Acceptable values are 1 to 65535, inclusive.
path | **string**<br>URL path to set for health checking requests for every target in the target group. For example `` /ping ``. The default path is `` / ``. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateNetworkLoadBalancerMetadata](#UpdateNetworkLoadBalancerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[NetworkLoadBalancer](#NetworkLoadBalancer3)>**<br>if operation finished successfully. 


### UpdateNetworkLoadBalancerMetadata {#UpdateNetworkLoadBalancerMetadata}

Field | Description
--- | ---
network_load_balancer_id | **string**<br>ID of the NetworkLoadBalancer resource that is being updated. 


### NetworkLoadBalancer {#NetworkLoadBalancer3}

Field | Description
--- | ---
id | **string**<br>ID of the network load balancer. 
folder_id | **string**<br>ID of the folder that the network load balancer belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the network load balancer. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Optional description of the network load balancer. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
region_id | **string**<br>ID of the region that the network load balancer belongs to. 
status | enum **Status**<br>Status of the network load balancer. <ul><li>`CREATING`: Network load balancer is being created.</li><li>`STARTING`: Network load balancer is being started.</li><li>`ACTIVE`: Network load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: Network load balancer is being stopped.</li><li>`STOPPED`: Network load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: Network load balancer is being deleted.</li><li>`INACTIVE`: The load balancer doesn't have any listeners or target groups, or attached target groups are empty. The load balancer doesn't perform any health checks or send traffic in this state.</li></ul>
type | enum **Type**<br>Type of the network load balancer. Only external network load balancers are available now. <ul><li>`EXTERNAL`: External network load balancer.</li><li>`INTERNAL`: Internal network load balancer.</li></ul>
session_affinity | enum **SessionAffinity**<br>Type of the session affinity. Only 5-tuple affinity is available now. <ul><li>`CLIENT_IP_PORT_PROTO`: 5-tuple affinity.</li></ul>
listeners[] | **[Listener](#Listener3)**<br>List of listeners for the network load balancer. 
attached_target_groups[] | **[AttachedTargetGroup](#AttachedTargetGroup4)**<br>List of target groups attached to the network load balancer. 


### Listener {#Listener3}

Field | Description
--- | ---
name | **string**<br>Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. 
address | **string**<br>IP address for the listener. 
port | **int64**<br>Port. 
protocol | enum **Protocol**<br>Network protocol for incoming traffic. 
target_port | **int64**<br>Port of a target. 
subnet_id | **string**<br>ID of the subnet. 
ip_version | enum **IpVersion**<br>IP version of the external address. <ul><li>`IPV4`: IPv4</li><li>`IPV6`: IPv6</li></ul>


## Delete {#Delete}

Deletes the specified network load balancer.

**rpc Delete ([DeleteNetworkLoadBalancerRequest](#DeleteNetworkLoadBalancerRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteNetworkLoadBalancerMetadata](#DeleteNetworkLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteNetworkLoadBalancerRequest {#DeleteNetworkLoadBalancerRequest}

Field | Description
--- | ---
network_load_balancer_id | **string**<br>Required. ID of the network load balancer to delete. To get the network load balancer ID, use a [NetworkLoadBalancerService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteNetworkLoadBalancerMetadata](#DeleteNetworkLoadBalancerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteNetworkLoadBalancerMetadata {#DeleteNetworkLoadBalancerMetadata}

Field | Description
--- | ---
network_load_balancer_id | **string**<br>ID of the NetworkLoadBalancer resource that is being deleted. 


## Start {#Start}

Starts load balancing and health checking with the specified network load balancer with specified settings. Changes network load balancer status to `` ACTIVE ``.

**rpc Start ([StartNetworkLoadBalancerRequest](#StartNetworkLoadBalancerRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartNetworkLoadBalancerMetadata](#StartNetworkLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### StartNetworkLoadBalancerRequest {#StartNetworkLoadBalancerRequest}

Field | Description
--- | ---
network_load_balancer_id | **string**<br>Required. ID of the network load balancer to start. To get the network load balancer ID, use a [NetworkLoadBalancerService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StartNetworkLoadBalancerMetadata](#StartNetworkLoadBalancerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### StartNetworkLoadBalancerMetadata {#StartNetworkLoadBalancerMetadata}

Field | Description
--- | ---
network_load_balancer_id | **string**<br>ID of the NetworkLoadBalancer resource that is being started. 


## Stop {#Stop}

Stops load balancing and health checking with the specified network load balancer. Changes load balancer status to `` STOPPED ``.

**rpc Stop ([StopNetworkLoadBalancerRequest](#StopNetworkLoadBalancerRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopNetworkLoadBalancerMetadata](#StopNetworkLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### StopNetworkLoadBalancerRequest {#StopNetworkLoadBalancerRequest}

Field | Description
--- | ---
network_load_balancer_id | **string**<br>Required. ID of the network load balancer to stop. To get the network load balancer ID, use a [NetworkLoadBalancerService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StopNetworkLoadBalancerMetadata](#StopNetworkLoadBalancerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### StopNetworkLoadBalancerMetadata {#StopNetworkLoadBalancerMetadata}

Field | Description
--- | ---
network_load_balancer_id | **string**<br>ID of the NetworkLoadBalancer resource that is being stopped. 


## AttachTargetGroup {#AttachTargetGroup}

Attaches a target group to the specified network load balancer.

**rpc AttachTargetGroup ([AttachNetworkLoadBalancerTargetGroupRequest](#AttachNetworkLoadBalancerTargetGroupRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AttachNetworkLoadBalancerTargetGroupMetadata](#AttachNetworkLoadBalancerTargetGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[NetworkLoadBalancer](#NetworkLoadBalancer4)<br>

### AttachNetworkLoadBalancerTargetGroupRequest {#AttachNetworkLoadBalancerTargetGroupRequest}

Field | Description
--- | ---
network_load_balancer_id | **string**<br>Required. ID of the network load balancer to attach the target group to. To get the network load balancer ID, use a [NetworkLoadBalancerService.List](#List) request. The maximum string length in characters is 50.
attached_target_group | **[AttachedTargetGroup](#AttachedTargetGroup4)**<br>Required. ID of the attached target group to attach to the network load balancer. To get the network load balancer ID, use a [NetworkLoadBalancerService.List](#List) request. 


### AttachedTargetGroup {#AttachedTargetGroup4}

Field | Description
--- | ---
target_group_id | **string**<br>Required. ID of the target group. The maximum string length in characters is 50.
health_checks[] | **[HealthCheck](#HealthCheck4)**<br>A health check to perform on the target group. For now we accept only one health check per AttachedTargetGroup. The number of elemets must be exactly 1.


### HealthCheck {#HealthCheck4}

Field | Description
--- | ---
name | **string**<br>Required. Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for a target to return a response for the health check. The default is 1 second. 
unhealthy_threshold | **int64**<br>Number of failed health checks before changing the status to `` UNHEALTHY ``. The default is 2. Acceptable values are 2 to 10, inclusive.
healthy_threshold | **int64**<br>Number of successful health checks required in order to set the `` HEALTHY `` status for the target. The default is 2. Acceptable values are 2 to 10, inclusive.
options | **oneof:** `tcp_options` or `http_options`<br>Protocol to use for the health check. Either TCP or HTTP.
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions4)**<br>Options for TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions4)**<br>Options for HTTP health check. 


### TcpOptions {#TcpOptions4}

Field | Description
--- | ---
port | **int64**<br>Port to use for TCP health checks. Acceptable values are 1 to 65535, inclusive.


### HttpOptions {#HttpOptions4}

Field | Description
--- | ---
port | **int64**<br>Port to use for HTTP health checks. Acceptable values are 1 to 65535, inclusive.
path | **string**<br>URL path to set for health checking requests for every target in the target group. For example `` /ping ``. The default path is `` / ``. 


### Operation {#Operation5}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AttachNetworkLoadBalancerTargetGroupMetadata](#AttachNetworkLoadBalancerTargetGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[NetworkLoadBalancer](#NetworkLoadBalancer4)>**<br>if operation finished successfully. 


### AttachNetworkLoadBalancerTargetGroupMetadata {#AttachNetworkLoadBalancerTargetGroupMetadata}

Field | Description
--- | ---
network_load_balancer_id | **string**<br>ID of the network load balancer that the target group is being attached to. 
target_group_id | **string**<br>ID of the target group. 


### NetworkLoadBalancer {#NetworkLoadBalancer4}

Field | Description
--- | ---
id | **string**<br>ID of the network load balancer. 
folder_id | **string**<br>ID of the folder that the network load balancer belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the network load balancer. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Optional description of the network load balancer. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
region_id | **string**<br>ID of the region that the network load balancer belongs to. 
status | enum **Status**<br>Status of the network load balancer. <ul><li>`CREATING`: Network load balancer is being created.</li><li>`STARTING`: Network load balancer is being started.</li><li>`ACTIVE`: Network load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: Network load balancer is being stopped.</li><li>`STOPPED`: Network load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: Network load balancer is being deleted.</li><li>`INACTIVE`: The load balancer doesn't have any listeners or target groups, or attached target groups are empty. The load balancer doesn't perform any health checks or send traffic in this state.</li></ul>
type | enum **Type**<br>Type of the network load balancer. Only external network load balancers are available now. <ul><li>`EXTERNAL`: External network load balancer.</li><li>`INTERNAL`: Internal network load balancer.</li></ul>
session_affinity | enum **SessionAffinity**<br>Type of the session affinity. Only 5-tuple affinity is available now. <ul><li>`CLIENT_IP_PORT_PROTO`: 5-tuple affinity.</li></ul>
listeners[] | **[Listener](#Listener4)**<br>List of listeners for the network load balancer. 
attached_target_groups[] | **[AttachedTargetGroup](#AttachedTargetGroup5)**<br>List of target groups attached to the network load balancer. 


### Listener {#Listener4}

Field | Description
--- | ---
name | **string**<br>Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. 
address | **string**<br>IP address for the listener. 
port | **int64**<br>Port. 
protocol | enum **Protocol**<br>Network protocol for incoming traffic. 
target_port | **int64**<br>Port of a target. 
subnet_id | **string**<br>ID of the subnet. 
ip_version | enum **IpVersion**<br>IP version of the external address. <ul><li>`IPV4`: IPv4</li><li>`IPV6`: IPv6</li></ul>


## DetachTargetGroup {#DetachTargetGroup}

Detaches the target group from the specified network load balancer.

**rpc DetachTargetGroup ([DetachNetworkLoadBalancerTargetGroupRequest](#DetachNetworkLoadBalancerTargetGroupRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DetachNetworkLoadBalancerTargetGroupMetadata](#DetachNetworkLoadBalancerTargetGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[NetworkLoadBalancer](#NetworkLoadBalancer5)<br>

### DetachNetworkLoadBalancerTargetGroupRequest {#DetachNetworkLoadBalancerTargetGroupRequest}

Field | Description
--- | ---
network_load_balancer_id | **string**<br>Required. ID of the network load balancer to detach the target group from. To get the network load balancer ID, use a [NetworkLoadBalancerService.List](#List) request. The maximum string length in characters is 50.
target_group_id | **string**<br>Required. ID of the target group. The maximum string length in characters is 50.


### Operation {#Operation6}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DetachNetworkLoadBalancerTargetGroupMetadata](#DetachNetworkLoadBalancerTargetGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[NetworkLoadBalancer](#NetworkLoadBalancer5)>**<br>if operation finished successfully. 


### DetachNetworkLoadBalancerTargetGroupMetadata {#DetachNetworkLoadBalancerTargetGroupMetadata}

Field | Description
--- | ---
network_load_balancer_id | **string**<br>ID of the network load balancer that the target group is being detached from. 
target_group_id | **string**<br>ID of the target group. 


### NetworkLoadBalancer {#NetworkLoadBalancer5}

Field | Description
--- | ---
id | **string**<br>ID of the network load balancer. 
folder_id | **string**<br>ID of the folder that the network load balancer belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the network load balancer. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Optional description of the network load balancer. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
region_id | **string**<br>ID of the region that the network load balancer belongs to. 
status | enum **Status**<br>Status of the network load balancer. <ul><li>`CREATING`: Network load balancer is being created.</li><li>`STARTING`: Network load balancer is being started.</li><li>`ACTIVE`: Network load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: Network load balancer is being stopped.</li><li>`STOPPED`: Network load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: Network load balancer is being deleted.</li><li>`INACTIVE`: The load balancer doesn't have any listeners or target groups, or attached target groups are empty. The load balancer doesn't perform any health checks or send traffic in this state.</li></ul>
type | enum **Type**<br>Type of the network load balancer. Only external network load balancers are available now. <ul><li>`EXTERNAL`: External network load balancer.</li><li>`INTERNAL`: Internal network load balancer.</li></ul>
session_affinity | enum **SessionAffinity**<br>Type of the session affinity. Only 5-tuple affinity is available now. <ul><li>`CLIENT_IP_PORT_PROTO`: 5-tuple affinity.</li></ul>
listeners[] | **[Listener](#Listener5)**<br>List of listeners for the network load balancer. 
attached_target_groups[] | **[AttachedTargetGroup](#AttachedTargetGroup5)**<br>List of target groups attached to the network load balancer. 


### Listener {#Listener5}

Field | Description
--- | ---
name | **string**<br>Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. 
address | **string**<br>IP address for the listener. 
port | **int64**<br>Port. 
protocol | enum **Protocol**<br>Network protocol for incoming traffic. 
target_port | **int64**<br>Port of a target. 
subnet_id | **string**<br>ID of the subnet. 
ip_version | enum **IpVersion**<br>IP version of the external address. <ul><li>`IPV4`: IPv4</li><li>`IPV6`: IPv6</li></ul>


### AttachedTargetGroup {#AttachedTargetGroup5}

Field | Description
--- | ---
target_group_id | **string**<br>Required. ID of the target group. The maximum string length in characters is 50.
health_checks[] | **[HealthCheck](#HealthCheck5)**<br>A health check to perform on the target group. For now we accept only one health check per AttachedTargetGroup. The number of elemets must be exactly 1.


### HealthCheck {#HealthCheck5}

Field | Description
--- | ---
name | **string**<br>Required. Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for a target to return a response for the health check. The default is 1 second. 
unhealthy_threshold | **int64**<br>Number of failed health checks before changing the status to `` UNHEALTHY ``. The default is 2. Acceptable values are 2 to 10, inclusive.
healthy_threshold | **int64**<br>Number of successful health checks required in order to set the `` HEALTHY `` status for the target. The default is 2. Acceptable values are 2 to 10, inclusive.
options | **oneof:** `tcp_options` or `http_options`<br>Protocol to use for the health check. Either TCP or HTTP.
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions5)**<br>Options for TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions5)**<br>Options for HTTP health check. 


### TcpOptions {#TcpOptions5}

Field | Description
--- | ---
port | **int64**<br>Port to use for TCP health checks. Acceptable values are 1 to 65535, inclusive.


### HttpOptions {#HttpOptions5}

Field | Description
--- | ---
port | **int64**<br>Port to use for HTTP health checks. Acceptable values are 1 to 65535, inclusive.
path | **string**<br>URL path to set for health checking requests for every target in the target group. For example `` /ping ``. The default path is `` / ``. 


## GetTargetStates {#GetTargetStates}

Gets states of target resources in the attached target group.

**rpc GetTargetStates ([GetTargetStatesRequest](#GetTargetStatesRequest)) returns ([GetTargetStatesResponse](#GetTargetStatesResponse))**

### GetTargetStatesRequest {#GetTargetStatesRequest}

Field | Description
--- | ---
network_load_balancer_id | **string**<br>ID of the NetworkLoadBalancer resource with an attached target group. The maximum string length in characters is 50.
target_group_id | **string**<br>ID of the target group to get states of resources from. The maximum string length in characters is 50.


### GetTargetStatesResponse {#GetTargetStatesResponse}

Field | Description
--- | ---
target_states[] | **[TargetState](#TargetState)**<br>List of states of targets within the target group that is specified in the [GetTargetStatesRequest](#GetTargetStatesRequest) message. 


### TargetState {#TargetState}

Field | Description
--- | ---
subnet_id | **string**<br>ID of the subnet that the target is connected to. 
address | **string**<br>IP address of the target. 
status | enum **Status**<br>Status of the target. <ul><li>`INITIAL`: The network load balancer is setting up health checks for this target.</li><li>`HEALTHY`: Health check passed and the target is ready to receive traffic.</li><li>`UNHEALTHY`: Health check failed and the target is not receiving traffic.</li><li>`DRAINING`: Target is being deleted and the network load balancer is no longer sending traffic to this target.</li><li>`INACTIVE`: The network load balancer is stopped and not performing health checks on this target.</li></ul>


## AddListener {#AddListener}

Adds a listener to the specified network load balancer.

**rpc AddListener ([AddNetworkLoadBalancerListenerRequest](#AddNetworkLoadBalancerListenerRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddNetworkLoadBalancerListenerMetadata](#AddNetworkLoadBalancerListenerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[NetworkLoadBalancer](#NetworkLoadBalancer6)<br>

### AddNetworkLoadBalancerListenerRequest {#AddNetworkLoadBalancerListenerRequest}

Field | Description
--- | ---
network_load_balancer_id | **string**<br>Required. ID of the network load balancer to add a listener to. To get the network load balancer ID, use a [NetworkLoadBalancerService.List](#List) request. The maximum string length in characters is 50.
listener_spec | **[ListenerSpec](#ListenerSpec)**<br>Required. Listener spec. 


### ListenerSpec {#ListenerSpec2}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
port | **int64**<br>Port for incoming traffic. Acceptable values are 1 to 65535, inclusive.
protocol | **[Listener.Protocol](#Listener6)**<br>Required. Protocol for incoming traffic. 
address | **oneof:** `external_address_spec` or `internal_address_spec`<br>IP address for incoming traffic. Either the ID of the previously created address or the address specification.
&nbsp;&nbsp;external_address_spec | **[ExternalAddressSpec](#ExternalAddressSpec)**<br>External IP address specification. 
&nbsp;&nbsp;internal_address_spec | **[InternalAddressSpec](#InternalAddressSpec)**<br>Internal IP address specification. 
target_port | **int64**<br>Port of a target. Acceptable values are 1 to 65535, inclusive. 


### ExternalAddressSpec {#ExternalAddressSpec2}

Field | Description
--- | ---
address | **string**<br>Public IP address for a listener. If you provide a static public IP address for the [NetworkLoadBalancerService.Update](#Update) method, it will replace the existing listener address. 
ip_version | enum **IpVersion**<br>IP version. <ul><li>`IPV4`: IPv4</li><li>`IPV6`: IPv6</li></ul>


### InternalAddressSpec {#InternalAddressSpec2}

Field | Description
--- | ---
address | **string**<br>Internal IP address for a listener. 
subnet_id | **string**<br>ID of the subnet. 
ip_version | enum **IpVersion**<br>IP version. <ul><li>`IPV4`: IPv4</li><li>`IPV6`: IPv6</li></ul>


### Operation {#Operation7}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddNetworkLoadBalancerListenerMetadata](#AddNetworkLoadBalancerListenerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[NetworkLoadBalancer](#NetworkLoadBalancer6)>**<br>if operation finished successfully. 


### AddNetworkLoadBalancerListenerMetadata {#AddNetworkLoadBalancerListenerMetadata}

Field | Description
--- | ---
network_load_balancer_id | **string**<br>ID of the network load balancer that the listener is being added to. 


### NetworkLoadBalancer {#NetworkLoadBalancer6}

Field | Description
--- | ---
id | **string**<br>ID of the network load balancer. 
folder_id | **string**<br>ID of the folder that the network load balancer belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the network load balancer. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Optional description of the network load balancer. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
region_id | **string**<br>ID of the region that the network load balancer belongs to. 
status | enum **Status**<br>Status of the network load balancer. <ul><li>`CREATING`: Network load balancer is being created.</li><li>`STARTING`: Network load balancer is being started.</li><li>`ACTIVE`: Network load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: Network load balancer is being stopped.</li><li>`STOPPED`: Network load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: Network load balancer is being deleted.</li><li>`INACTIVE`: The load balancer doesn't have any listeners or target groups, or attached target groups are empty. The load balancer doesn't perform any health checks or send traffic in this state.</li></ul>
type | enum **Type**<br>Type of the network load balancer. Only external network load balancers are available now. <ul><li>`EXTERNAL`: External network load balancer.</li><li>`INTERNAL`: Internal network load balancer.</li></ul>
session_affinity | enum **SessionAffinity**<br>Type of the session affinity. Only 5-tuple affinity is available now. <ul><li>`CLIENT_IP_PORT_PROTO`: 5-tuple affinity.</li></ul>
listeners[] | **[Listener](#Listener6)**<br>List of listeners for the network load balancer. 
attached_target_groups[] | **[AttachedTargetGroup](#AttachedTargetGroup6)**<br>List of target groups attached to the network load balancer. 


### Listener {#Listener6}

Field | Description
--- | ---
name | **string**<br>Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. 
address | **string**<br>IP address for the listener. 
port | **int64**<br>Port. 
protocol | enum **Protocol**<br>Network protocol for incoming traffic. 
target_port | **int64**<br>Port of a target. 
subnet_id | **string**<br>ID of the subnet. 
ip_version | enum **IpVersion**<br>IP version of the external address. <ul><li>`IPV4`: IPv4</li><li>`IPV6`: IPv6</li></ul>


### AttachedTargetGroup {#AttachedTargetGroup6}

Field | Description
--- | ---
target_group_id | **string**<br>Required. ID of the target group. The maximum string length in characters is 50.
health_checks[] | **[HealthCheck](#HealthCheck6)**<br>A health check to perform on the target group. For now we accept only one health check per AttachedTargetGroup. The number of elemets must be exactly 1.


### HealthCheck {#HealthCheck6}

Field | Description
--- | ---
name | **string**<br>Required. Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for a target to return a response for the health check. The default is 1 second. 
unhealthy_threshold | **int64**<br>Number of failed health checks before changing the status to `` UNHEALTHY ``. The default is 2. Acceptable values are 2 to 10, inclusive.
healthy_threshold | **int64**<br>Number of successful health checks required in order to set the `` HEALTHY `` status for the target. The default is 2. Acceptable values are 2 to 10, inclusive.
options | **oneof:** `tcp_options` or `http_options`<br>Protocol to use for the health check. Either TCP or HTTP.
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions6)**<br>Options for TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions6)**<br>Options for HTTP health check. 


### TcpOptions {#TcpOptions6}

Field | Description
--- | ---
port | **int64**<br>Port to use for TCP health checks. Acceptable values are 1 to 65535, inclusive.


### HttpOptions {#HttpOptions6}

Field | Description
--- | ---
port | **int64**<br>Port to use for HTTP health checks. Acceptable values are 1 to 65535, inclusive.
path | **string**<br>URL path to set for health checking requests for every target in the target group. For example `` /ping ``. The default path is `` / ``. 


## RemoveListener {#RemoveListener}

Removes the listener from the specified network load balancer.

**rpc RemoveListener ([RemoveNetworkLoadBalancerListenerRequest](#RemoveNetworkLoadBalancerListenerRequest)) returns ([operation.Operation](#Operation8))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveNetworkLoadBalancerListenerMetadata](#RemoveNetworkLoadBalancerListenerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[NetworkLoadBalancer](#NetworkLoadBalancer7)<br>

### RemoveNetworkLoadBalancerListenerRequest {#RemoveNetworkLoadBalancerListenerRequest}

Field | Description
--- | ---
network_load_balancer_id | **string**<br>Required. ID of the network load balancer to remove the listener from. To get the network load balancer ID, use a [NetworkLoadBalancerService.List](#List) request. The maximum string length in characters is 50.
listener_name | **string**<br>Required. Name of the listener to delete. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.


### Operation {#Operation8}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RemoveNetworkLoadBalancerListenerMetadata](#RemoveNetworkLoadBalancerListenerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[NetworkLoadBalancer](#NetworkLoadBalancer7)>**<br>if operation finished successfully. 


### RemoveNetworkLoadBalancerListenerMetadata {#RemoveNetworkLoadBalancerListenerMetadata}

Field | Description
--- | ---
network_load_balancer_id | **string**<br>ID of the network load balancer that the listener is being removed from. 


### NetworkLoadBalancer {#NetworkLoadBalancer7}

Field | Description
--- | ---
id | **string**<br>ID of the network load balancer. 
folder_id | **string**<br>ID of the folder that the network load balancer belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the network load balancer. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Optional description of the network load balancer. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
region_id | **string**<br>ID of the region that the network load balancer belongs to. 
status | enum **Status**<br>Status of the network load balancer. <ul><li>`CREATING`: Network load balancer is being created.</li><li>`STARTING`: Network load balancer is being started.</li><li>`ACTIVE`: Network load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: Network load balancer is being stopped.</li><li>`STOPPED`: Network load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: Network load balancer is being deleted.</li><li>`INACTIVE`: The load balancer doesn't have any listeners or target groups, or attached target groups are empty. The load balancer doesn't perform any health checks or send traffic in this state.</li></ul>
type | enum **Type**<br>Type of the network load balancer. Only external network load balancers are available now. <ul><li>`EXTERNAL`: External network load balancer.</li><li>`INTERNAL`: Internal network load balancer.</li></ul>
session_affinity | enum **SessionAffinity**<br>Type of the session affinity. Only 5-tuple affinity is available now. <ul><li>`CLIENT_IP_PORT_PROTO`: 5-tuple affinity.</li></ul>
listeners[] | **[Listener](#Listener7)**<br>List of listeners for the network load balancer. 
attached_target_groups[] | **[AttachedTargetGroup](#AttachedTargetGroup7)**<br>List of target groups attached to the network load balancer. 


### Listener {#Listener7}

Field | Description
--- | ---
name | **string**<br>Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. 
address | **string**<br>IP address for the listener. 
port | **int64**<br>Port. 
protocol | enum **Protocol**<br>Network protocol for incoming traffic. 
target_port | **int64**<br>Port of a target. 
subnet_id | **string**<br>ID of the subnet. 
ip_version | enum **IpVersion**<br>IP version of the external address. <ul><li>`IPV4`: IPv4</li><li>`IPV6`: IPv6</li></ul>


### AttachedTargetGroup {#AttachedTargetGroup7}

Field | Description
--- | ---
target_group_id | **string**<br>Required. ID of the target group. The maximum string length in characters is 50.
health_checks[] | **[HealthCheck](#HealthCheck7)**<br>A health check to perform on the target group. For now we accept only one health check per AttachedTargetGroup. The number of elemets must be exactly 1.


### HealthCheck {#HealthCheck7}

Field | Description
--- | ---
name | **string**<br>Required. Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for a target to return a response for the health check. The default is 1 second. 
unhealthy_threshold | **int64**<br>Number of failed health checks before changing the status to `` UNHEALTHY ``. The default is 2. Acceptable values are 2 to 10, inclusive.
healthy_threshold | **int64**<br>Number of successful health checks required in order to set the `` HEALTHY `` status for the target. The default is 2. Acceptable values are 2 to 10, inclusive.
options | **oneof:** `tcp_options` or `http_options`<br>Protocol to use for the health check. Either TCP or HTTP.
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions7)**<br>Options for TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions7)**<br>Options for HTTP health check. 


### TcpOptions {#TcpOptions7}

Field | Description
--- | ---
port | **int64**<br>Port to use for TCP health checks. Acceptable values are 1 to 65535, inclusive.


### HttpOptions {#HttpOptions7}

Field | Description
--- | ---
port | **int64**<br>Port to use for HTTP health checks. Acceptable values are 1 to 65535, inclusive.
path | **string**<br>URL path to set for health checking requests for every target in the target group. For example `` /ping ``. The default path is `` / ``. 


## ListOperations {#ListOperations}

Lists operations for the specified network load balancer.

**rpc ListOperations ([ListNetworkLoadBalancerOperationsRequest](#ListNetworkLoadBalancerOperationsRequest)) returns ([ListNetworkLoadBalancerOperationsResponse](#ListNetworkLoadBalancerOperationsResponse))**

### ListNetworkLoadBalancerOperationsRequest {#ListNetworkLoadBalancerOperationsRequest}

Field | Description
--- | ---
network_load_balancer_id | **string**<br>Required. ID of the NetworkLoadBalancer resource to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListNetworkLoadBalancerOperationsResponse.next_page_token](#ListNetworkLoadBalancerOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListNetworkLoadBalancerOperationsResponse.next_page_token](#ListNetworkLoadBalancerOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListNetworkLoadBalancerOperationsResponse {#ListNetworkLoadBalancerOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation9)**<br>List of operations for the specified network load balancer. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListNetworkLoadBalancerOperationsRequest.page_size](#ListNetworkLoadBalancerOperationsRequest), use the `next_page_token` as the value for the [ListNetworkLoadBalancerOperationsRequest.page_token](#ListNetworkLoadBalancerOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation9}

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



---
editable: false
sourcePath: en/_api-ref-grpc/managed-elasticsearch/api-ref/grpc/auth_service.md
---

# AuthService

A set of methods for managing Elasticsearch Authentication resources.

| Call | Description |
| --- | --- |
| [ListProviders](#ListProviders) | Retrieves the list of registered auth providers for Elasticsearch cluster. |
| [GetProvider](#GetProvider) | Returns registered auth provider by name. |
| [AddProviders](#AddProviders) | Adds new auth providers to Elasticsearch cluster. |
| [UpdateProviders](#UpdateProviders) | Replase the list of auth providers. |
| [DeleteProviders](#DeleteProviders) | Removes auth providers from Elasticsearch cluster by name. |
| [UpdateProvider](#UpdateProvider) | Updates registered auth provider. |
| [DeleteProvider](#DeleteProvider) | Removes auth provider from Elasticsearch cluster by name. |

## Calls AuthService {#calls}

## ListProviders {#ListProviders}

Retrieves the list of registered auth providers for Elasticsearch cluster.

**rpc ListProviders ([ListAuthProvidersRequest](#ListAuthProvidersRequest)) returns ([ListAuthProvidersResponse](#ListAuthProvidersResponse))**

### ListAuthProvidersRequest {#ListAuthProvidersRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the ElasticSearch cluster. The maximum string length in characters is 50.


### ListAuthProvidersResponse {#ListAuthProvidersResponse}

Field | Description
--- | ---
providers[] | **[AuthProvider](#AuthProvider)**<br>List of auth providers of the Elasticsearch cluster. 


### AuthProvider {#AuthProvider}

Field | Description
--- | ---
type | enum **Type**<br> 
name | **string**<br> The maximum string length in characters is 50. Value must match the regular expression ` [a-z][a-z0-9_-]* `.
order | **int64**<br> 
enabled | **bool**<br> 
hidden | **bool**<br>selector ui settings 
description | **string**<br> The maximum string length in characters is 50.
hint | **string**<br> The maximum string length in characters is 250.
icon | **string**<br> The maximum string length in characters is 250.
settings | **oneof:** `saml`<br>
&nbsp;&nbsp;saml | **[SamlSettings](#SamlSettings)**<br> 


### SamlSettings {#SamlSettings}

Field | Description
--- | ---
idp_entity_id | **string**<br> The maximum string length in characters is 250.
idp_metadata_file | **bytes**<br> The maximum string length in characters is 10000.
sp_entity_id | **string**<br> The maximum string length in characters is 250.
kibana_url | **string**<br> The maximum string length in characters is 250.
attribute_principal | **string**<br> The maximum string length in characters is 50.
attribute_groups | **string**<br> The maximum string length in characters is 50.
attribute_name | **string**<br> The maximum string length in characters is 50.
attribute_email | **string**<br> The maximum string length in characters is 50.
attribute_dn | **string**<br> The maximum string length in characters is 50.


## GetProvider {#GetProvider}

Returns registered auth provider by name.

**rpc GetProvider ([GetAuthProviderRequest](#GetAuthProviderRequest)) returns ([AuthProvider](#AuthProvider1))**

### GetAuthProviderRequest {#GetAuthProviderRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the ElasticSearch cluster. The maximum string length in characters is 50.
name | **string**<br>Required. Required. Name of the provider to delete. The maximum string length in characters is 50. Value must match the regular expression ` [a-z][a-z0-9_-]* `.


### AuthProvider {#AuthProvider1}

Field | Description
--- | ---
type | enum **Type**<br> 
name | **string**<br> The maximum string length in characters is 50. Value must match the regular expression ` [a-z][a-z0-9_-]* `.
order | **int64**<br> 
enabled | **bool**<br> 
hidden | **bool**<br>selector ui settings 
description | **string**<br> The maximum string length in characters is 50.
hint | **string**<br> The maximum string length in characters is 250.
icon | **string**<br> The maximum string length in characters is 250.
settings | **oneof:** `saml`<br>
&nbsp;&nbsp;saml | **[SamlSettings](#SamlSettings1)**<br> 


### SamlSettings {#SamlSettings1}

Field | Description
--- | ---
idp_entity_id | **string**<br> The maximum string length in characters is 250.
idp_metadata_file | **bytes**<br> The maximum string length in characters is 10000.
sp_entity_id | **string**<br> The maximum string length in characters is 250.
kibana_url | **string**<br> The maximum string length in characters is 250.
attribute_principal | **string**<br> The maximum string length in characters is 50.
attribute_groups | **string**<br> The maximum string length in characters is 50.
attribute_name | **string**<br> The maximum string length in characters is 50.
attribute_email | **string**<br> The maximum string length in characters is 50.
attribute_dn | **string**<br> The maximum string length in characters is 50.


## AddProviders {#AddProviders}

Adds new auth providers to Elasticsearch cluster.

**rpc AddProviders ([AddAuthProvidersRequest](#AddAuthProvidersRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddAuthProvidersMetadata](#AddAuthProvidersMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[AuthProviders](#AuthProviders)<br>

### AddAuthProvidersRequest {#AddAuthProvidersRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the ElasticSearch cluster. The maximum string length in characters is 50.
providers[] | **[AuthProvider](#AuthProvider2)**<br>Required. List of providers to add. The maximum number of elements is 10.


### AuthProvider {#AuthProvider2}

Field | Description
--- | ---
type | enum **Type**<br> 
name | **string**<br> The maximum string length in characters is 50. Value must match the regular expression ` [a-z][a-z0-9_-]* `.
order | **int64**<br> 
enabled | **bool**<br> 
hidden | **bool**<br>selector ui settings 
description | **string**<br> The maximum string length in characters is 50.
hint | **string**<br> The maximum string length in characters is 250.
icon | **string**<br> The maximum string length in characters is 250.
settings | **oneof:** `saml`<br>
&nbsp;&nbsp;saml | **[SamlSettings](#SamlSettings2)**<br> 


### SamlSettings {#SamlSettings2}

Field | Description
--- | ---
idp_entity_id | **string**<br> The maximum string length in characters is 250.
idp_metadata_file | **bytes**<br> The maximum string length in characters is 10000.
sp_entity_id | **string**<br> The maximum string length in characters is 250.
kibana_url | **string**<br> The maximum string length in characters is 250.
attribute_principal | **string**<br> The maximum string length in characters is 50.
attribute_groups | **string**<br> The maximum string length in characters is 50.
attribute_name | **string**<br> The maximum string length in characters is 50.
attribute_email | **string**<br> The maximum string length in characters is 50.
attribute_dn | **string**<br> The maximum string length in characters is 50.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddAuthProvidersMetadata](#AddAuthProvidersMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AuthProviders](#AuthProviders)>**<br>if operation finished successfully. 


### AddAuthProvidersMetadata {#AddAuthProvidersMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the ElasticSearch cluster. 
names[] | **string**<br>Names of the providers being added. 


### AuthProviders {#AuthProviders}

Field | Description
--- | ---
providers[] | **[AuthProvider](#AuthProvider3)**<br> 


## UpdateProviders {#UpdateProviders}

Replase the list of auth providers.

**rpc UpdateProviders ([UpdateAuthProvidersRequest](#UpdateAuthProvidersRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAuthProvidersMetadata](#UpdateAuthProvidersMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[AuthProviders](#AuthProviders1)<br>

### UpdateAuthProvidersRequest {#UpdateAuthProvidersRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the ElasticSearch cluster. The maximum string length in characters is 50.
providers[] | **[AuthProvider](#AuthProvider3)**<br>Required. List of providers to set. The maximum number of elements is 10.


### AuthProvider {#AuthProvider3}

Field | Description
--- | ---
type | enum **Type**<br> 
name | **string**<br> The maximum string length in characters is 50. Value must match the regular expression ` [a-z][a-z0-9_-]* `.
order | **int64**<br> 
enabled | **bool**<br> 
hidden | **bool**<br>selector ui settings 
description | **string**<br> The maximum string length in characters is 50.
hint | **string**<br> The maximum string length in characters is 250.
icon | **string**<br> The maximum string length in characters is 250.
settings | **oneof:** `saml`<br>
&nbsp;&nbsp;saml | **[SamlSettings](#SamlSettings3)**<br> 


### SamlSettings {#SamlSettings3}

Field | Description
--- | ---
idp_entity_id | **string**<br> The maximum string length in characters is 250.
idp_metadata_file | **bytes**<br> The maximum string length in characters is 10000.
sp_entity_id | **string**<br> The maximum string length in characters is 250.
kibana_url | **string**<br> The maximum string length in characters is 250.
attribute_principal | **string**<br> The maximum string length in characters is 50.
attribute_groups | **string**<br> The maximum string length in characters is 50.
attribute_name | **string**<br> The maximum string length in characters is 50.
attribute_email | **string**<br> The maximum string length in characters is 50.
attribute_dn | **string**<br> The maximum string length in characters is 50.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateAuthProvidersMetadata](#UpdateAuthProvidersMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AuthProviders](#AuthProviders1)>**<br>if operation finished successfully. 


### UpdateAuthProvidersMetadata {#UpdateAuthProvidersMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the ElasticSearch cluster. 
names[] | **string**<br>Names of the providers being added. 


### AuthProviders {#AuthProviders1}

Field | Description
--- | ---
providers[] | **[AuthProvider](#AuthProvider4)**<br> 


## DeleteProviders {#DeleteProviders}

Removes auth providers from Elasticsearch cluster by name.

**rpc DeleteProviders ([DeleteAuthProvidersRequest](#DeleteAuthProvidersRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteAuthProvidersMetadata](#DeleteAuthProvidersMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteAuthProvidersRequest {#DeleteAuthProvidersRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the ElasticSearch cluster. The maximum string length in characters is 50.
provider_names[] | **string**<br>Required. List of providers to delete. The maximum number of elements is 10. The maximum string length in characters for each value is 50. Each value must match the regular expression ` [a-z][a-z0-9_-]* `.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteAuthProvidersMetadata](#DeleteAuthProvidersMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteAuthProvidersMetadata {#DeleteAuthProvidersMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the ElasticSearch cluster. 
names[] | **string**<br>Names of the providers being removed. 


## UpdateProvider {#UpdateProvider}

Updates registered auth provider.

**rpc UpdateProvider ([UpdateAuthProviderRequest](#UpdateAuthProviderRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAuthProvidersMetadata](#UpdateAuthProvidersMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[AuthProviders](#AuthProviders2)<br>

### UpdateAuthProviderRequest {#UpdateAuthProviderRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the ElasticSearch cluster. The maximum string length in characters is 50.
name | **string**<br>Required. Required. Name of the provider to update. The maximum string length in characters is 50. Value must match the regular expression ` [a-z][a-z0-9_-]* `.
provider | **[AuthProvider](#AuthProvider4)**<br>Required. Required. New provider defenition. 


### AuthProvider {#AuthProvider4}

Field | Description
--- | ---
type | enum **Type**<br> 
name | **string**<br> The maximum string length in characters is 50. Value must match the regular expression ` [a-z][a-z0-9_-]* `.
order | **int64**<br> 
enabled | **bool**<br> 
hidden | **bool**<br>selector ui settings 
description | **string**<br> The maximum string length in characters is 50.
hint | **string**<br> The maximum string length in characters is 250.
icon | **string**<br> The maximum string length in characters is 250.
settings | **oneof:** `saml`<br>
&nbsp;&nbsp;saml | **[SamlSettings](#SamlSettings4)**<br> 


### SamlSettings {#SamlSettings4}

Field | Description
--- | ---
idp_entity_id | **string**<br> The maximum string length in characters is 250.
idp_metadata_file | **bytes**<br> The maximum string length in characters is 10000.
sp_entity_id | **string**<br> The maximum string length in characters is 250.
kibana_url | **string**<br> The maximum string length in characters is 250.
attribute_principal | **string**<br> The maximum string length in characters is 50.
attribute_groups | **string**<br> The maximum string length in characters is 50.
attribute_name | **string**<br> The maximum string length in characters is 50.
attribute_email | **string**<br> The maximum string length in characters is 50.
attribute_dn | **string**<br> The maximum string length in characters is 50.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateAuthProvidersMetadata](#UpdateAuthProvidersMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AuthProviders](#AuthProviders2)>**<br>if operation finished successfully. 


### UpdateAuthProvidersMetadata {#UpdateAuthProvidersMetadata1}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the ElasticSearch cluster. 
names[] | **string**<br>Names of the providers being added. 


### AuthProviders {#AuthProviders2}

Field | Description
--- | ---
providers[] | **[AuthProvider](#AuthProvider5)**<br> 


## DeleteProvider {#DeleteProvider}

Removes auth provider from Elasticsearch cluster by name.

**rpc DeleteProvider ([DeleteAuthProviderRequest](#DeleteAuthProviderRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteAuthProvidersMetadata](#DeleteAuthProvidersMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteAuthProviderRequest {#DeleteAuthProviderRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the ElasticSearch cluster. The maximum string length in characters is 50.
name | **string**<br>Required. Required. Name of the provider to delete. The maximum string length in characters is 50. Value must match the regular expression ` [a-z][a-z0-9_-]* `.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteAuthProvidersMetadata](#DeleteAuthProvidersMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteAuthProvidersMetadata {#DeleteAuthProvidersMetadata1}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the ElasticSearch cluster. 
names[] | **string**<br>Names of the providers being removed. 



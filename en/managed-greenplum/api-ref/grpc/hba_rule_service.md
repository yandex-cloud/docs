---
editable: false
sourcePath: en/_api-ref-grpc/managed-greenplum/api-ref/grpc/hba_rule_service.md
---

# Managed Service for Greenplum® API, gRPC: HBARuleService

A set of methods for managing Greenplum clusters.

| Call | Description |
| --- | --- |
| [List](#List) | Retrieves a list of HBA rules for Greenplum clusters. |
| [ListAtRevision](#ListAtRevision) | Retrieves a list of HBA rules for Greenplum clusters for particular revision. |
| [Create](#Create) | Create single HBA rule for the specified Greenplum cluster to the end of HBA rules list. |
| [Update](#Update) | Update specified HBA rule for the specified Greenplum cluster without changind it order. |
| [Delete](#Delete) | Delete specified HBA rule for the specified Greenplum cluster. |
| [BatchUpdate](#BatchUpdate) | Modifies all HBA rules for the specified Greenplum cluster. |

## Calls HBARuleService {#calls}

## List {#List}

Retrieves a list of HBA rules for Greenplum clusters.

**rpc List ([ListHBARulesRequest](#ListHBARulesRequest)) returns ([ListHBARulesResponse](#ListHBARulesResponse))**

### ListHBARulesRequest {#ListHBARulesRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum cluster. To get the Greenplum cluster ID use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.


### ListHBARulesResponse {#ListHBARulesResponse}

Field | Description
--- | ---
hba_rules[] | **[HBARule](#HBARule)**<br>Requested list of hba rules for the cluster. 


### HBARule {#HBARule}

Field | Description
--- | ---
priority | **int64**<br>Priority of the Greenplum cluster rule. Acceptable values are 0 to 1000, inclusive.
connection_type | enum **ConnectionType**<br> <ul><li>`HOST`: Matches connection attempts made using TCP/IP.</li><li>`HOSTSSL`: Matches connection attempts made using TCP/IP, but only when the connection is made with SSL encryption.</li><li>`HOSTNOSSL`: Matches connection attempts made over TCP/IP that do not use SSL.</li></ul>
database | **string**<br>Required. Specifies which database names this record matches. 
user | **string**<br>Required. Specifies which database role names this user matches. 
address | **string**<br>Required. Specifies the client machine addresses that this record matches. 
auth_method | enum **AuthMethod**<br>Specifies the authentication method to use when a connection matches this record. https://gpdb.docs.pivotal.io/6-6/security-guide/topics/Authenticate.html <ul><li>`MD5`: Perform SCRAM-SHA-256 or MD5 authentication to verify the user's password.</li><li>`LDAP`: Perform LDAP authentication, if MDB_GREENPLUM_LDAP flag is set</li><li>`REJECT`: Disable authentication</li></ul>


## ListAtRevision {#ListAtRevision}

Retrieves a list of HBA rules for Greenplum clusters for particular revision.

**rpc ListAtRevision ([ListHBARulesAtRevisionRequest](#ListHBARulesAtRevisionRequest)) returns ([ListHBARulesResponse](#ListHBARulesResponse))**

### ListHBARulesAtRevisionRequest {#ListHBARulesAtRevisionRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum cluster. To get the Greenplum cluster ID use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
revision | **int64**<br>Cluster revision Value must be greater than 0.


### ListHBARulesResponse {#ListHBARulesResponse1}

Field | Description
--- | ---
hba_rules[] | **[HBARule](#HBARule1)**<br>Requested list of hba rules for the cluster. 


### HBARule {#HBARule1}

Field | Description
--- | ---
priority | **int64**<br>Priority of the Greenplum cluster rule. Acceptable values are 0 to 1000, inclusive.
connection_type | enum **ConnectionType**<br> <ul><li>`HOST`: Matches connection attempts made using TCP/IP.</li><li>`HOSTSSL`: Matches connection attempts made using TCP/IP, but only when the connection is made with SSL encryption.</li><li>`HOSTNOSSL`: Matches connection attempts made over TCP/IP that do not use SSL.</li></ul>
database | **string**<br>Required. Specifies which database names this record matches. 
user | **string**<br>Required. Specifies which database role names this user matches. 
address | **string**<br>Required. Specifies the client machine addresses that this record matches. 
auth_method | enum **AuthMethod**<br>Specifies the authentication method to use when a connection matches this record. https://gpdb.docs.pivotal.io/6-6/security-guide/topics/Authenticate.html <ul><li>`MD5`: Perform SCRAM-SHA-256 or MD5 authentication to verify the user's password.</li><li>`LDAP`: Perform LDAP authentication, if MDB_GREENPLUM_LDAP flag is set</li><li>`REJECT`: Disable authentication</li></ul>


## Create {#Create}

Create single HBA rule for the specified Greenplum cluster to the end of HBA rules list.

**rpc Create ([CreateHBARuleRequest](#CreateHBARuleRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[HBARulesMetadata](#HBARulesMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### CreateHBARuleRequest {#CreateHBARuleRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum cluster. To get the Greenplum cluster ID use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
hba_rule | **[HBARule](#HBARule2)**<br>Required. New hba rule for the cluster. 


### HBARule {#HBARule2}

Field | Description
--- | ---
priority | **int64**<br>Priority of the Greenplum cluster rule. Acceptable values are 0 to 1000, inclusive.
connection_type | enum **ConnectionType**<br> <ul><li>`HOST`: Matches connection attempts made using TCP/IP.</li><li>`HOSTSSL`: Matches connection attempts made using TCP/IP, but only when the connection is made with SSL encryption.</li><li>`HOSTNOSSL`: Matches connection attempts made over TCP/IP that do not use SSL.</li></ul>
database | **string**<br>Required. Specifies which database names this record matches. 
user | **string**<br>Required. Specifies which database role names this user matches. 
address | **string**<br>Required. Specifies the client machine addresses that this record matches. 
auth_method | enum **AuthMethod**<br>Specifies the authentication method to use when a connection matches this record. https://gpdb.docs.pivotal.io/6-6/security-guide/topics/Authenticate.html <ul><li>`MD5`: Perform SCRAM-SHA-256 or MD5 authentication to verify the user's password.</li><li>`LDAP`: Perform LDAP authentication, if MDB_GREENPLUM_LDAP flag is set</li><li>`REJECT`: Disable authentication</li></ul>


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[HBARulesMetadata](#HBARulesMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### HBARulesMetadata {#HBARulesMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Greenplum cluster which HBA rules was affected. 


## Update {#Update}

Update specified HBA rule for the specified Greenplum cluster without changind it order.

**rpc Update ([UpdateHBARuleRequest](#UpdateHBARuleRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[HBARulesMetadata](#HBARulesMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateHBARuleRequest {#UpdateHBARuleRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum cluster. To get the Greenplum cluster ID use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
hba_rule | **[HBARule](#HBARule3)**<br>Required. Updated hba rule for the cluster. 


### HBARule {#HBARule3}

Field | Description
--- | ---
priority | **int64**<br>Priority of the Greenplum cluster rule. Acceptable values are 0 to 1000, inclusive.
connection_type | enum **ConnectionType**<br> <ul><li>`HOST`: Matches connection attempts made using TCP/IP.</li><li>`HOSTSSL`: Matches connection attempts made using TCP/IP, but only when the connection is made with SSL encryption.</li><li>`HOSTNOSSL`: Matches connection attempts made over TCP/IP that do not use SSL.</li></ul>
database | **string**<br>Required. Specifies which database names this record matches. 
user | **string**<br>Required. Specifies which database role names this user matches. 
address | **string**<br>Required. Specifies the client machine addresses that this record matches. 
auth_method | enum **AuthMethod**<br>Specifies the authentication method to use when a connection matches this record. https://gpdb.docs.pivotal.io/6-6/security-guide/topics/Authenticate.html <ul><li>`MD5`: Perform SCRAM-SHA-256 or MD5 authentication to verify the user's password.</li><li>`LDAP`: Perform LDAP authentication, if MDB_GREENPLUM_LDAP flag is set</li><li>`REJECT`: Disable authentication</li></ul>


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[HBARulesMetadata](#HBARulesMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### HBARulesMetadata {#HBARulesMetadata1}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Greenplum cluster which HBA rules was affected. 


## Delete {#Delete}

Delete specified HBA rule for the specified Greenplum cluster.

**rpc Delete ([DeleteHBARuleRequest](#DeleteHBARuleRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[HBARulesMetadata](#HBARulesMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteHBARuleRequest {#DeleteHBARuleRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum cluster. To get the Greenplum cluster ID use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
priority | **int64**<br>Priority of the Greenplum cluster rule. Acceptable values are 0 to 1000, inclusive.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[HBARulesMetadata](#HBARulesMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### HBARulesMetadata {#HBARulesMetadata2}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Greenplum cluster which HBA rules was affected. 


## BatchUpdate {#BatchUpdate}

Modifies all HBA rules for the specified Greenplum cluster.

**rpc BatchUpdate ([BatchUpdateHBARulesRequest](#BatchUpdateHBARulesRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[HBARulesMetadata](#HBARulesMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### BatchUpdateHBARulesRequest {#BatchUpdateHBARulesRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Greenplum cluster. To get the Greenplum cluster ID use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
hba_rules[] | **[HBARule](#HBARule4)**<br>List of new hba rules for the cluster. The number of elements must be greater than 0.


### HBARule {#HBARule4}

Field | Description
--- | ---
priority | **int64**<br>Priority of the Greenplum cluster rule. Acceptable values are 0 to 1000, inclusive.
connection_type | enum **ConnectionType**<br> <ul><li>`HOST`: Matches connection attempts made using TCP/IP.</li><li>`HOSTSSL`: Matches connection attempts made using TCP/IP, but only when the connection is made with SSL encryption.</li><li>`HOSTNOSSL`: Matches connection attempts made over TCP/IP that do not use SSL.</li></ul>
database | **string**<br>Required. Specifies which database names this record matches. 
user | **string**<br>Required. Specifies which database role names this user matches. 
address | **string**<br>Required. Specifies the client machine addresses that this record matches. 
auth_method | enum **AuthMethod**<br>Specifies the authentication method to use when a connection matches this record. https://gpdb.docs.pivotal.io/6-6/security-guide/topics/Authenticate.html <ul><li>`MD5`: Perform SCRAM-SHA-256 or MD5 authentication to verify the user's password.</li><li>`LDAP`: Perform LDAP authentication, if MDB_GREENPLUM_LDAP flag is set</li><li>`REJECT`: Disable authentication</li></ul>


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[HBARulesMetadata](#HBARulesMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### HBARulesMetadata {#HBARulesMetadata3}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the Greenplum cluster which HBA rules was affected. 



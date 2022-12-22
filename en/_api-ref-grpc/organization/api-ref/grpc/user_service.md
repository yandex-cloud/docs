---
editable: false
---

# Cloud Organization API, gRPC: UserService

A set of methods for managing Organization users.

| Call | Description |
| --- | --- |
| [ListMembers](#ListMembers) | List organization active members. |
| [DeleteMembership](#DeleteMembership) | Delete user membership. |

## Calls UserService {#calls}

## ListMembers {#ListMembers}

List organization active members.

**rpc ListMembers ([ListMembersRequest](#ListMembersRequest)) returns ([ListMembersResponse](#ListMembersResponse))**

### ListMembersRequest {#ListMembersRequest}

Field | Description
--- | ---
organization_id | **string**<br>Required. ID of the Organization resource to list members for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListMembersResponse.next_page_token](#ListMembersResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. Set `page_token` to the [ListMembersResponse.next_page_token](#ListMembersResponse) returned by a previous list request to get the next page of results. The maximum string length in characters is 2000.


### ListMembersResponse {#ListMembersResponse}

Field | Description
--- | ---
users[] | **OrganizationUser**<br>List of users for the specified organization. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListMembersRequest.page_size](#ListMembersRequest), use the `next_page_token` as the value for the [ListMembersRequest.page_token](#ListMembersRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### OrganizationUser {#OrganizationUser}

Field | Description
--- | ---
subject_claims | **yandex.cloud.oauth.SubjectClaims**<br>OpenID standard claims with additional Cloud Organization claims. 


## DeleteMembership {#DeleteMembership}

Delete user membership.

**rpc DeleteMembership ([DeleteMembershipRequest](#DeleteMembershipRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteMembershipMetadata](#DeleteMembershipMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[DeleteMembershipResponse](#DeleteMembershipResponse)<br>

### DeleteMembershipRequest {#DeleteMembershipRequest}

Field | Description
--- | ---
organization_id | **string**<br>Required. ID of the organization to delete membership. The maximum string length in characters is 50.
subject_id | **string**<br>ID of the subject that is being deleted from organization. By default equals to authenticated subject. The maximum string length in characters is 50.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteMembershipMetadata](#DeleteMembershipMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteMembershipResponse](#DeleteMembershipResponse)>**<br>if operation finished successfully. 


### DeleteMembershipMetadata {#DeleteMembershipMetadata}

Field | Description
--- | ---
organization_id | **string**<br>Required. ID of the organization to delete membership. The maximum string length in characters is 50.
subject_id | **string**<br>Required. ID of the subject that is being deleted from organization. The maximum string length in characters is 50.


### DeleteMembershipResponse {#DeleteMembershipResponse}

Field | Description
--- | ---
organization_id | **string**<br>Required. ID of the organization to delete membership. The maximum string length in characters is 50.
subject_id | **string**<br>Required. ID of the subject that is being deleted from organization. The maximum string length in characters is 50.



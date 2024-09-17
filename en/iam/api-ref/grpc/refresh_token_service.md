---
editable: false
sourcePath: en/_api-ref-grpc/iam/api-ref/grpc/refresh_token_service.md
---

# Identity and Access Management API, gRPC: RefreshTokenService

A set of methods for managing Refresh Tokens.

| Call | Description |
| --- | --- |
| [List](#List) | List subjects Refresh Tokens. |
| [Revoke](#Revoke) | Revoke Refresh Tokens. |

## Calls RefreshTokenService {#calls}

## List {#List}

List subjects Refresh Tokens.

**rpc List ([ListRefreshTokensRequest](#ListRefreshTokensRequest)) returns ([ListRefreshTokensResponse](#ListRefreshTokensResponse))**

### ListRefreshTokensRequest {#ListRefreshTokensRequest}

Field | Description
--- | ---
subject_id | **string**<br> The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListRefreshTokensResponse.next_page_token](#ListRefreshTokensResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListRefreshTokensResponse.next_page_token](#ListRefreshTokensResponse) returned by a previous list request. The maximum string length in characters is 2000.
filter | **string**<br>A filter expression that filters refresh tokens listed in the response. <br>The expression must specify: <ol><li>The field name. Currently you can use filtering only on [RefreshToken.client_instance_info](#RefreshToken), [RefreshToken.client_id](#RefreshToken) or [RefreshToken.protection_level](#RefreshToken) fields. </li><li>The operator. An `=` operator can be used for all fields. An 'IN' operator can be used for [RefreshToken.protection_level](#RefreshToken). </li><li>The value. The value must be in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-zA-Z][_-a-zA-Z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `client_instance_info="clientInstanceInfo" AND protection_level IN ("INSECURE_KEY_DPOP", "SECURE_KEY_DPOP")`. The maximum string length in characters is 1000.


### ListRefreshTokensResponse {#ListRefreshTokensResponse}

Field | Description
--- | ---
refresh_tokens[] | **[RefreshToken](#RefreshToken)**<br>List of Refresh Tokens 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListRefreshTokensForSubjectRequest.page_size], use the `next_page_token` as the value for the [ListRefreshTokensForSubjectRequest.page_token] query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### RefreshToken {#RefreshToken}

Field | Description
--- | ---
id | **string**<br>Refresh Token id. 
client_instance_info | **string**<br>Information about the app for which the Refresh Token was issued. 
client_id | **string**<br>The OAuth client identifier for which the Refresh Token was issued. 
subject_id | **string**<br>The subject identifier for whom the Refresh Token was issued. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Refresh token creation time. 
expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Refresh token expiration time. 
last_used_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp for the last authentication using this Refresh Token. 
protection_level | **[RefreshToken.ProtectionLevel](#RefreshToken)**<br>Protection level of the refresh token. <br>It shows whether DPOP was used to protect the Refresh Token and and the level of security of the storage used for the DPOP key. 


## Revoke {#Revoke}

Revoke Refresh Tokens. Several Refresh Tokens can be revoked by one request.

**rpc Revoke ([RevokeRefreshTokenRequest](#RevokeRefreshTokenRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RevokeRefreshTokenMetadata](#RevokeRefreshTokenMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[RevokeRefreshTokenResponse](#RevokeRefreshTokenResponse)<br>

### RevokeRefreshTokenRequest {#RevokeRefreshTokenRequest}

Field | Description
--- | ---
filter | **oneof:** `refresh_token_id`, `refresh_token` or `revoke_filter`<br>
&nbsp;&nbsp;refresh_token_id | **string**<br>Identifier of the Refresh Token to be revoked. The maximum string length in characters is 50.
&nbsp;&nbsp;refresh_token | **string**<br>The Refresh Token to be revoked. The maximum string length in characters is 1000.
&nbsp;&nbsp;revoke_filter | **[RevokeFilter](#RevokeFilter)**<br>The filter for revoking Refresh Token 


### RevokeFilter {#RevokeFilter}

Field | Description
--- | ---
client_id | **string**<br>The OAuth client identifier for which the Refresh Token was issued. The maximum string length in characters is 50.
subject_id | **string**<br>The subject identifier for whom the Refresh Token was issued. If not specified, it defaults to the subject that made the request. The maximum string length in characters is 50.
client_instance_info | **string**<br>Information about the app for which the Refresh Token was issued. The maximum string length in characters is 1000.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RevokeRefreshTokenMetadata](#RevokeRefreshTokenMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RevokeRefreshTokenResponse](#RevokeRefreshTokenResponse)>**<br>if operation finished successfully. 


### RevokeRefreshTokenMetadata {#RevokeRefreshTokenMetadata}

Field | Description
--- | ---
subject_id | **string**<br> 
refresh_token_ids[] | **string**<br>Id of revoked Refresh Tokens. 


### RevokeRefreshTokenResponse {#RevokeRefreshTokenResponse}

Field | Description
--- | ---
refresh_token_ids[] | **string**<br>Id of revoked Refresh Tokens. 



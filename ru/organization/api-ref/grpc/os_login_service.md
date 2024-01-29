---
editable: false
sourcePath: en/_api-ref-grpc/organization/api-ref/grpc/os_login_service.md
---

# Cloud Organization API, gRPC: OsLoginService



| Call | Description |
| --- | --- |
| [GetSettings](#GetSettings) | OsLogin settings |
| [UpdateSettings](#UpdateSettings) |  |
| [GetProfile](#GetProfile) | OsLogin Profiles |
| [ListProfiles](#ListProfiles) |  |
| [CreateProfile](#CreateProfile) |  |
| [UpdateProfile](#UpdateProfile) |  |
| [SetDefaultProfile](#SetDefaultProfile) | Sets a profile as a default for the subject assigned to this profile |
| [DeleteProfile](#DeleteProfile) |  |

## Calls OsLoginService {#calls}

## GetSettings {#GetSettings}

OsLogin settings

**rpc GetSettings ([GetOsLoginSettingsRequest](#GetOsLoginSettingsRequest)) returns ([OsLoginSettings](#OsLoginSettings))**

### GetOsLoginSettingsRequest {#GetOsLoginSettingsRequest}

Field | Description
--- | ---
organization_id | **string**<br>Required.  The maximum string length in characters is 50.


### OsLoginSettings {#OsLoginSettings}

Field | Description
--- | ---
user_ssh_key_settings | **[UserSshKeySettings](#UserSshKeySettings)**<br> 
ssh_certificate_settings | **[SshCertificateSettings](#SshCertificateSettings)**<br> 


### UserSshKeySettings {#UserSshKeySettings}

Field | Description
--- | ---
enabled | **bool**<br> 
allow_manage_own_keys | **bool**<br> 


### SshCertificateSettings {#SshCertificateSettings}

Field | Description
--- | ---
enabled | **bool**<br> 


## UpdateSettings {#UpdateSettings}



**rpc UpdateSettings ([UpdateOsLoginSettingsRequest](#UpdateOsLoginSettingsRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateOsLoginSettingsMetadata](#UpdateOsLoginSettingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[OsLoginSettings](#OsLoginSettings)<br>

### UpdateOsLoginSettingsRequest {#UpdateOsLoginSettingsRequest}

Field | Description
--- | ---
organization_id | **string**<br>Required.  The maximum string length in characters is 50.
user_ssh_key_settings | **[UserSshKeySettings](#UserSshKeySettings)**<br> 
ssh_certificate_settings | **[SshCertificateSettings](#SshCertificateSettings)**<br> 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 


### UserSshKeySettings {#UserSshKeySettings1}

Field | Description
--- | ---
enabled | **bool**<br> 
allow_manage_own_keys | **bool**<br> 


### SshCertificateSettings {#SshCertificateSettings1}

Field | Description
--- | ---
enabled | **bool**<br> 


### UserSshKeySettings {#UserSshKeySettings1}

Field | Description
--- | ---
enabled | **bool**<br> 
allow_manage_own_keys | **bool**<br> 


### SshCertificateSettings {#SshCertificateSettings2}

Field | Description
--- | ---
enabled | **bool**<br> 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateOsLoginSettingsMetadata](#UpdateOsLoginSettingsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[OsLoginSettings](#OsLoginSettings)>**<br>if operation finished successfully. 


### UpdateOsLoginSettingsMetadata {#UpdateOsLoginSettingsMetadata}

Field | Description
--- | ---
organization_id | **string**<br> 


### OsLoginSettings {#OsLoginSettings1}

Field | Description
--- | ---
user_ssh_key_settings | **[UserSshKeySettings](#UserSshKeySettings)**<br> 
ssh_certificate_settings | **[SshCertificateSettings](#SshCertificateSettings)**<br> 


## GetProfile {#GetProfile}

OsLogin Profiles

**rpc GetProfile ([GetOsLoginProfileRequest](#GetOsLoginProfileRequest)) returns ([OsLoginProfile](#OsLoginProfile))**

### GetOsLoginProfileRequest {#GetOsLoginProfileRequest}

Field | Description
--- | ---
os_login_profile_id | **string**<br>Required.  The maximum string length in characters is 50.


### OsLoginProfile {#OsLoginProfile}

Field | Description
--- | ---
id | **string**<br> 
organization_id | **string**<br> 
subject_id | **string**<br> 
login | **string**<br> 
uid | **int64**<br> 
is_default | **bool**<br> 
home_directory | **string**<br> 
shell | **string**<br> 


## ListProfiles {#ListProfiles}



**rpc ListProfiles ([ListOsLoginProfilesRequest](#ListOsLoginProfilesRequest)) returns ([ListOsLoginProfilesResponse](#ListOsLoginProfilesResponse))**

### ListOsLoginProfilesRequest {#ListOsLoginProfilesRequest}

Field | Description
--- | ---
organization_id | **string**<br>Required.  The maximum string length in characters is 50.
page_size | **int64**<br> Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br> The maximum string length in characters is 2000.
filter | **string**<br>A filter expression that filters profiles listed in the response. The expression must specify: <ol><li>The field name. Currently you can use filtering by subject_id, uid or login. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). </li></ol>E.g. login="example-login" The maximum string length in characters is 1000.


### ListOsLoginProfilesResponse {#ListOsLoginProfilesResponse}

Field | Description
--- | ---
profiles[] | **[OsLoginProfile](#OsLoginProfile)**<br> 
next_page_token | **string**<br> 


### OsLoginProfile {#OsLoginProfile1}

Field | Description
--- | ---
id | **string**<br> 
organization_id | **string**<br> 
subject_id | **string**<br> 
login | **string**<br> 
uid | **int64**<br> 
is_default | **bool**<br> 
home_directory | **string**<br> 
shell | **string**<br> 


## CreateProfile {#CreateProfile}



**rpc CreateProfile ([CreateOsLoginProfileRequest](#CreateOsLoginProfileRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateOsLoginProfileMetadata](#CreateOsLoginProfileMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[OsLoginProfile](#OsLoginProfile)<br>

### CreateOsLoginProfileRequest {#CreateOsLoginProfileRequest}

Field | Description
--- | ---
organization_id | **string**<br>Required.  The maximum string length in characters is 50.
subject_id | **string**<br> The maximum string length in characters is 50.
login | **string**<br>Required.  The maximum string length in characters is 32. Value must match the regular expression ` ^[^.]*?[^~.]$ `.
uid | **int64**<br> Acceptable values are 1 to 9223372036854775807, inclusive.
home_directory | **string**<br> The maximum string length in characters is 255.
shell | **string**<br> The maximum string length in characters is 255.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateOsLoginProfileMetadata](#CreateOsLoginProfileMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[OsLoginProfile](#OsLoginProfile)>**<br>if operation finished successfully. 


### CreateOsLoginProfileMetadata {#CreateOsLoginProfileMetadata}

Field | Description
--- | ---
os_login_profile_id | **string**<br> 
organization_id | **string**<br> 
subject_id | **string**<br> 


### OsLoginProfile {#OsLoginProfile2}

Field | Description
--- | ---
id | **string**<br> 
organization_id | **string**<br> 
subject_id | **string**<br> 
login | **string**<br> 
uid | **int64**<br> 
is_default | **bool**<br> 
home_directory | **string**<br> 
shell | **string**<br> 


## UpdateProfile {#UpdateProfile}



**rpc UpdateProfile ([UpdateOsLoginProfileRequest](#UpdateOsLoginProfileRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateOsLoginProfileMetadata](#UpdateOsLoginProfileMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[OsLoginProfile](#OsLoginProfile)<br>

### UpdateOsLoginProfileRequest {#UpdateOsLoginProfileRequest}

Field | Description
--- | ---
os_login_profile_id | **string**<br>Required.  The maximum string length in characters is 50.
login | **string**<br>Required.  The maximum string length in characters is 32. Value must match the regular expression ` ^[^.]*?[^~.]$ `.
uid | **int64**<br> Acceptable values are 1 to 9223372036854775807, inclusive.
home_directory | **string**<br> The maximum string length in characters is 255.
shell | **string**<br> The maximum string length in characters is 255.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateOsLoginProfileMetadata](#UpdateOsLoginProfileMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[OsLoginProfile](#OsLoginProfile)>**<br>if operation finished successfully. 


### UpdateOsLoginProfileMetadata {#UpdateOsLoginProfileMetadata}

Field | Description
--- | ---
os_login_profile_id | **string**<br> 


### OsLoginProfile {#OsLoginProfile3}

Field | Description
--- | ---
id | **string**<br> 
organization_id | **string**<br> 
subject_id | **string**<br> 
login | **string**<br> 
uid | **int64**<br> 
is_default | **bool**<br> 
home_directory | **string**<br> 
shell | **string**<br> 


## SetDefaultProfile {#SetDefaultProfile}

Sets a profile as a default for the subject assigned to this profile

**rpc SetDefaultProfile ([SetDefaultOsLoginProfileRequest](#SetDefaultOsLoginProfileRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetDefaultOsLoginProfileMetadata](#SetDefaultOsLoginProfileMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[OsLoginProfile](#OsLoginProfile)<br>

### SetDefaultOsLoginProfileRequest {#SetDefaultOsLoginProfileRequest}

Field | Description
--- | ---
os_login_profile_id | **string**<br>Required.  The maximum string length in characters is 50.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SetDefaultOsLoginProfileMetadata](#SetDefaultOsLoginProfileMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[OsLoginProfile](#OsLoginProfile)>**<br>if operation finished successfully. 


### SetDefaultOsLoginProfileMetadata {#SetDefaultOsLoginProfileMetadata}

Field | Description
--- | ---
previous_default_profile_id | **string**<br> 
current_default_profile_id | **string**<br> 


### OsLoginProfile {#OsLoginProfile4}

Field | Description
--- | ---
id | **string**<br> 
organization_id | **string**<br> 
subject_id | **string**<br> 
login | **string**<br> 
uid | **int64**<br> 
is_default | **bool**<br> 
home_directory | **string**<br> 
shell | **string**<br> 


## DeleteProfile {#DeleteProfile}



**rpc DeleteProfile ([DeleteOsLoginProfileRequest](#DeleteOsLoginProfileRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteOsLoginProfileMetadata](#DeleteOsLoginProfileMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteOsLoginProfileRequest {#DeleteOsLoginProfileRequest}

Field | Description
--- | ---
id | **string**<br>Required.  The maximum string length in characters is 50.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteOsLoginProfileMetadata](#DeleteOsLoginProfileMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteOsLoginProfileMetadata {#DeleteOsLoginProfileMetadata}

Field | Description
--- | ---
os_login_profile_id | **string**<br> 



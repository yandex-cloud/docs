# On-premises Yandex Object Storage gRPC API reference

## Table of Contents

- [grestinpb/tenants.proto](#grestinpb_tenants-proto)
    - [ActivateTenantRequest](#grestin-ActivateTenantRequest)
    - [ActivateTenantResponse](#grestin-ActivateTenantResponse)
    - [CreateTenantRequest](#grestin-CreateTenantRequest)
    - [CreateTenantResponse](#grestin-CreateTenantResponse)
    - [DeleteTenantRequest](#grestin-DeleteTenantRequest)
    - [DeleteTenantResponse](#grestin-DeleteTenantResponse)
    - [GetTenantRequest](#grestin-GetTenantRequest)
    - [GetTenantResponse](#grestin-GetTenantResponse)
    - [ListTenantsRequest](#grestin-ListTenantsRequest)
    - [ListTenantsResponse](#grestin-ListTenantsResponse)
    - [Tenant](#grestin-Tenant)
    - [UpdateTenantRequest](#grestin-UpdateTenantRequest)
    - [UpdateTenantResponse](#grestin-UpdateTenantResponse)
  
    - [TenantStatus](#grestin-TenantStatus)
  
    - [TenantsService](#grestin-TenantsService)
  
- [grestinpb/auth.proto](#grestinpb_auth-proto)
    - [AuthRequest](#grestin-AuthRequest)
    - [AuthResponse](#grestin-AuthResponse)
    - [AuthResponse.Roles](#grestin-AuthResponse-Roles)
    - [AuthenticateRequest](#grestin-AuthenticateRequest)
    - [TenantAuthRequest](#grestin-TenantAuthRequest)
  
    - [Role](#grestin-Role)
  
    - [TokenService](#grestin-TokenService)
  
- [tenants/tenantpb/control.proto](#tenants_tenantpb_control-proto)
    - [CheckTenantRequest](#tenant-CheckTenantRequest)
    - [CheckTenantRequest.Active](#tenant-CheckTenantRequest-Active)
    - [CheckTenantRequest.CanActivate](#tenant-CheckTenantRequest-CanActivate)
    - [CheckTenantRequest.CanDelete](#tenant-CheckTenantRequest-CanDelete)
    - [CheckTenantRequest.Deleted](#tenant-CheckTenantRequest-Deleted)
    - [CheckTenantResponse](#tenant-CheckTenantResponse)
    - [CreateTenantRequest](#tenant-CreateTenantRequest)
    - [CreateTenantResponse](#tenant-CreateTenantResponse)
    - [DeleteTenantRequest](#tenant-DeleteTenantRequest)
    - [DeleteTenantResponse](#tenant-DeleteTenantResponse)
    - [PostEventRequest](#tenant-PostEventRequest)
    - [PostEventResponse](#tenant-PostEventResponse)
    - [Tenant](#tenant-Tenant)
    - [TenantMetaRecord](#tenant-TenantMetaRecord)
  
    - [EventsService](#tenant-EventsService)
    - [TenantService](#tenant-TenantService)
  
- [tenants/bender/benderpb/access_keys.proto](#tenants_bender_benderpb_access_keys-proto)
    - [AccessKey](#bender-AccessKey)
    - [CreateAccessKeyRequest](#bender-CreateAccessKeyRequest)
    - [CreateAccessKeyResponse](#bender-CreateAccessKeyResponse)
    - [DeleteAccessKeyRequest](#bender-DeleteAccessKeyRequest)
    - [DeleteAccessKeyResponse](#bender-DeleteAccessKeyResponse)
    - [ListAccessKeysRequest](#bender-ListAccessKeysRequest)
    - [ListAccessKeysResponse](#bender-ListAccessKeysResponse)
  
    - [AccessKeysService](#bender-AccessKeysService)
  
- [tenants/bender/benderpb/buckets.proto](#tenants_bender_benderpb_buckets-proto)
    - [ACL](#bender-ACL)
    - [ACL.Grant](#bender-ACL-Grant)
    - [Bucket](#bender-Bucket)
    - [CorsRule](#bender-CorsRule)
    - [CreateBucketRequest](#bender-CreateBucketRequest)
    - [CreateBucketResponse](#bender-CreateBucketResponse)
    - [DeleteBucketRequest](#bender-DeleteBucketRequest)
    - [DeleteBucketResponse](#bender-DeleteBucketResponse)
    - [GetBucketRequest](#bender-GetBucketRequest)
    - [GetBucketResponse](#bender-GetBucketResponse)
    - [LifecycleRule](#bender-LifecycleRule)
    - [LifecycleRule.AfterDays](#bender-LifecycleRule-AfterDays)
    - [LifecycleRule.Expiration](#bender-LifecycleRule-Expiration)
    - [LifecycleRule.NoncurrentDeleteMarkers](#bender-LifecycleRule-NoncurrentDeleteMarkers)
    - [LifecycleRule.NoncurrentExpiration](#bender-LifecycleRule-NoncurrentExpiration)
    - [LifecycleRule.NoncurrentTransition](#bender-LifecycleRule-NoncurrentTransition)
    - [LifecycleRule.RuleFilter](#bender-LifecycleRule-RuleFilter)
    - [LifecycleRule.RuleFilter.And](#bender-LifecycleRule-RuleFilter-And)
    - [LifecycleRule.Transition](#bender-LifecycleRule-Transition)
    - [ListBucketsRequest](#bender-ListBucketsRequest)
    - [ListBucketsResponse](#bender-ListBucketsResponse)
    - [ObjectLock](#bender-ObjectLock)
    - [ObjectLock.DefaultRetention](#bender-ObjectLock-DefaultRetention)
    - [Tag](#bender-Tag)
    - [UpdateBucketRequest](#bender-UpdateBucketRequest)
    - [UpdateBucketResponse](#bender-UpdateBucketResponse)
  
    - [ACL.Grant.GrantType](#bender-ACL-Grant-GrantType)
    - [ACL.Grant.Permission](#bender-ACL-Grant-Permission)
    - [CorsRule.Method](#bender-CorsRule-Method)
    - [ObjectLock.DefaultRetention.Mode](#bender-ObjectLock-DefaultRetention-Mode)
    - [ObjectLock.ObjectLockStatus](#bender-ObjectLock-ObjectLockStatus)
    - [Versioning](#bender-Versioning)
  
    - [BucketsService](#bender-BucketsService)
  
- [tenants/bender/benderpb/common.proto](#tenants_bender_benderpb_common-proto)
    - [GetGlobalSettingsRequest](#bender-GetGlobalSettingsRequest)
    - [GetGlobalSettingsResponse](#bender-GetGlobalSettingsResponse)
    - [GlobalSettings](#bender-GlobalSettings)
    - [GlobalSettings.StorageClasses](#bender-GlobalSettings-StorageClasses)
    - [GlobalSettings.StorageClasses.StorageClass](#bender-GlobalSettings-StorageClasses-StorageClass)
    - [ListEventsRequest](#bender-ListEventsRequest)
    - [ListEventsResponse](#bender-ListEventsResponse)
  
    - [EventsService](#bender-EventsService)
    - [SettingsService](#bender-SettingsService)
  
- [tenants/bender/benderpb/service_accounts.proto](#tenants_bender_benderpb_service_accounts-proto)
    - [CreateServiceAccountRequest](#bender-CreateServiceAccountRequest)
    - [CreateServiceAccountResponse](#bender-CreateServiceAccountResponse)
    - [DeleteServiceAccountRequest](#bender-DeleteServiceAccountRequest)
    - [DeleteServiceAccountResponse](#bender-DeleteServiceAccountResponse)
    - [GetServiceAccountRequest](#bender-GetServiceAccountRequest)
    - [GetServiceAccountResponse](#bender-GetServiceAccountResponse)
    - [ListServiceAccountsRequest](#bender-ListServiceAccountsRequest)
    - [ListServiceAccountsResponse](#bender-ListServiceAccountsResponse)
    - [ServiceAccount](#bender-ServiceAccount)
    - [ServiceAccountWithKeysCount](#bender-ServiceAccountWithKeysCount)
    - [UpdateServiceAccountRequest](#bender-UpdateServiceAccountRequest)
    - [UpdateServiceAccountResponse](#bender-UpdateServiceAccountResponse)
    - [UpdateServiceAccountRoleRequest](#bender-UpdateServiceAccountRoleRequest)
    - [UpdateServiceAccountRoleResponse](#bender-UpdateServiceAccountRoleResponse)
  
    - [Role](#bender-Role)
  
    - [ServiceAccountsService](#bender-ServiceAccountsService)
  
- [tenants/bender/benderpb/s3quotas.proto](#tenants_bender_benderpb_s3quotas-proto)
    - [GetS3QuotaRequest](#bender-GetS3QuotaRequest)
    - [GetS3QuotaResponse](#bender-GetS3QuotaResponse)
    - [ListS3QuotasRequest](#bender-ListS3QuotasRequest)
    - [ListS3QuotasResponse](#bender-ListS3QuotasResponse)
    - [S3Quota](#bender-S3Quota)
    - [UpdateS3QuotaRequest](#bender-UpdateS3QuotaRequest)
    - [UpdateS3QuotaResponse](#bender-UpdateS3QuotaResponse)
  
    - [S3QuotaService](#bender-S3QuotaService)
  
- [tenants/fry/authpb/user_roles.proto](#tenants_fry_authpb_user_roles-proto)
    - [GetUserInfoRequest](#fryauth-GetUserInfoRequest)
    - [GetUserInfoResponse](#fryauth-GetUserInfoResponse)
    - [GetUserRoleRequest](#fryauth-GetUserRoleRequest)
    - [GetUserRoleResponse](#fryauth-GetUserRoleResponse)
    - [ListUserTenantsRequest](#fryauth-ListUserTenantsRequest)
    - [ListUserTenantsResponse](#fryauth-ListUserTenantsResponse)
    - [ListUserTenantsResponse.Membership](#fryauth-ListUserTenantsResponse-Membership)
  
    - [Role](#fryauth-Role)
  
    - [UserAuthService](#fryauth-UserAuthService)
  
- [tenants/fry/frypb/applications.proto](#tenants_fry_frypb_applications-proto)
    - [GetAppSettingsRequest](#fry-GetAppSettingsRequest)
    - [GetAppSettingsResponse](#fry-GetAppSettingsResponse)
  
    - [Application](#fry-Application)
  
    - [Applications](#fry-Applications)
  
- [tenants/fry/frypb/settings.proto](#tenants_fry_frypb_settings-proto)
    - [CheckConfiguredRequest](#fry-CheckConfiguredRequest)
    - [CheckConfiguredResponse](#fry-CheckConfiguredResponse)
    - [GetLoginSettingRequest](#fry-GetLoginSettingRequest)
    - [GetLoginSettingsResponse](#fry-GetLoginSettingsResponse)
    - [SetupLoginRequest](#fry-SetupLoginRequest)
    - [SetupLoginResponse](#fry-SetupLoginResponse)
  
    - [SettingsService](#fry-SettingsService)
  
- [tenants/fry/frypb/users.proto](#tenants_fry_frypb_users-proto)
    - [AddUserRequest](#fry-AddUserRequest)
    - [AddUserResponse](#fry-AddUserResponse)
    - [ChangeMemberRequest](#fry-ChangeMemberRequest)
    - [ChangeMemberResponse](#fry-ChangeMemberResponse)
    - [GetUserRequest](#fry-GetUserRequest)
    - [GetUserResponse](#fry-GetUserResponse)
    - [ListMembersRequest](#fry-ListMembersRequest)
    - [ListMembersResponse](#fry-ListMembersResponse)
    - [ListUsersRequest](#fry-ListUsersRequest)
    - [ListUsersResponse](#fry-ListUsersResponse)
    - [LockUserRequest](#fry-LockUserRequest)
    - [LockUserResponse](#fry-LockUserResponse)
    - [MemberRole](#fry-MemberRole)
    - [TenantMember](#fry-TenantMember)
    - [UnlockUserRequest](#fry-UnlockUserRequest)
    - [UnlockUserResponse](#fry-UnlockUserResponse)
    - [User](#fry-User)
    - [WhoAmIRequest](#fry-WhoAmIRequest)
    - [WhoAmIResponse](#fry-WhoAmIResponse)
  
    - [Role](#fry-Role)
  
    - [TenantMembersService](#fry-TenantMembersService)
    - [UsersService](#fry-UsersService)
  
- [Scalar Value Types](#scalar-value-types)



<a name="grestinpb_tenants-proto"></a>


## grestinpb/tenants.proto



<a name="grestin-ActivateTenantRequest"></a>

### ActivateTenantRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) |  |  |






<a name="grestin-ActivateTenantResponse"></a>

### ActivateTenantResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [Tenant](#grestin-Tenant) |  |  |






<a name="grestin-CreateTenantRequest"></a>

### CreateTenantRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  |  |






<a name="grestin-CreateTenantResponse"></a>

### CreateTenantResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [Tenant](#grestin-Tenant) |  |  |






<a name="grestin-DeleteTenantRequest"></a>

### DeleteTenantRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) |  |  |






<a name="grestin-DeleteTenantResponse"></a>

### DeleteTenantResponse







<a name="grestin-GetTenantRequest"></a>

### GetTenantRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) |  |  |






<a name="grestin-GetTenantResponse"></a>

### GetTenantResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [Tenant](#grestin-Tenant) |  |  |






<a name="grestin-ListTenantsRequest"></a>

### ListTenantsRequest







<a name="grestin-ListTenantsResponse"></a>

### ListTenantsResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenants | [Tenant](#grestin-Tenant) | repeated |  |






<a name="grestin-Tenant"></a>

### Tenant



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) |  |  |
| name | [string](#string) |  |  |
| status | [TenantStatus](#grestin-TenantStatus) |  |  |






<a name="grestin-UpdateTenantRequest"></a>

### UpdateTenantRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) |  |  |
| name | [string](#string) |  |  |






<a name="grestin-UpdateTenantResponse"></a>

### UpdateTenantResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [Tenant](#grestin-Tenant) |  |  |





 


<a name="grestin-TenantStatus"></a>

### TenantStatus


| Name | Number | Description |
| ---- | ------ | ----------- |
| TS_UNSPECIFIED | 0 |  |
| TS_CREATING | 1 |  |
| TS_ACTIVE | 2 |  |
| TS_BROKEN | 3 |  |
| TS_DELETING | 4 |  |
| TS_DELETED | 5 |  |


 

 


<a name="grestin-TenantsService"></a>

### TenantsService


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| GetTenant | [GetTenantRequest](#grestin-GetTenantRequest) | [GetTenantResponse](#grestin-GetTenantResponse) |  |
| ListTenants | [ListTenantsRequest](#grestin-ListTenantsRequest) | [ListTenantsResponse](#grestin-ListTenantsResponse) |  |
| CreateTenant | [CreateTenantRequest](#grestin-CreateTenantRequest) | [CreateTenantResponse](#grestin-CreateTenantResponse) |  |
| UpdateTenant | [UpdateTenantRequest](#grestin-UpdateTenantRequest) | [UpdateTenantResponse](#grestin-UpdateTenantResponse) |  |
| DeleteTenant | [DeleteTenantRequest](#grestin-DeleteTenantRequest) | [DeleteTenantResponse](#grestin-DeleteTenantResponse) |  |
| ActivateTenant | [ActivateTenantRequest](#grestin-ActivateTenantRequest) | [ActivateTenantResponse](#grestin-ActivateTenantResponse) |  |

 



<a name="grestinpb_auth-proto"></a>


## grestinpb/auth.proto



<a name="grestin-AuthRequest"></a>

### AuthRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| audience | [string](#string) | repeated |  |






<a name="grestin-AuthResponse"></a>

### AuthResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| token | [string](#string) |  |  |
| assigned_roles | [AuthResponse.Roles](#grestin-AuthResponse-Roles) | repeated |  |
| tenant | [string](#string) |  |  |
| expires_at | [google.protobuf.Timestamp](#google-protobuf-Timestamp) |  |  |
| username | [string](#string) |  |  |






<a name="grestin-AuthResponse-Roles"></a>

### AuthResponse.Roles



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| audience | [string](#string) |  |  |
| role | [Role](#grestin-Role) |  |  |






<a name="grestin-AuthenticateRequest"></a>

### AuthenticateRequest







<a name="grestin-TenantAuthRequest"></a>

### TenantAuthRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| audience | [string](#string) | repeated |  |
| tenant | [string](#string) |  |  |





 


<a name="grestin-Role"></a>

### Role


| Name | Number | Description |
| ---- | ------ | ----------- |
| R_UNSPECIFIED | 0 |  |
| R_VIEWER | 1 |  |
| R_EDITOR | 2 |  |
| R_ADMIN | 3 |  |
| R_BUCKET_MANAGER | 4 |  |


 

 


<a name="grestin-TokenService"></a>

### TokenService


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| Auth | [AuthRequest](#grestin-AuthRequest) | [AuthResponse](#grestin-AuthResponse) |  |
| TenantAuth | [TenantAuthRequest](#grestin-TenantAuthRequest) | [AuthResponse](#grestin-AuthResponse) |  |
| Authenticate | [AuthenticateRequest](#grestin-AuthenticateRequest) | [AuthResponse](#grestin-AuthResponse) |  |

 



<a name="tenants_tenantpb_control-proto"></a>


## tenants/tenantpb/control.proto



<a name="tenant-CheckTenantRequest"></a>

### CheckTenantRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [Tenant](#tenant-Tenant) |  |  |
| can_activate | [CheckTenantRequest.CanActivate](#tenant-CheckTenantRequest-CanActivate) |  |  |
| active | [CheckTenantRequest.Active](#tenant-CheckTenantRequest-Active) |  |  |
| can_delete | [CheckTenantRequest.CanDelete](#tenant-CheckTenantRequest-CanDelete) |  |  |
| deleted | [CheckTenantRequest.Deleted](#tenant-CheckTenantRequest-Deleted) |  |  |






<a name="tenant-CheckTenantRequest-Active"></a>

### CheckTenantRequest.Active







<a name="tenant-CheckTenantRequest-CanActivate"></a>

### CheckTenantRequest.CanActivate







<a name="tenant-CheckTenantRequest-CanDelete"></a>

### CheckTenantRequest.CanDelete







<a name="tenant-CheckTenantRequest-Deleted"></a>

### CheckTenantRequest.Deleted







<a name="tenant-CheckTenantResponse"></a>

### CheckTenantResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [Tenant](#tenant-Tenant) |  |  |
| passed | [bool](#bool) |  |  |






<a name="tenant-CreateTenantRequest"></a>

### CreateTenantRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| system | [string](#string) |  |  |
| tenant_id | [string](#string) |  |  |






<a name="tenant-CreateTenantResponse"></a>

### CreateTenantResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [Tenant](#tenant-Tenant) |  |  |






<a name="tenant-DeleteTenantRequest"></a>

### DeleteTenantRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [Tenant](#tenant-Tenant) |  |  |






<a name="tenant-DeleteTenantResponse"></a>

### DeleteTenantResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| system | [string](#string) |  |  |
| tenant_id | [string](#string) |  |  |






<a name="tenant-PostEventRequest"></a>

### PostEventRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| event | [bytes](#bytes) |  | Event data as json bytes |






<a name="tenant-PostEventResponse"></a>

### PostEventResponse







<a name="tenant-Tenant"></a>

### Tenant



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| system | [string](#string) |  |  |
| tenant_id | [string](#string) |  |  |
| system_id | [string](#string) |  |  |
| meta | [TenantMetaRecord](#tenant-TenantMetaRecord) | repeated |  |






<a name="tenant-TenantMetaRecord"></a>

### TenantMetaRecord



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](#string) |  |  |
| value | [string](#string) |  |  |





 

 

 


<a name="tenant-EventsService"></a>

### EventsService


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| Post | [PostEventRequest](#tenant-PostEventRequest) | [PostEventResponse](#tenant-PostEventResponse) |  |


<a name="tenant-TenantService"></a>

### TenantService


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| Create | [CreateTenantRequest](#tenant-CreateTenantRequest) | [CreateTenantResponse](#tenant-CreateTenantResponse) |  |
| Delete | [DeleteTenantRequest](#tenant-DeleteTenantRequest) | [DeleteTenantResponse](#tenant-DeleteTenantResponse) |  |
| Check | [CheckTenantRequest](#tenant-CheckTenantRequest) | [CheckTenantResponse](#tenant-CheckTenantResponse) |  |

 



<a name="tenants_bender_benderpb_access_keys-proto"></a>


## tenants/bender/benderpb/access_keys.proto



<a name="bender-AccessKey"></a>

### AccessKey



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| sa_id | [string](#string) |  |  |
| key_id | [string](#string) |  |  |
| created_at | [string](#string) |  |  |






<a name="bender-CreateAccessKeyRequest"></a>

### CreateAccessKeyRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |
| sa_id | [string](#string) |  |  |






<a name="bender-CreateAccessKeyResponse"></a>

### CreateAccessKeyResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| access_key | [AccessKey](#bender-AccessKey) |  |  |
| secret_access_key | [string](#string) |  |  |






<a name="bender-DeleteAccessKeyRequest"></a>

### DeleteAccessKeyRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |
| sa_id | [string](#string) |  |  |
| access_key_id | [string](#string) |  |  |






<a name="bender-DeleteAccessKeyResponse"></a>

### DeleteAccessKeyResponse







<a name="bender-ListAccessKeysRequest"></a>

### ListAccessKeysRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |
| sa_id | [string](#string) |  |  |






<a name="bender-ListAccessKeysResponse"></a>

### ListAccessKeysResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| access_keys | [AccessKey](#bender-AccessKey) | repeated |  |





 

 

 


<a name="bender-AccessKeysService"></a>

### AccessKeysService


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| ListAccessKeys | [ListAccessKeysRequest](#bender-ListAccessKeysRequest) | [ListAccessKeysResponse](#bender-ListAccessKeysResponse) |  |
| CreateAccessKey | [CreateAccessKeyRequest](#bender-CreateAccessKeyRequest) | [CreateAccessKeyResponse](#bender-CreateAccessKeyResponse) |  |
| DeleteAccessKey | [DeleteAccessKeyRequest](#bender-DeleteAccessKeyRequest) | [DeleteAccessKeyResponse](#bender-DeleteAccessKeyResponse) |  |

 



<a name="tenants_bender_benderpb_buckets-proto"></a>


## tenants/bender/benderpb/buckets.proto



<a name="bender-ACL"></a>

### ACL



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| grants | [ACL.Grant](#bender-ACL-Grant) | repeated |  |






<a name="bender-ACL-Grant"></a>

### ACL.Grant



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| permission | [ACL.Grant.Permission](#bender-ACL-Grant-Permission) |  |  |
| grant_type | [ACL.Grant.GrantType](#bender-ACL-Grant-GrantType) |  |  |
| grantee_id | [string](#string) |  | [semi-optional] grantee id is used only when grant_type is TO_ACCOUNT |






<a name="bender-Bucket"></a>

### Bucket



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  |  |
| size | [uint64](#uint64) |  |  |
| max_size | [uint64](#uint64) |  |  |
| storage_class | [string](#string) |  |  |
| policy | [google.protobuf.Struct](#google-protobuf-Struct) |  |  |
| acl | [ACL](#bender-ACL) |  |  |
| lifecycle_rules | [LifecycleRule](#bender-LifecycleRule) | repeated |  |
| cors | [CorsRule](#bender-CorsRule) | repeated |  |
| tags | [Tag](#bender-Tag) | repeated |  |
| versioning | [Versioning](#bender-Versioning) |  |  |
| object_lock | [ObjectLock](#bender-ObjectLock) |  |  |
| tenant | [string](#string) |  |  |






<a name="bender-CorsRule"></a>

### CorsRule



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) |  |  |
| allowed_methods | [CorsRule.Method](#bender-CorsRule-Method) | repeated |  |
| allowed_headers | [string](#string) | repeated | allowed_headers elements might be either as exact value (i.e. Test-Header-Field) or as pattern (i.e. Test-*-Field) But only one star allowed. |
| allowed_origins | [string](#string) | repeated | allowed_origins elements might be either as exact value (i.e. some-value) or as pattern (i.e. some*value) But only one star allowed. |
| expose_headers | [string](#string) | repeated |  |
| max_age_seconds | [google.protobuf.Int64Value](#google-protobuf-Int64Value) |  |  |






<a name="bender-CreateBucketRequest"></a>

### CreateBucketRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |
| name | [string](#string) |  |  |
| storage_class | [string](#string) |  |  |
| max_size | [uint64](#uint64) |  |  |
| acl | [ACL](#bender-ACL) |  |  |
| tags | [Tag](#bender-Tag) | repeated |  |
| versioning | [Versioning](#bender-Versioning) |  |  |






<a name="bender-CreateBucketResponse"></a>

### CreateBucketResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| bucket | [Bucket](#bender-Bucket) |  |  |






<a name="bender-DeleteBucketRequest"></a>

### DeleteBucketRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |
| name | [string](#string) |  |  |






<a name="bender-DeleteBucketResponse"></a>

### DeleteBucketResponse







<a name="bender-GetBucketRequest"></a>

### GetBucketRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |
| name | [string](#string) |  |  |






<a name="bender-GetBucketResponse"></a>

### GetBucketResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| bucket | [Bucket](#bender-Bucket) |  |  |






<a name="bender-LifecycleRule"></a>

### LifecycleRule



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [google.protobuf.StringValue](#google-protobuf-StringValue) |  |  |
| enabled | [bool](#bool) |  |  |
| filter | [LifecycleRule.RuleFilter](#bender-LifecycleRule-RuleFilter) |  |  |
| expiration | [LifecycleRule.Expiration](#bender-LifecycleRule-Expiration) |  |  |
| transitions | [LifecycleRule.Transition](#bender-LifecycleRule-Transition) | repeated |  |
| abort_incomplete_multipart_upload | [LifecycleRule.AfterDays](#bender-LifecycleRule-AfterDays) |  |  |
| noncurrent_expiration | [LifecycleRule.NoncurrentExpiration](#bender-LifecycleRule-NoncurrentExpiration) |  |  |
| noncurrent_transitions | [LifecycleRule.NoncurrentTransition](#bender-LifecycleRule-NoncurrentTransition) | repeated |  |
| noncurrent_delete_markers | [LifecycleRule.NoncurrentDeleteMarkers](#bender-LifecycleRule-NoncurrentDeleteMarkers) |  |  |






<a name="bender-LifecycleRule-AfterDays"></a>

### LifecycleRule.AfterDays



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| days_after_expiration | [google.protobuf.Int64Value](#google-protobuf-Int64Value) |  |  |






<a name="bender-LifecycleRule-Expiration"></a>

### LifecycleRule.Expiration



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| date | [google.protobuf.Timestamp](#google-protobuf-Timestamp) |  | If date is set, days parameter not allowed |
| days | [google.protobuf.Int64Value](#google-protobuf-Int64Value) |  | If days are set, date parameter not allowed |
| expired_object_delete_marker | [google.protobuf.BoolValue](#google-protobuf-BoolValue) |  | if expired_object_delete_marker is set, other parameters are not allowed. |






<a name="bender-LifecycleRule-NoncurrentDeleteMarkers"></a>

### LifecycleRule.NoncurrentDeleteMarkers



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| noncurrent_days | [google.protobuf.Int64Value](#google-protobuf-Int64Value) |  |  |






<a name="bender-LifecycleRule-NoncurrentExpiration"></a>

### LifecycleRule.NoncurrentExpiration



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| noncurrent_days | [google.protobuf.Int64Value](#google-protobuf-Int64Value) |  |  |






<a name="bender-LifecycleRule-NoncurrentTransition"></a>

### LifecycleRule.NoncurrentTransition



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| noncurrent_days | [google.protobuf.Int64Value](#google-protobuf-Int64Value) |  |  |
| storage_class | [string](#string) |  |  |






<a name="bender-LifecycleRule-RuleFilter"></a>

### LifecycleRule.RuleFilter



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| prefix | [string](#string) |  |  |
| object_size_greater_than | [google.protobuf.Int64Value](#google-protobuf-Int64Value) |  |  |
| object_size_less_than | [google.protobuf.Int64Value](#google-protobuf-Int64Value) |  |  |
| tag | [Tag](#bender-Tag) |  |  |
| and_operator | [LifecycleRule.RuleFilter.And](#bender-LifecycleRule-RuleFilter-And) |  |  |






<a name="bender-LifecycleRule-RuleFilter-And"></a>

### LifecycleRule.RuleFilter.And



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| prefix | [string](#string) |  |  |
| object_size_greater_than | [google.protobuf.Int64Value](#google-protobuf-Int64Value) |  |  |
| object_size_less_than | [google.protobuf.Int64Value](#google-protobuf-Int64Value) |  |  |
| tag | [Tag](#bender-Tag) | repeated |  |






<a name="bender-LifecycleRule-Transition"></a>

### LifecycleRule.Transition



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| date | [google.protobuf.Timestamp](#google-protobuf-Timestamp) |  |  |
| days | [google.protobuf.Int64Value](#google-protobuf-Int64Value) |  |  |
| storage_class | [string](#string) |  |  |






<a name="bender-ListBucketsRequest"></a>

### ListBucketsRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |






<a name="bender-ListBucketsResponse"></a>

### ListBucketsResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| buckets | [Bucket](#bender-Bucket) | repeated |  |






<a name="bender-ObjectLock"></a>

### ObjectLock



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| status | [ObjectLock.ObjectLockStatus](#bender-ObjectLock-ObjectLockStatus) |  |  |
| default_retention | [ObjectLock.DefaultRetention](#bender-ObjectLock-DefaultRetention) |  |  |






<a name="bender-ObjectLock-DefaultRetention"></a>

### ObjectLock.DefaultRetention



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| mode | [ObjectLock.DefaultRetention.Mode](#bender-ObjectLock-DefaultRetention-Mode) |  |  |
| days | [int64](#int64) |  |  |
| years | [int64](#int64) |  |  |






<a name="bender-Tag"></a>

### Tag



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](#string) |  |  |
| value | [string](#string) |  |  |






<a name="bender-UpdateBucketRequest"></a>

### UpdateBucketRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |
| name | [string](#string) |  |  |
| max_size | [uint64](#uint64) |  |  |
| storage_class | [string](#string) |  |  |
| update_mask | [google.protobuf.FieldMask](#google-protobuf-FieldMask) |  | update_mask is used to point on fields that should be updated. Use * for full update. |
| policy | [google.protobuf.Struct](#google-protobuf-Struct) |  |  |
| acl | [ACL](#bender-ACL) |  |  |
| lifecycle_rules | [LifecycleRule](#bender-LifecycleRule) | repeated |  |
| cors | [CorsRule](#bender-CorsRule) | repeated |  |
| tags | [Tag](#bender-Tag) | repeated |  |
| versioning | [Versioning](#bender-Versioning) |  |  |
| object_lock | [ObjectLock](#bender-ObjectLock) |  |  |






<a name="bender-UpdateBucketResponse"></a>

### UpdateBucketResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| bucket | [Bucket](#bender-Bucket) |  |  |





 


<a name="bender-ACL-Grant-GrantType"></a>

### ACL.Grant.GrantType


| Name | Number | Description |
| ---- | ------ | ----------- |
| GRANT_TYPE_UNSPECIFIED | 0 |  |
| GRANT_TYPE_ACCOUNT | 1 | equal to &#39;id&#39; grantee value |
| GRANT_TYPE_ALL_AUTHENTICATED_USERS | 2 | equal to &#39;uri&#39; authenticated users |
| GRANT_TYPE_ALL_USERS | 3 | equal to &#39;uri&#39; all users |



<a name="bender-ACL-Grant-Permission"></a>

### ACL.Grant.Permission


| Name | Number | Description |
| ---- | ------ | ----------- |
| PERMISSION_UNSPECIFIED | 0 |  |
| PERMISSION_FULL_CONTROL | 1 | header X-Amz-Grant-Full-Control |
| PERMISSION_WRITE | 2 | header X-Amz-Grant-Write |
| PERMISSION_WRITE_ACP | 3 | header X-Amz-Grant-Write-Acp |
| PERMISSION_READ | 4 | header X-Amz-Grant-Read |
| PERMISSION_READ_ACP | 5 | header X-Amz-Grant-Read-Acp |



<a name="bender-CorsRule-Method"></a>

### CorsRule.Method


| Name | Number | Description |
| ---- | ------ | ----------- |
| METHOD_UNSPECIFIED | 0 |  |
| METHOD_GET | 1 |  |
| METHOD_HEAD | 2 |  |
| METHOD_POST | 3 |  |
| METHOD_PUT | 4 |  |
| METHOD_DELETE | 5 |  |



<a name="bender-ObjectLock-DefaultRetention-Mode"></a>

### ObjectLock.DefaultRetention.Mode


| Name | Number | Description |
| ---- | ------ | ----------- |
| MODE_UNSPECIFIED | 0 |  |
| MODE_GOVERNANCE | 1 |  |
| MODE_COMPLIANCE | 2 |  |



<a name="bender-ObjectLock-ObjectLockStatus"></a>

### ObjectLock.ObjectLockStatus


| Name | Number | Description |
| ---- | ------ | ----------- |
| OBJECT_LOCK_STATUS_UNSPECIFIED | 0 |  |
| OBJECT_LOCK_STATUS_DISABLED | 1 |  |
| OBJECT_LOCK_STATUS_ENABLED | 2 |  |



<a name="bender-Versioning"></a>

### Versioning


| Name | Number | Description |
| ---- | ------ | ----------- |
| VERSIONING_UNSPECIFIED | 0 |  |
| VERSIONING_DISABLED | 1 |  |
| VERSIONING_ENABLED | 2 |  |
| VERSIONING_SUSPENDED | 3 |  |


 

 


<a name="bender-BucketsService"></a>

### BucketsService


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| ListBuckets | [ListBucketsRequest](#bender-ListBucketsRequest) | [ListBucketsResponse](#bender-ListBucketsResponse) |  |
| CreateBucket | [CreateBucketRequest](#bender-CreateBucketRequest) | [CreateBucketResponse](#bender-CreateBucketResponse) |  |
| GetBucket | [GetBucketRequest](#bender-GetBucketRequest) | [GetBucketResponse](#bender-GetBucketResponse) |  |
| UpdateBucket | [UpdateBucketRequest](#bender-UpdateBucketRequest) | [UpdateBucketResponse](#bender-UpdateBucketResponse) |  |
| DeleteBucket | [DeleteBucketRequest](#bender-DeleteBucketRequest) | [DeleteBucketResponse](#bender-DeleteBucketResponse) |  |

 



<a name="tenants_bender_benderpb_common-proto"></a>


## tenants/bender/benderpb/common.proto



<a name="bender-GetGlobalSettingsRequest"></a>

### GetGlobalSettingsRequest







<a name="bender-GetGlobalSettingsResponse"></a>

### GetGlobalSettingsResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| settings | [GlobalSettings](#bender-GlobalSettings) |  |  |






<a name="bender-GlobalSettings"></a>

### GlobalSettings



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| fair_transition_enabled | [bool](#bool) |  |  |
| storage_classes | [GlobalSettings.StorageClasses](#bender-GlobalSettings-StorageClasses) |  |  |






<a name="bender-GlobalSettings-StorageClasses"></a>

### GlobalSettings.StorageClasses



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| default_class | [string](#string) |  |  |
| storage_classes | [GlobalSettings.StorageClasses.StorageClass](#bender-GlobalSettings-StorageClasses-StorageClass) | repeated |  |






<a name="bender-GlobalSettings-StorageClasses-StorageClass"></a>

### GlobalSettings.StorageClasses.StorageClass



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [string](#string) |  |  |






<a name="bender-ListEventsRequest"></a>

### ListEventsRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant_id | [string](#string) |  |  |
| created_after | [google.protobuf.Timestamp](#google-protobuf-Timestamp) |  |  |
| created_before | [google.protobuf.Timestamp](#google-protobuf-Timestamp) |  |  |
| limit | [int64](#int64) |  |  |






<a name="bender-ListEventsResponse"></a>

### ListEventsResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| events | [string](#string) | repeated | JSON-encoded events |
| next_token | [google.protobuf.Timestamp](#google-protobuf-Timestamp) |  |  |





 

 

 


<a name="bender-EventsService"></a>

### EventsService


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| ListEvents | [ListEventsRequest](#bender-ListEventsRequest) | [ListEventsResponse](#bender-ListEventsResponse) |  |


<a name="bender-SettingsService"></a>

### SettingsService


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| GetGlobalSettings | [GetGlobalSettingsRequest](#bender-GetGlobalSettingsRequest) | [GetGlobalSettingsResponse](#bender-GetGlobalSettingsResponse) |  |

 



<a name="tenants_bender_benderpb_service_accounts-proto"></a>


## tenants/bender/benderpb/service_accounts.proto



<a name="bender-CreateServiceAccountRequest"></a>

### CreateServiceAccountRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |
| name | [string](#string) |  |  |
| role | [Role](#bender-Role) |  |  |






<a name="bender-CreateServiceAccountResponse"></a>

### CreateServiceAccountResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| sa | [ServiceAccount](#bender-ServiceAccount) |  |  |






<a name="bender-DeleteServiceAccountRequest"></a>

### DeleteServiceAccountRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |
| id | [string](#string) |  |  |






<a name="bender-DeleteServiceAccountResponse"></a>

### DeleteServiceAccountResponse







<a name="bender-GetServiceAccountRequest"></a>

### GetServiceAccountRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |
| id | [string](#string) |  |  |






<a name="bender-GetServiceAccountResponse"></a>

### GetServiceAccountResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| sa | [ServiceAccount](#bender-ServiceAccount) |  |  |






<a name="bender-ListServiceAccountsRequest"></a>

### ListServiceAccountsRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |






<a name="bender-ListServiceAccountsResponse"></a>

### ListServiceAccountsResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| service_accounts | [ServiceAccountWithKeysCount](#bender-ServiceAccountWithKeysCount) | repeated |  |






<a name="bender-ServiceAccount"></a>

### ServiceAccount



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |
| id | [string](#string) |  |  |
| name | [string](#string) |  |  |
| role | [Role](#bender-Role) |  |  |






<a name="bender-ServiceAccountWithKeysCount"></a>

### ServiceAccountWithKeysCount



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| sa | [ServiceAccount](#bender-ServiceAccount) |  |  |
| keys_count | [int32](#int32) |  |  |






<a name="bender-UpdateServiceAccountRequest"></a>

### UpdateServiceAccountRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |
| id | [string](#string) |  |  |
| name | [string](#string) |  |  |






<a name="bender-UpdateServiceAccountResponse"></a>

### UpdateServiceAccountResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| sa | [ServiceAccount](#bender-ServiceAccount) |  |  |






<a name="bender-UpdateServiceAccountRoleRequest"></a>

### UpdateServiceAccountRoleRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |
| id | [string](#string) |  |  |
| role | [Role](#bender-Role) |  |  |






<a name="bender-UpdateServiceAccountRoleResponse"></a>

### UpdateServiceAccountRoleResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| sa | [ServiceAccount](#bender-ServiceAccount) |  |  |





 


<a name="bender-Role"></a>

### Role


| Name | Number | Description |
| ---- | ------ | ----------- |
| R_UNSPECIFIED | 0 |  |
| R_VIEWER | 1 |  |
| R_EDITOR | 2 |  |
| R_ADMIN | 3 |  |


 

 


<a name="bender-ServiceAccountsService"></a>

### ServiceAccountsService


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| ListServiceAccounts | [ListServiceAccountsRequest](#bender-ListServiceAccountsRequest) | [ListServiceAccountsResponse](#bender-ListServiceAccountsResponse) |  |
| CreateServiceAccount | [CreateServiceAccountRequest](#bender-CreateServiceAccountRequest) | [CreateServiceAccountResponse](#bender-CreateServiceAccountResponse) |  |
| GetServiceAccount | [GetServiceAccountRequest](#bender-GetServiceAccountRequest) | [GetServiceAccountResponse](#bender-GetServiceAccountResponse) |  |
| UpdateServiceAccount | [UpdateServiceAccountRequest](#bender-UpdateServiceAccountRequest) | [UpdateServiceAccountResponse](#bender-UpdateServiceAccountResponse) |  |
| UpdateServiceAccountRole | [UpdateServiceAccountRoleRequest](#bender-UpdateServiceAccountRoleRequest) | [UpdateServiceAccountRoleResponse](#bender-UpdateServiceAccountRoleResponse) |  |
| DeleteServiceAccount | [DeleteServiceAccountRequest](#bender-DeleteServiceAccountRequest) | [DeleteServiceAccountResponse](#bender-DeleteServiceAccountResponse) |  |

 



<a name="tenants_bender_benderpb_s3quotas-proto"></a>


## tenants/bender/benderpb/s3quotas.proto



<a name="bender-GetS3QuotaRequest"></a>

### GetS3QuotaRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |






<a name="bender-GetS3QuotaResponse"></a>

### GetS3QuotaResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| quota | [S3Quota](#bender-S3Quota) |  |  |






<a name="bender-ListS3QuotasRequest"></a>

### ListS3QuotasRequest







<a name="bender-ListS3QuotasResponse"></a>

### ListS3QuotasResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| quotas | [S3Quota](#bender-S3Quota) | repeated |  |






<a name="bender-S3Quota"></a>

### S3Quota



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |
| max_buckets | [uint32](#uint32) |  |  |
| max_size | [uint64](#uint64) |  |  |






<a name="bender-UpdateS3QuotaRequest"></a>

### UpdateS3QuotaRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |
| max_buckets | [uint32](#uint32) |  |  |
| max_size | [uint64](#uint64) |  |  |






<a name="bender-UpdateS3QuotaResponse"></a>

### UpdateS3QuotaResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| quota | [S3Quota](#bender-S3Quota) |  |  |





 

 

 


<a name="bender-S3QuotaService"></a>

### S3QuotaService


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| ListS3Quotas | [ListS3QuotasRequest](#bender-ListS3QuotasRequest) | [ListS3QuotasResponse](#bender-ListS3QuotasResponse) |  |
| GetS3Quota | [GetS3QuotaRequest](#bender-GetS3QuotaRequest) | [GetS3QuotaResponse](#bender-GetS3QuotaResponse) |  |
| UpdateS3Quota | [UpdateS3QuotaRequest](#bender-UpdateS3QuotaRequest) | [UpdateS3QuotaResponse](#bender-UpdateS3QuotaResponse) |  |

 



<a name="tenants_fry_authpb_user_roles-proto"></a>


## tenants/fry/authpb/user_roles.proto



<a name="fryauth-GetUserInfoRequest"></a>

### GetUserInfoRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| token | [string](#string) |  |  |






<a name="fryauth-GetUserInfoResponse"></a>

### GetUserInfoResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| username | [string](#string) |  |  |






<a name="fryauth-GetUserRoleRequest"></a>

### GetUserRoleRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| username | [string](#string) |  |  |
| tenant | [string](#string) |  |  |






<a name="fryauth-GetUserRoleResponse"></a>

### GetUserRoleResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| username | [string](#string) |  |  |
| tenant | [string](#string) |  |  |
| role | [Role](#fryauth-Role) |  |  |






<a name="fryauth-ListUserTenantsRequest"></a>

### ListUserTenantsRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| username | [string](#string) |  |  |






<a name="fryauth-ListUserTenantsResponse"></a>

### ListUserTenantsResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| membership | [ListUserTenantsResponse.Membership](#fryauth-ListUserTenantsResponse-Membership) | repeated |  |






<a name="fryauth-ListUserTenantsResponse-Membership"></a>

### ListUserTenantsResponse.Membership



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |
| role | [Role](#fryauth-Role) |  |  |





 


<a name="fryauth-Role"></a>

### Role


| Name | Number | Description |
| ---- | ------ | ----------- |
| R_UNSPECIFIED | 0 |  |
| R_VIEWER | 1 |  |
| R_EDITOR | 2 |  |
| R_ADMIN | 3 |  |
| R_BUCKET_MANAGER | 4 |  |


 

 


<a name="fryauth-UserAuthService"></a>

### UserAuthService


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| GetUserInfo | [GetUserInfoRequest](#fryauth-GetUserInfoRequest) | [GetUserInfoResponse](#fryauth-GetUserInfoResponse) |  |
| GetUserRole | [GetUserRoleRequest](#fryauth-GetUserRoleRequest) | [GetUserRoleResponse](#fryauth-GetUserRoleResponse) |  |
| ListUserTenants | [ListUserTenantsRequest](#fryauth-ListUserTenantsRequest) | [ListUserTenantsResponse](#fryauth-ListUserTenantsResponse) |  |

 



<a name="tenants_fry_frypb_applications-proto"></a>


## tenants/fry/frypb/applications.proto



<a name="fry-GetAppSettingsRequest"></a>

### GetAppSettingsRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| app | [Application](#fry-Application) |  |  |






<a name="fry-GetAppSettingsResponse"></a>

### GetAppSettingsResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| client_id | [string](#string) |  |  |
| org_id | [string](#string) |  |  |





 


<a name="fry-Application"></a>

### Application


| Name | Number | Description |
| ---- | ------ | ----------- |
| A_UNSPECIFIED | 0 |  |
| A_CONSOLE | 1 |  |
| A_CLI | 2 |  |


 

 


<a name="fry-Applications"></a>

### Applications


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| GetAppSettings | [GetAppSettingsRequest](#fry-GetAppSettingsRequest) | [GetAppSettingsResponse](#fry-GetAppSettingsResponse) |  |

 



<a name="tenants_fry_frypb_settings-proto"></a>


## tenants/fry/frypb/settings.proto



<a name="fry-CheckConfiguredRequest"></a>

### CheckConfiguredRequest







<a name="fry-CheckConfiguredResponse"></a>

### CheckConfiguredResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| configured | [bool](#bool) |  |  |
| issues | [string](#string) | repeated |  |






<a name="fry-GetLoginSettingRequest"></a>

### GetLoginSettingRequest







<a name="fry-GetLoginSettingsResponse"></a>

### GetLoginSettingsResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| users_domain | [string](#string) |  |  |
| saml_metadata | [string](#string) |  |  |
| metadata_path | [string](#string) |  |  |
| entity_id_path | [string](#string) |  |  |
| sign_on_path | [string](#string) |  |  |
| logout_path | [string](#string) |  |  |






<a name="fry-SetupLoginRequest"></a>

### SetupLoginRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| users_domain | [string](#string) |  |  |
| saml_metadata | [string](#string) |  |  |






<a name="fry-SetupLoginResponse"></a>

### SetupLoginResponse






 

 

 


<a name="fry-SettingsService"></a>

### SettingsService


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| GetLoginSettings | [GetLoginSettingRequest](#fry-GetLoginSettingRequest) | [GetLoginSettingsResponse](#fry-GetLoginSettingsResponse) |  |
| SetupLogin | [SetupLoginRequest](#fry-SetupLoginRequest) | [SetupLoginResponse](#fry-SetupLoginResponse) |  |
| CheckConfigured | [CheckConfiguredRequest](#fry-CheckConfiguredRequest) | [CheckConfiguredResponse](#fry-CheckConfiguredResponse) |  |

 



<a name="tenants_fry_frypb_users-proto"></a>


## tenants/fry/frypb/users.proto



<a name="fry-AddUserRequest"></a>

### AddUserRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| username | [string](#string) |  |  |






<a name="fry-AddUserResponse"></a>

### AddUserResponse







<a name="fry-ChangeMemberRequest"></a>

### ChangeMemberRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |
| username | [string](#string) |  |  |
| set_roles | [Role](#fry-Role) | repeated |  |






<a name="fry-ChangeMemberResponse"></a>

### ChangeMemberResponse







<a name="fry-GetUserRequest"></a>

### GetUserRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| username | [string](#string) |  |  |






<a name="fry-GetUserResponse"></a>

### GetUserResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| user | [User](#fry-User) |  |  |
| membership | [MemberRole](#fry-MemberRole) | repeated |  |






<a name="fry-ListMembersRequest"></a>

### ListMembersRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |






<a name="fry-ListMembersResponse"></a>

### ListMembersResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |
| members | [TenantMember](#fry-TenantMember) | repeated |  |






<a name="fry-ListUsersRequest"></a>

### ListUsersRequest







<a name="fry-ListUsersResponse"></a>

### ListUsersResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| users | [User](#fry-User) | repeated |  |






<a name="fry-LockUserRequest"></a>

### LockUserRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| username | [string](#string) |  |  |






<a name="fry-LockUserResponse"></a>

### LockUserResponse







<a name="fry-MemberRole"></a>

### MemberRole



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| tenant | [string](#string) |  |  |
| role | [Role](#fry-Role) |  |  |






<a name="fry-TenantMember"></a>

### TenantMember



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| username | [string](#string) |  |  |
| role | [Role](#fry-Role) |  |  |
| display_name | [string](#string) |  |  |






<a name="fry-UnlockUserRequest"></a>

### UnlockUserRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| username | [string](#string) |  |  |






<a name="fry-UnlockUserResponse"></a>

### UnlockUserResponse







<a name="fry-User"></a>

### User



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| username | [string](#string) |  |  |
| active | [bool](#bool) |  |  |
| display_name | [string](#string) |  |  |






<a name="fry-WhoAmIRequest"></a>

### WhoAmIRequest







<a name="fry-WhoAmIResponse"></a>

### WhoAmIResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| username | [string](#string) |  |  |





 


<a name="fry-Role"></a>

### Role


| Name | Number | Description |
| ---- | ------ | ----------- |
| R_UNSPECIFIED | 0 |  |
| R_VIEWER | 1 |  |
| R_EDITOR | 2 |  |
| R_ADMIN | 3 |  |
| R_BUCKET_MANAGER | 4 |  |


 

 


<a name="fry-TenantMembersService"></a>

### TenantMembersService


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| ListMembers | [ListMembersRequest](#fry-ListMembersRequest) | [ListMembersResponse](#fry-ListMembersResponse) |  |
| ChangeMember | [ChangeMemberRequest](#fry-ChangeMemberRequest) | [ChangeMemberResponse](#fry-ChangeMemberResponse) |  |


<a name="fry-UsersService"></a>

### UsersService


| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| WhoAmI | [WhoAmIRequest](#fry-WhoAmIRequest) | [WhoAmIResponse](#fry-WhoAmIResponse) |  |
| AddUser | [AddUserRequest](#fry-AddUserRequest) | [AddUserResponse](#fry-AddUserResponse) |  |
| ListUsers | [ListUsersRequest](#fry-ListUsersRequest) | [ListUsersResponse](#fry-ListUsersResponse) |  |
| GetUser | [GetUserRequest](#fry-GetUserRequest) | [GetUserResponse](#fry-GetUserResponse) |  |
| LockUser | [LockUserRequest](#fry-LockUserRequest) | [LockUserResponse](#fry-LockUserResponse) |  |
| UnlockUser | [UnlockUserRequest](#fry-UnlockUserRequest) | [UnlockUserResponse](#fry-UnlockUserResponse) |  |

 



## Scalar Value Types

| .proto Type | Notes | C++ | Java | Python | Go | C# | PHP | Ruby |
| ----------- | ----- | --- | ---- | ------ | -- | -- | --- | ---- |
| <a name="double" /> double |  | double | double | float | float64 | double | float | Float |
| <a name="float" /> float |  | float | float | float | float32 | float | float | Float |
| <a name="int32" /> int32 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint32 instead. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="int64" /> int64 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint64 instead. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="uint32" /> uint32 | Uses variable-length encoding. | uint32 | int | int/long | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="uint64" /> uint64 | Uses variable-length encoding. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum or Fixnum (as required) |
| <a name="sint32" /> sint32 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int32s. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sint64" /> sint64 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int64s. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="fixed32" /> fixed32 | Always four bytes. More efficient than uint32 if values are often greater than 2^28. | uint32 | int | int | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="fixed64" /> fixed64 | Always eight bytes. More efficient than uint64 if values are often greater than 2^56. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum |
| <a name="sfixed32" /> sfixed32 | Always four bytes. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sfixed64" /> sfixed64 | Always eight bytes. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="bool" /> bool |  | bool | boolean | boolean | bool | bool | boolean | TrueClass/FalseClass |
| <a name="string" /> string | A string must always contain UTF-8 encoded or 7-bit ASCII text. | string | String | str/unicode | string | string | string | String (UTF-8) |
| <a name="bytes" /> bytes | May contain any arbitrary sequence of bytes. | string | ByteString | str | []byte | ByteString | string | String (ASCII-8BIT) |
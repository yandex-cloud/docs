---
editable: false
sourcePath: en/_api-ref-grpc/marketplace/licensemanager/saas/v1/license-manager/saas/api-ref/grpc/Instance/getUserInfo.md
---

# Yandex Cloud Marketplace License Manager for SaaS, gRPC: InstanceService.GetUserInfo

Returns information about legal person (Russia only) who owns this subscription instance.

## gRPC request

**rpc GetUserInfo ([GetUserInfoRequest](#yandex.cloud.marketplace.licensemanager.saas.v1.GetUserInfoRequest)) returns ([licensemanager.v1.UserInfo](#yandex.cloud.marketplace.licensemanager.v1.UserInfo))**

## GetUserInfoRequest {#yandex.cloud.marketplace.licensemanager.saas.v1.GetUserInfoRequest}

```json
{
  "instance_id": "string"
}
```

#|
||Field | Description ||
|| instance_id | **string**

Required field. ID of the subscription instance. ||
|#

## licensemanager.v1.UserInfo {#yandex.cloud.marketplace.licensemanager.v1.UserInfo}

```json
{
  "id": "string",
  "name": "string",
  "inn": "string",
  "kpp": "string"
}
```

#|
||Field | Description ||
|| id | **string**

ID, reserved field ||
|| name | **string**

Name of legal person ||
|| inn | **string**

INN of legal person ||
|| kpp | **string**

KPP of legal person ||
|#
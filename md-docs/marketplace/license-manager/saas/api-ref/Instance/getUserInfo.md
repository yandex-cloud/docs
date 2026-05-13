# Yandex Cloud Marketplace License Manager for SaaS, REST: Instance.GetUserInfo

Returns information about legal person (Russia only) who owns this subscription instance.

## HTTP request

```
GET https://marketplace.api.cloud.yandex.net/marketplace/license-manager/saas/v1/instances/{instanceId}/user_info
```

## Path parameters

#|
||Field | Description ||
|| instanceId | **string**

Required field. ID of the subscription instance. ||
|#

## Response {#yandex.cloud.marketplace.licensemanager.v1.UserInfo}

**HTTP Code: 200 - OK**

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
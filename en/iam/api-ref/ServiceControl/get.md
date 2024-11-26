---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/ServiceControl/get.md
---

# Identity and Access Management API, REST: ServiceControl.Get

Returns the Service information in the specified resource container.

To get the list of available Services, make a [List](/docs/iam/api-ref/ServiceControl/list#List) request.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/services/{serviceId}
```

## Path parameters

#|
||Field | Description ||
|| serviceId | **string**

Required field. ID of the Service. ||
|#

## Query parameters {#yandex.cloud.iam.v1.GetServiceRequest}

#|
||Field | Description ||
|| resource | **[Resource](#yandex.cloud.iam.v1.Resource)**

Required field. Resource container to get a service information in.

It is supported only resource-manager.cloud resource container now. ||
|#

## Resource {#yandex.cloud.iam.v1.Resource}

A Resource. For more information, see [Resource](/docs/iam/concepts/access-control/resources-with-access-control).

#|
||Field | Description ||
|| id | **string**

Required field. ID of the resource. ||
|| type | **string**

Required field. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc. ||
|#

## Response {#yandex.cloud.iam.v1.Service}

**HTTP Code: 200 - OK**

```json
{
  "serviceId": "string",
  "resource": {
    "id": "string",
    "type": "string"
  },
  "updatedAt": "string",
  "status": "string"
}
```

A Service.

#|
||Field | Description ||
|| serviceId | **string**

ID of the service. ||
|| resource | **[Resource](#yandex.cloud.iam.v1.Resource2)**

Resource that the service belongs to. ||
|| updatedAt | **string** (date-time)

Time of the last status update of the service.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| status | **enum** (Status)

Current status of the service.

- `STATUS_UNSPECIFIED`
- `ENABLED`: The service is enabled.
- `PAUSED`: The service is paused.
- `DISABLED`: The service is disabled.
- `ENABLING`: The service is being enabled.
- `RESUMING`: The service is being resumed.
- `PAUSING`: The service is being paused.
- `DISABLING`: The service is being disabled.
- `ERROR`: The service is in error state.
- `DEFAULT`: The service could be auto enabled. ||
|#

## Resource {#yandex.cloud.iam.v1.Resource2}

A Resource. For more information, see [Resource](/docs/iam/concepts/access-control/resources-with-access-control).

#|
||Field | Description ||
|| id | **string**

Required field. ID of the resource. ||
|| type | **string**

Required field. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc. ||
|#
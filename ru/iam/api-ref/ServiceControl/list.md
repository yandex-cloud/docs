---
editable: false
apiPlayground:
  - url: https://iam.{{ api-host }}/iam/v1/services
    method: get
    path: null
    query:
      type: object
      properties:
        resource:
          description: |-
            **[Resource](/docs/iam/api-ref/ServiceControl/get#yandex.cloud.iam.v1.Resource)**
            Required field. Resource container to list a services.
            It is supported only resource-manager.cloud resource container now.
          $ref: '#/definitions/Resource'
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListServicesResponse.nextPageToken](/docs/iam/api-ref/ServiceControl/list#yandex.cloud.iam.v1.ListServicesResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken`
            to the [ListServicesResponse.nextPageToken](/docs/iam/api-ref/ServiceControl/list#yandex.cloud.iam.v1.ListServicesResponse)
            returned by a previous list request.
          type: string
      required:
        - resource
      additionalProperties: false
    body: null
    definitions:
      Resource:
        type: object
        properties:
          id:
            description: |-
              **string**
              Required field. ID of the resource.
            type: string
          type:
            description: |-
              **string**
              Required field. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc.
            type: string
        required:
          - id
          - type
sourcePath: en/_api-ref/iam/v1/api-ref/ServiceControl/list.md
---

# Identity and Access Management API, REST: ServiceControl.List

Retrieves the list of Service in the specified resource container.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/services
```

## Query parameters {#yandex.cloud.iam.v1.ListServicesRequest}

#|
||Field | Description ||
|| resource | **[Resource](#yandex.cloud.iam.v1.Resource)**

Required field. Resource container to list a services.

It is supported only resource-manager.cloud resource container now. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListServicesResponse.nextPageToken](#yandex.cloud.iam.v1.ListServicesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100 ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListServicesResponse.nextPageToken](#yandex.cloud.iam.v1.ListServicesResponse)
returned by a previous list request. ||
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

## Response {#yandex.cloud.iam.v1.ListServicesResponse}

**HTTP Code: 200 - OK**

```json
{
  "services": [
    {
      "serviceId": "string",
      "resource": {
        "id": "string",
        "type": "string"
      },
      "updatedAt": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| services[] | **[Service](#yandex.cloud.iam.v1.Service)**

List of Services. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListServicesRequest.pageSize](#yandex.cloud.iam.v1.ListServicesRequest), use
the `nextPageToken` as the value
for the [ListServicesRequest.pageToken](#yandex.cloud.iam.v1.ListServicesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Service {#yandex.cloud.iam.v1.Service}

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
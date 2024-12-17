---
editable: false
sourcePath: en/_api-ref/iot/broker/v1/broker/api-ref/Broker/list.md
---

# IoT Core Broker Service, REST: Broker.List

Retrieves the list of brokers in the specified folder.

## HTTP request

```
GET https://{{ api-host-iot-broker }}/iot-broker/v1/brokers
```

## Query parameters {#yandex.cloud.iot.broker.v1.ListBrokersRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list brokers in.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a [ListBrokersResponse.nextPageToken](#yandex.cloud.iot.broker.v1.ListBrokersResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListBrokersResponse.nextPageToken](#yandex.cloud.iot.broker.v1.ListBrokersResponse) returned by a previous list request. ||
|#

## Response {#yandex.cloud.iot.broker.v1.ListBrokersResponse}

**HTTP Code: 200 - OK**

```json
{
  "brokers": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "status": "string",
      "logOptions": {
        "disabled": "boolean",
        // Includes only one of the fields `logGroupId`, `folderId`
        "logGroupId": "string",
        "folderId": "string",
        // end of the list of possible fields
        "minLevel": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| brokers[] | **[Broker](#yandex.cloud.iot.broker.v1.Broker)**

List of brokers. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListBrokersRequest.pageSize](#yandex.cloud.iot.broker.v1.ListBrokersRequest), use `next_page_token` as the value
for the [ListBrokersRequest.pageToken](#yandex.cloud.iot.broker.v1.ListBrokersRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Broker {#yandex.cloud.iot.broker.v1.Broker}

A broker.

#|
||Field | Description ||
|| id | **string**

ID of the broker. ||
|| folderId | **string**

ID of the folder that the broker belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the broker. The name is unique within the folder. ||
|| description | **string**

Description of the broker. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| status | **enum** (Status)

Status of the broker.

- `STATUS_UNSPECIFIED`
- `CREATING`: Broker is being created.
- `ACTIVE`: Broker is ready to use.
- `DELETING`: Broker is being deleted. ||
|| logOptions | **[LogOptions](#yandex.cloud.iot.broker.v1.LogOptions)**

Options for logging broker events ||
|#

## LogOptions {#yandex.cloud.iot.broker.v1.LogOptions}

#|
||Field | Description ||
|| disabled | **boolean**

Is logging from broker disabled. ||
|| logGroupId | **string**

Entry should be written to log group resolved by ID.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| folderId | **string**

Entry should be written to default log group for specified folder.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| minLevel | **enum** (Level)

Minimum log entry level.

See [LogLevel.Level](/docs/logging/api-ref/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

- `LEVEL_UNSPECIFIED`: Default log level.

  Equivalent to not specifying log level at all.
- `TRACE`: Trace log level.

  Possible use case: verbose logging of some business logic.
- `DEBUG`: Debug log level.

  Possible use case: debugging special cases in application logic.
- `INFO`: Info log level.

  Mostly used for information messages.
- `WARN`: Warn log level.

  May be used to alert about significant events.
- `ERROR`: Error log level.

  May be used to alert about errors in infrastructure, logic, etc.
- `FATAL`: Fatal log level.

  May be used to alert about unrecoverable failures and events. ||
|#
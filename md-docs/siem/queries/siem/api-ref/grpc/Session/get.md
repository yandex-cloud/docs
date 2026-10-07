[Документация Yandex Cloud](../../../../../../index.md) > [Yandex SIEM](../../../../../index.md) > Справочник API > gRPC (англ.) > [Yandex Cloud SIEM Queries API](../index.md) > [Session](index.md) > Get

# Yandex Cloud SIEM Queries API, gRPC: SessionService.Get

Returns the specified Session.

The caller must have the `siem.queries.get` permission to the requested Session.

## gRPC request

**rpc Get ([GetSessionRequest](#yandex.cloud.siem.v1.queries.GetSessionRequest)) returns ([Session](#yandex.cloud.siem.v1.queries.Session))**

## GetSessionRequest {#yandex.cloud.siem.v1.queries.GetSessionRequest}

```json
{
  "session_id": "string"
}
```

#|
||Field | Description ||
|| session_id | **string**

Required field. Required. ID of the Session to return.

The maximum string length in characters is 50. ||
|#

## Session {#yandex.cloud.siem.v1.queries.Session}

```json
{
  "siem_instance_id": "string",
  "id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "status": "Status",
  "created_at": "google.protobuf.Timestamp",
  "updated_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "updated_by": "string"
}
```

Session is a container for Datasets and Searches.

#|
||Field | Description ||
|| siem_instance_id | **string**

Required. ID of related SIEM instance. ||
|| id | **string**

Required field. Required. Unique ID of the Session.
This ID is assigned by services in the process of creating a Session.

The maximum string length in characters is 50. ||
|| name | **string**

Required field. Required. Name of the Session. 1-64 characters long.

The maximum string length in characters is 64. ||
|| description | **string**

The description of the Session. 0-256 characters long.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| status | enum **Status**

Session status

- `CREATING`: Session is being created
- `ACTIVE`: Session is active
- `UPDATING`: Session is updating
- `DELETING`: Session is deleting
- `DELETED`: Session is deleted ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when Session was created at. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when Session was last updated at. ||
|| created_by | **string**

ID of the user or service account who created Session ||
|| updated_by | **string**

ID of the user or service account who updated Session. ||
|#
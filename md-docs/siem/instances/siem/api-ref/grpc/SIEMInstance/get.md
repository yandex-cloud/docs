[Документация Yandex Cloud](../../../../../../index.md) > [Yandex SIEM](../../../../../index.md) > Справочник API > gRPC (англ.) > [Yandex Cloud SIEM Instances API](../index.md) > [SIEMInstance](index.md) > Get

# Yandex Cloud SIEM Instances API, gRPC: SIEMInstanceService.Get

Returns the specified SIEM Instance

The caller must have the `siem.instances.get` permission to the requested SIEM Instance.

## gRPC request

**rpc Get ([GetInstanceRequest](#yandex.cloud.siem.v1.instances.GetInstanceRequest)) returns ([SIEMInstance](#yandex.cloud.siem.v1.instances.SIEMInstance))**

## GetInstanceRequest {#yandex.cloud.siem.v1.instances.GetInstanceRequest}

```json
{
  "siem_instance_id": "string"
}
```

#|
||Field | Description ||
|| siem_instance_id | **string**

Required field. Required. ID of the SIEM Instance to return

The maximum string length in characters is 50. ||
|#

## SIEMInstance {#yandex.cloud.siem.v1.instances.SIEMInstance}

```json
{
  "id": "string",
  "organization_id": "string",
  "name": "string",
  "description": "string"
}
```

SIEM Instance is instance of Yandex Cloud SIEM

#|
||Field | Description ||
|| id | **string**

Required. Unique ID of the SIEM Instance. ||
|| organization_id | **string**

ID of the Organization that the SIEM instance belongs to. ||
|| name | **string**

Required. Name of the SIEM Instance.
The name is unique within the Organization. Organization can have one SIEM Instance. 1-64 characters long. ||
|| description | **string**

The description of the SIEM Instance. 0-256 characters long. ||
|#
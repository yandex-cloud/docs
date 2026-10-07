---
editable: false
apiPlayground:
  - url: https://siem.{{ api-host }}/siem/v1/instances/{siemInstanceId}
    method: get
    path:
      type: object
      properties:
        siemInstanceId:
          description: |-
            **string**
            Required field. Required. ID of the SIEM Instance to return
            The maximum string length in characters is 50.
          type: string
      required:
        - siemInstanceId
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Yandex Cloud SIEM Instances API, REST: SIEMInstance.Get

Returns the specified SIEM Instance

The caller must have the `siem.instances.get` permission to the requested SIEM Instance.

## HTTP request

```
GET https://siem.{{ api-host }}/siem/v1/instances/{siemInstanceId}
```

## Path parameters

#|
||Field | Description ||
|| siemInstanceId | **string**

Required field. Required. ID of the SIEM Instance to return

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.siem.v1.instances.SIEMInstance}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "organizationId": "string",
  "name": "string",
  "description": "string"
}
```

SIEM Instance is instance of Yandex Cloud SIEM

#|
||Field | Description ||
|| id | **string**

Required. Unique ID of the SIEM Instance. ||
|| organizationId | **string**

ID of the Organization that the SIEM instance belongs to. ||
|| name | **string**

Required. Name of the SIEM Instance.
The name is unique within the Organization. Organization can have one SIEM Instance. 1-64 characters long. ||
|| description | **string**

The description of the SIEM Instance. 0-256 characters long. ||
|#
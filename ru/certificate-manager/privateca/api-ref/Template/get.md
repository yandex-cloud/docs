---
editable: false
apiPlayground:
  - url: https://private-ca.certificate-manager.{{ api-host }}/privateca/v1/templates/{id}
    method: get
    path:
      type: object
      properties:
        id:
          description: |-
            **string**
            Required field. ID of the template to retrieve.
          type: string
      required:
        - id
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/certificatemanager/v1/privateca/api-ref/Template/get.md
---

# Certificate Manager Private CA API, REST: Template.Get

Retrieves specified certificate template.

## HTTP request

```
GET https://private-ca.certificate-manager.{{ api-host }}/privateca/v1/templates/{id}
```

## Path parameters

Request message to retrieve details of a template.

#|
||Field | Description ||
|| id | **string**

Required field. ID of the template to retrieve. ||
|#

## Response {#yandex.cloud.certificatemanager.v1.privateca.Template}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "data": "string",
  "createdAt": "string",
  "updatedAt": "string"
}
```

Json or yaml template for easier certificate issuing. If used while certificate creation, certificate would take all fields from template.

#|
||Field | Description ||
|| id | **string**

ID of the template. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the template belongs to. ||
|| name | **string**

Name of the template. ||
|| data | **string**

Json representation of template. ||
|| createdAt | **string** (date-time)

Timestamp when the template was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Timestamp when the template was last updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#
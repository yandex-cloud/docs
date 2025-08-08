---
editable: false
apiPlayground:
  - url: https://private-ca.certificate-manager.{{ api-host }}/privateca/v1/templates
    method: get
    path: null
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder into which list templates.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results to return per page. Couldn't exceed 100, default value is 100
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Token to retrieve specific pages of results.
            If this is set, the service will return the next page of results based on this token.
          type: string
      required:
        - folderId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/certificatemanager/v1/privateca/api-ref/Template/list.md
---

# Certificate Manager Private CA API, REST: Template.List

Lists all certificate templates in a specified folder.

## HTTP request

```
GET https://private-ca.certificate-manager.{{ api-host }}/privateca/v1/templates
```

## Query parameters {#yandex.cloud.certificatemanager.v1.privateca.ListTemplateRequest}

Request message to list templates in a folder.

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder into which list templates. ||
|| pageSize | **string** (int64)

The maximum number of results to return per page. Couldn't exceed 100, default value is 100 ||
|| pageToken | **string**

Token to retrieve specific pages of results.
If this is set, the service will return the next page of results based on this token. ||
|#

## Response {#yandex.cloud.certificatemanager.v1.privateca.ListTemplateResponse}

**HTTP Code: 200 - OK**

```json
{
  "templates": [
    {
      "id": "string",
      "folderId": "string",
      "name": "string",
      "data": "string",
      "createdAt": "string",
      "updatedAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

Response containing the list of templates.

#|
||Field | Description ||
|| templates[] | **[Template](#yandex.cloud.certificatemanager.v1.privateca.Template)**

List of certificate templates in the specified folder. ||
|| nextPageToken | **string**

Token for obtaining the next page of results.
If the number of results exceeds `page_size`, this token will be returned and can be passed to
the `ListTemplateRequest` for the next page. ||
|#

## Template {#yandex.cloud.certificatemanager.v1.privateca.Template}

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
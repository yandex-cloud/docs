---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/saml/applications/{applicationId}:listAssignments
    method: get
    path:
      type: object
      properties:
        applicationId:
          description: |-
            **string**
            Required field. ID of the SAML application to list assignments for.
          type: string
      required:
        - applicationId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token for pagination.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/idp/application/saml/api-ref/Application/listAssignments.md
---

# SAML Application API, REST: Application.ListAssignments

Lists assignments for the specified SAML application.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/saml/applications/{applicationId}:listAssignments
```

## Path parameters

Request to list assignments for a SAML application.

#|
||Field | Description ||
|| applicationId | **string**

Required field. ID of the SAML application to list assignments for. ||
|#

## Query parameters {#yandex.cloud.organizationmanager.v1.idp.application.saml.ListAssignmentsRequest}

Request to list assignments for a SAML application.

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. ||
|| pageToken | **string**

Page token for pagination. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.idp.application.saml.ListAssignmentsResponse}

**HTTP Code: 200 - OK**

```json
{
  "assignments": [
    {
      "subjectId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

Response message for [ApplicationService.ListAssignments](#ListAssignments).

#|
||Field | Description ||
|| assignments[] | **[Assignment](#yandex.cloud.organizationmanager.v1.idp.application.saml.Assignment)**

List of assignments. ||
|| nextPageToken | **string**

Token for getting the next page of the list. ||
|#

## Assignment {#yandex.cloud.organizationmanager.v1.idp.application.saml.Assignment}

An assignment for a SAML application.

#|
||Field | Description ||
|| subjectId | **string**

Required field. ID of the subject being assigned. ||
|#
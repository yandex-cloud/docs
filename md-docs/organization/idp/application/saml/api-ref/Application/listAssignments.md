[Документация Yandex Cloud](../../../../../../index.md) > [Yandex Identity Hub](../../../../../index.md) > Справочник API > REST (англ.) > Identity Provider API > [SAML Application API](../index.md) > [Application](index.md) > ListAssignments

# SAML Application API, REST: Application.ListAssignments

Lists assignments for the specified SAML application.

## HTTP request

```
GET https://organization-manager.api.cloud.yandex.net/organization-manager/v1/idp/application/saml/applications/{applicationId}:listAssignments
```

## Path parameters

Request to list assignments for a SAML application.

#|
||Field | Description ||
|| applicationId | **string**

Required field. ID of the SAML application to list assignments for.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.organizationmanager.v1.idp.application.saml.ListAssignmentsRequest}

Request to list assignments for a SAML application.

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token for pagination.

The maximum string length in characters is 2000. ||
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

Required field. ID of the subject being assigned.

The maximum string length in characters is 100. ||
|#
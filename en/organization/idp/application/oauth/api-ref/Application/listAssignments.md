---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/oauth/applications/{applicationId}:listAssignments
    method: get
    path:
      type: object
      properties:
        applicationId:
          description: |-
            **string**
            Required field. ID of the OAuth application to update.
            To get the OAuth application ID, make a [ApplicationService.List](/docs/organization/idp/application/oauth/mapi-ref/Application/list#List) request.
            The maximum string length in characters is 50.
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
            If the number of available results is larger than `pageSize`,
            the service returns a [ListAssignmentsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListAssignmentsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Acceptable values are 0 to 1000, inclusive.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken`
            to the [ListAssignmentsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListAssignmentsResponse)
            returned by a previous list request.
            The maximum string length in characters is 2000.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/idp/application/oauth/api-ref/Application/listAssignments.md
---

# OAUTH Application API, REST: Application.ListAssignments

Lists assignmnents for the specified OAuth application.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/oauth/applications/{applicationId}:listAssignments
```

## Path parameters

Request to list assignments for a OAuth application.

#|
||Field | Description ||
|| applicationId | **string**

Required field. ID of the OAuth application to update.
To get the OAuth application ID, make a [ApplicationService.List](/docs/organization/idp/application/oauth/mapi-ref/Application/list#List) request.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListAssignmentsRequest}

Request to list assignments for a OAuth application.

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.
If the number of available results is larger than `pageSize`,
the service returns a [ListAssignmentsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListAssignmentsResponse)
that can be used to get the next page of results in subsequent list requests.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListAssignmentsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListAssignmentsResponse)
returned by a previous list request.

The maximum string length in characters is 2000. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListAssignmentsResponse}

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
|| assignments[] | **[Assignment](#yandex.cloud.organizationmanager.v1.idp.application.oauth.Assignment)**

List of assignments. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests.
If the number of results is larger than [ListAssignmentsRequest.pageSize](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListAssignmentsRequest),
use the `nextPageToken` as the value for the [ListAssignmentsRequest.pageToken](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListAssignmentsRequest)
query parameter in the next list request. ||
|#

## Assignment {#yandex.cloud.organizationmanager.v1.idp.application.oauth.Assignment}

An assignment for the OAuth application

#|
||Field | Description ||
|| subjectId | **string**

Required field. ID of the subject to be assigned to the OAuth application.
Supported subject categories: UserAccount, ServiceAccount, Group, MetaGroup, PublicGroup.
In case subject ID is ID of the group,
then such group becomes visible to the users of OAuth application in case [GroupDistributionType](/docs/organization/idp/application/oauth/mapi-ref/Application/get#yandex.cloud.organizationmanager.v1.idp.application.oauth.GroupDistributionType) has value ASSIGNED_GROUPS.

The maximum string length in characters is 100. ||
|#
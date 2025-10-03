---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/idp/application/oauth/api-ref/grpc/Application/listAssignments.md
---

# OAUTH Application API, gRPC: ApplicationService.ListAssignments

Lists assignmnents for the specified OAuth application.

## gRPC request

**rpc ListAssignments ([ListAssignmentsRequest](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListAssignmentsRequest)) returns ([ListAssignmentsResponse](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListAssignmentsResponse))**

## ListAssignmentsRequest {#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListAssignmentsRequest}

```json
{
  "application_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

Request to list assignments for a OAuth application.

#|
||Field | Description ||
|| application_id | **string**

Required field. ID of the OAuth application to update.
To get the OAuth application ID, make a [ApplicationService.List](/docs/organization/idp/application/oauth/mapi-ref/grpc/Application/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return.
If the number of available results is larger than `page_size`,
the service returns a [ListAssignmentsResponse.next_page_token](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListAssignmentsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token`
to the [ListAssignmentsResponse.next_page_token](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListAssignmentsResponse)
returned by a previous list request. ||
|#

## ListAssignmentsResponse {#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListAssignmentsResponse}

```json
{
  "assignments": [
    {
      "subject_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

Response message for [ApplicationService.ListAssignments](#ListAssignments).

#|
||Field | Description ||
|| assignments[] | **[Assignment](#yandex.cloud.organizationmanager.v1.idp.application.oauth.Assignment)**

List of assignments. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests.
If the number of results is larger than [ListAssignmentsRequest.page_size](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListAssignmentsRequest),
use the `next_page_token` as the value for the [ListAssignmentsRequest.page_token](#yandex.cloud.organizationmanager.v1.idp.application.oauth.ListAssignmentsRequest)
query parameter in the next list request. ||
|#

## Assignment {#yandex.cloud.organizationmanager.v1.idp.application.oauth.Assignment}

An assignment for the OAuth application

#|
||Field | Description ||
|| subject_id | **string**

Required field. ID of the subject to be assigned to the OAuth application.
Supported subject categories: UserAccount, ServiceAccount, Group, MetaGroup, PublicGroup.
In case subject ID is ID of the group,
then such group becomes visible to the users of OAuth application in case [GroupDistributionType](/docs/organization/idp/application/oauth/mapi-ref/grpc/Application/get#yandex.cloud.organizationmanager.v1.idp.application.oauth.GroupDistributionType) has value ASSIGNED_GROUPS. ||
|#
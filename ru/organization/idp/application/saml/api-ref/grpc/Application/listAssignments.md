---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/idp/application/saml/api-ref/grpc/Application/listAssignments.md
---

# SAML Application API, gRPC: ApplicationService.ListAssignments

Lists assignments for the specified SAML application.

## gRPC request

**rpc ListAssignments ([ListAssignmentsRequest](#yandex.cloud.organizationmanager.v1.idp.application.saml.ListAssignmentsRequest)) returns ([ListAssignmentsResponse](#yandex.cloud.organizationmanager.v1.idp.application.saml.ListAssignmentsResponse))**

## ListAssignmentsRequest {#yandex.cloud.organizationmanager.v1.idp.application.saml.ListAssignmentsRequest}

```json
{
  "application_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

Request to list assignments for a SAML application.

#|
||Field | Description ||
|| application_id | **string**

Required field. ID of the SAML application to list assignments for.

The maximum string length in characters is 50. ||
|| page_size | **int64**

The maximum number of results per page to return.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token for pagination.

The maximum string length in characters is 2000. ||
|#

## ListAssignmentsResponse {#yandex.cloud.organizationmanager.v1.idp.application.saml.ListAssignmentsResponse}

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
|| assignments[] | **[Assignment](#yandex.cloud.organizationmanager.v1.idp.application.saml.Assignment)**

List of assignments. ||
|| next_page_token | **string**

Token for getting the next page of the list. ||
|#

## Assignment {#yandex.cloud.organizationmanager.v1.idp.application.saml.Assignment}

An assignment for a SAML application.

#|
||Field | Description ||
|| subject_id | **string**

Required field. ID of the subject being assigned.

The maximum string length in characters is 100. ||
|#
---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/AccessAnalyzer/listSubjectAccessBindings.md
---

# Identity and Access Management API, gRPC: AccessAnalyzerService.ListSubjectAccessBindings

Returns the list of access bindings for the specified subject in chosen organization.

## gRPC request

**rpc ListSubjectAccessBindings ([ListSubjectAccessBindingsRequest](#yandex.cloud.iam.v1.ListSubjectAccessBindingsRequest)) returns ([ListSubjectAccessBindingsResponse](#yandex.cloud.iam.v1.ListSubjectAccessBindingsResponse))**

## ListSubjectAccessBindingsRequest {#yandex.cloud.iam.v1.ListSubjectAccessBindingsRequest}

```json
{
  "subject_id": "string",
  "organization_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| subject_id | **string**

Required field. SubjectId to list access bindings for.

The maximum string length in characters is 100. ||
|| organization_id | **string**

Required field. OrganizationId to search access bindings in.

The maximum string length in characters is 50. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListSubjectAccessBindingsResponse.next_page_token](#yandex.cloud.iam.v1.ListSubjectAccessBindingsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token`
to the [ListSubjectAccessBindingsResponse.next_page_token](#yandex.cloud.iam.v1.ListSubjectAccessBindingsResponse)
returned by a previous list request.

The maximum string length in characters is 2000. ||
|#

## ListSubjectAccessBindingsResponse {#yandex.cloud.iam.v1.ListSubjectAccessBindingsResponse}

```json
{
  "subject_access_bindings": [
    {
      "role_id": "string",
      "resource": {
        "id": "string",
        "type": "string"
      },
      "subject_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| subject_access_bindings[] | **[SubjectAccessBinding](#yandex.cloud.iam.v1.SubjectAccessBinding)**

List of access bindings for the specified subject. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListSubjectAccessBindingsRequest.page_size](#yandex.cloud.iam.v1.ListSubjectAccessBindingsRequest), use
the `next_page_token` as the value
for the [ListSubjectAccessBindingsRequest.page_token](#yandex.cloud.iam.v1.ListSubjectAccessBindingsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## SubjectAccessBinding {#yandex.cloud.iam.v1.SubjectAccessBinding}

#|
||Field | Description ||
|| role_id | **string**

Role assigned to the subject. ||
|| resource | **[Resource](#yandex.cloud.iam.v1.Resource)**

Resource to which the access binding applies. ||
|| subject_id | **string**

Identifier of the subject to which this role is granted. ||
|#

## Resource {#yandex.cloud.iam.v1.Resource}

A Resource. For more information, see [Resource](/docs/iam/concepts/access-control/resources-with-access-control).

#|
||Field | Description ||
|| id | **string**

Required field. ID of the resource.

The maximum string length in characters is 50. ||
|| type | **string**

Required field. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc.

The maximum string length in characters is 64. ||
|#
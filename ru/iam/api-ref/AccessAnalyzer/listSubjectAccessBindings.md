---
editable: false
apiPlayground:
  - url: https://iam.{{ api-host }}/iam/v1/listSubjectAccessBindings
    method: get
    path: null
    query:
      type: object
      properties:
        subjectId:
          description: |-
            **string**
            Required field. SubjectId to list access bindings for.
          type: string
        organizationId:
          description: |-
            **string**
            Required field. OrganizationId to search access bindings in.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListSubjectAccessBindingsResponse.nextPageToken](#yandex.cloud.iam.v1.ListSubjectAccessBindingsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100
          default: '100'
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken`
            to the [ListSubjectAccessBindingsResponse.nextPageToken](#yandex.cloud.iam.v1.ListSubjectAccessBindingsResponse)
            returned by a previous list request.
          type: string
      required:
        - subjectId
        - organizationId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/iam/v1/api-ref/AccessAnalyzer/listSubjectAccessBindings.md
---

# Identity and Access Management API, REST: AccessAnalyzer.ListSubjectAccessBindings

Returns the list of access bindings for the specified subject in chosen organization.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/listSubjectAccessBindings
```

## Query parameters {#yandex.cloud.iam.v1.ListSubjectAccessBindingsRequest}

#|
||Field | Description ||
|| subjectId | **string**

Required field. SubjectId to list access bindings for. ||
|| organizationId | **string**

Required field. OrganizationId to search access bindings in. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListSubjectAccessBindingsResponse.nextPageToken](#yandex.cloud.iam.v1.ListSubjectAccessBindingsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100 ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListSubjectAccessBindingsResponse.nextPageToken](#yandex.cloud.iam.v1.ListSubjectAccessBindingsResponse)
returned by a previous list request. ||
|#

## Response {#yandex.cloud.iam.v1.ListSubjectAccessBindingsResponse}

**HTTP Code: 200 - OK**

```json
{
  "subjectAccessBindings": [
    {
      "roleId": "string",
      "resource": {
        "id": "string",
        "type": "string"
      },
      "subjectId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| subjectAccessBindings[] | **[SubjectAccessBinding](#yandex.cloud.iam.v1.SubjectAccessBinding)**

List of access bindings for the specified subject. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListSubjectAccessBindingsRequest.pageSize](#yandex.cloud.iam.v1.ListSubjectAccessBindingsRequest), use
the `nextPageToken` as the value
for the [ListSubjectAccessBindingsRequest.pageToken](#yandex.cloud.iam.v1.ListSubjectAccessBindingsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## SubjectAccessBinding {#yandex.cloud.iam.v1.SubjectAccessBinding}

#|
||Field | Description ||
|| roleId | **string**

Role assigned to the subject. ||
|| resource | **[Resource](#yandex.cloud.iam.v1.Resource)**

Resource to which the access binding applies. ||
|| subjectId | **string**

Identifier of the subject to which this role is granted. ||
|#

## Resource {#yandex.cloud.iam.v1.Resource}

A Resource. For more information, see [Resource](/docs/iam/concepts/access-control/resources-with-access-control).

#|
||Field | Description ||
|| id | **string**

Required field. ID of the resource. ||
|| type | **string**

Required field. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc. ||
|#
---
editable: false
apiPlayground:
  - url: https://iam.{{ api-host }}/iam/v1/accessPolicyTemplates
    method: get
    path: null
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListAccessPolicyTemplatesResponse.nextPageToken](#yandex.cloud.iam.v1.ListAccessPolicyTemplatesResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
            Acceptable values are 0 to 1000, inclusive.
          default: '100'
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the
            [ListAccessPolicyTemplatesResponse.nextPageToken](#yandex.cloud.iam.v1.ListAccessPolicyTemplatesResponse) returned by a previous list request.
            The maximum string length in characters is 2000.
          type: string
      additionalProperties: false
    body: null
    definitions: null
---

# Identity and Access Management API, REST: AccessPolicyTemplate.List

Returns list of available access policy templates.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/accessPolicyTemplates
```

## Query parameters {#yandex.cloud.iam.v1.ListAccessPolicyTemplatesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListAccessPolicyTemplatesResponse.nextPageToken](#yandex.cloud.iam.v1.ListAccessPolicyTemplatesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListAccessPolicyTemplatesResponse.nextPageToken](#yandex.cloud.iam.v1.ListAccessPolicyTemplatesResponse) returned by a previous list request.

The maximum string length in characters is 2000. ||
|#

## Response {#yandex.cloud.iam.v1.ListAccessPolicyTemplatesResponse}

**HTTP Code: 200 - OK**

```json
{
  "accessPolicyTemplates": [
    {
      "id": "string",
      "name": "string",
      "description": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| accessPolicyTemplates[] | **[AccessPolicy](#yandex.cloud.access.AccessPolicy)**

List of available access policy templates. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListAccessPolicyTemplatesRequest.pageSize](#yandex.cloud.iam.v1.ListAccessPolicyTemplatesRequest), use the `nextPageToken` as the value
for the [ListAccessPolicyTemplatesRequest.pageToken](#yandex.cloud.iam.v1.ListAccessPolicyTemplatesRequest) query parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## AccessPolicy {#yandex.cloud.access.AccessPolicy}

#|
||Field | Description ||
|| id | **string**

ID of the access policy template. ||
|| name | **string**

Name of the access policy template. ||
|| description | **string**

Description of the access policy template. ||
|#
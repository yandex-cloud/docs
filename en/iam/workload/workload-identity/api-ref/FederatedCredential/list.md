---
editable: false
apiPlayground:
  - url: https://iam.{{ api-host }}/iam/v1/workload/federatedCredentials
    method: get
    path: null
    query:
      type: object
      properties:
        serviceAccountId:
          description: |-
            **string**
            Required field. ID of the service account to list federated credentials for.
            To get the the service account ID make a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/ServiceAccount/list#List) request.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListFederatedCredentialsResponse.nextPageToken](/docs/iam/workload/workload-identity/api-ref/FederatedCredential/list#yandex.cloud.iam.v1.workload.ListFederatedCredentialsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken`
            to the [ListFederatedCredentialsResponse.nextPageToken](/docs/iam/workload/workload-identity/api-ref/FederatedCredential/list#yandex.cloud.iam.v1.workload.ListFederatedCredentialsResponse)
            returned by a previous list request.
          type: string
      required:
        - serviceAccountId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/iam/v1/workload/workload-identity/api-ref/FederatedCredential/list.md
---

# Workload Identity, REST: FederatedCredential.List

Retrieves the list of federated credentials for the specified service account.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/workload/federatedCredentials
```

## Query parameters {#yandex.cloud.iam.v1.workload.ListFederatedCredentialsRequest}

#|
||Field | Description ||
|| serviceAccountId | **string**

Required field. ID of the service account to list federated credentials for.
To get the the service account ID make a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/ServiceAccount/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListFederatedCredentialsResponse.nextPageToken](#yandex.cloud.iam.v1.workload.ListFederatedCredentialsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListFederatedCredentialsResponse.nextPageToken](#yandex.cloud.iam.v1.workload.ListFederatedCredentialsResponse)
returned by a previous list request. ||
|#

## Response {#yandex.cloud.iam.v1.workload.ListFederatedCredentialsResponse}

**HTTP Code: 200 - OK**

```json
{
  "federatedCredentials": [
    {
      "id": "string",
      "serviceAccountId": "string",
      "federationId": "string",
      "externalSubjectId": "string",
      "createdAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| federatedCredentials[] | **[FederatedCredential](#yandex.cloud.iam.v1.workload.FederatedCredential)**

List of federated credentials. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListFederatedCredentialsRequest.pageSize](#yandex.cloud.iam.v1.workload.ListFederatedCredentialsRequest), use
the `nextPageToken` as the value
for the [ListFederatedCredentialsRequest.pageToken](#yandex.cloud.iam.v1.workload.ListFederatedCredentialsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## FederatedCredential {#yandex.cloud.iam.v1.workload.FederatedCredential}

A federated credential.

#|
||Field | Description ||
|| id | **string**

Id of the federated credential. ||
|| serviceAccountId | **string**

Id of the service account that the federated credential belongs to. ||
|| federationId | **string**

ID of the workload identity federation which is used for authentication. ||
|| externalSubjectId | **string**

Id of the external subject. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#
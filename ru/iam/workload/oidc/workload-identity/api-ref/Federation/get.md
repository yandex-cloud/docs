---
editable: false
apiPlayground:
  - url: https://iam.{{ api-host }}/iam/v1/workload/oidc/federations/{federationId}
    method: get
    path:
      type: object
      properties:
        federationId:
          description: |-
            **string**
            Required field. ID of the OIDC workload identity federation to return.
            To get the OIDC workload identity federation ID, make a [FederationService.List](/docs/iam/workload/oidc/workload-identity/api-ref/Federation/list#List) request.
          type: string
      required:
        - federationId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/iam/v1/workload/oidc/workload-identity/api-ref/Federation/get.md
---

# Federation, REST: Federation.Get

Returns the specified OIDC workload identity federation.

To get the list of available OIDC workload identity federation, make a [List](/docs/iam/workload/oidc/workload-identity/api-ref/Federation/list#List) request.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/workload/oidc/federations/{federationId}
```

## Path parameters

#|
||Field | Description ||
|| federationId | **string**

Required field. ID of the OIDC workload identity federation to return.
To get the OIDC workload identity federation ID, make a [FederationService.List](/docs/iam/workload/oidc/workload-identity/api-ref/Federation/list#List) request. ||
|#

## Response {#yandex.cloud.iam.v1.workload.oidc.Federation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "name": "string",
  "folderId": "string",
  "description": "string",
  "enabled": "boolean",
  "audiences": [
    "string"
  ],
  "issuer": "string",
  "jwksUrl": "string",
  "labels": "object",
  "createdAt": "string"
}
```

A OIDC workload identity federation.

#|
||Field | Description ||
|| id | **string**

Id of the OIDC workload identity federation. ||
|| name | **string**

Name of the OIDC workload identity federation
The name is unique within the folder. 3-63 characters long. ||
|| folderId | **string**

ID of the folder that the OIDC workload identity federation belongs to. ||
|| description | **string**

Description of the service account. 0-256 characters long. ||
|| enabled | **boolean**

True - the OIDC workload identity federation is enabled and can be used for authentication.
False - the OIDC workload identity federation is disabled and cannot be used for authentication. ||
|| audiences[] | **string**

List of trusted values for aud claim. ||
|| issuer | **string**

URL of the external IdP server to be used for authentication. ||
|| jwksUrl | **string**

URL reference to trusted keys in format of JSON Web Key Set. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#
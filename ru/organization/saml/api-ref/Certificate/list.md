---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/saml/certificates
    method: get
    path: null
    query:
      type: object
      properties:
        federationId:
          description: |-
            **string**
            Required field. ID of the federation to list certificates in.
            To get the federation ID make a [yandex.cloud.organizationmanager.v1.saml.FederationService.List](/docs/organization/saml/api-ref/Federation/list#List) request.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`, the service returns a [ListCertificatesResponse.nextPageToken](/docs/organization/saml/api-ref/Certificate/list#yandex.cloud.organizationmanager.v1.saml.ListCertificatesResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken`
            to the [ListCertificatesResponse.nextPageToken](/docs/organization/saml/api-ref/Certificate/list#yandex.cloud.organizationmanager.v1.saml.ListCertificatesResponse)
            returned by a previous list request.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression must specify:
            1. The field name. Currently you can use filtering only on [Certificate.name](/docs/organization/saml/api-ref/Certificate/get#yandex.cloud.organizationmanager.v1.saml.Certificate) field.
            2. An `=` operator.
            3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
          type: string
      required:
        - federationId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/saml/api-ref/Certificate/list.md
---

# SAML Federation API, REST: Certificate.List

Retrieves the list of certificates in the specified federation.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/saml/certificates
```

## Query parameters {#yandex.cloud.organizationmanager.v1.saml.ListCertificatesRequest}

#|
||Field | Description ||
|| federationId | **string**

Required field. ID of the federation to list certificates in.
To get the federation ID make a [yandex.cloud.organizationmanager.v1.saml.FederationService.List](/docs/organization/saml/api-ref/Federation/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListCertificatesResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.saml.ListCertificatesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListCertificatesResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.saml.ListCertificatesResponse)
returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [Certificate.name](#yandex.cloud.organizationmanager.v1.saml.Certificate) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.saml.ListCertificatesResponse}

**HTTP Code: 200 - OK**

```json
{
  "certificates": [
    {
      "id": "string",
      "federationId": "string",
      "name": "string",
      "description": "string",
      "createdAt": "string",
      "data": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| certificates[] | **[Certificate](#yandex.cloud.organizationmanager.v1.saml.Certificate)**

List of certificates. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListCertificatesRequest.pageSize](#yandex.cloud.organizationmanager.v1.saml.ListCertificatesRequest), use
the `nextPageToken` as the value
for the [ListCertificatesRequest.pageToken](#yandex.cloud.organizationmanager.v1.saml.ListCertificatesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Certificate {#yandex.cloud.organizationmanager.v1.saml.Certificate}

A certificate.

#|
||Field | Description ||
|| id | **string**

Required field. ID of the certificate. ||
|| federationId | **string**

Required field. ID of the federation that the certificate belongs to. ||
|| name | **string**

Name of the certificate. ||
|| description | **string**

Description of the certificate. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| data | **string**

Required field. Certificate data in PEM format. ||
|#
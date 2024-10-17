---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/saml/api-ref/grpc/Certificate/list.md
---

# Cloud Organization SAML API, gRPC: CertificateService.List {#List}

Retrieves the list of certificates in the specified federation.

## gRPC request

**rpc List ([ListCertificatesRequest](#yandex.cloud.organizationmanager.v1.saml.ListCertificatesRequest)) returns ([ListCertificatesResponse](#yandex.cloud.organizationmanager.v1.saml.ListCertificatesResponse))**

## ListCertificatesRequest {#yandex.cloud.organizationmanager.v1.saml.ListCertificatesRequest}

```json
{
  "federationId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| federationId | **string**

Required field. ID of the federation to list certificates in.
To get the federation ID make a [yandex.cloud.organizationmanager.v1.saml.FederationService.List](/docs/organization/api-ref/grpc/Federation/list#List) request. ||
|| pageSize | **int64**

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

## ListCertificatesResponse {#yandex.cloud.organizationmanager.v1.saml.ListCertificatesResponse}

```json
{
  "certificates": [
    {
      "id": "string",
      "federationId": "string",
      "name": "string",
      "description": "string",
      "createdAt": "google.protobuf.Timestamp",
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| data | **string**

Required field. Certificate data in PEM format. ||
|#
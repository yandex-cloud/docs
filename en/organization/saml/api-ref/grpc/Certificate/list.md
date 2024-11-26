---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/saml/api-ref/grpc/Certificate/list.md
---

# SAML Federation API, gRPC: CertificateService.List

Retrieves the list of certificates in the specified federation.

## gRPC request

**rpc List ([ListCertificatesRequest](#yandex.cloud.organizationmanager.v1.saml.ListCertificatesRequest)) returns ([ListCertificatesResponse](#yandex.cloud.organizationmanager.v1.saml.ListCertificatesResponse))**

## ListCertificatesRequest {#yandex.cloud.organizationmanager.v1.saml.ListCertificatesRequest}

```json
{
  "federation_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| federation_id | **string**

Required field. ID of the federation to list certificates in.
To get the federation ID make a [yandex.cloud.organizationmanager.v1.saml.FederationService.List](/docs/organization/api-ref/grpc/Federation/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListCertificatesResponse.next_page_token](#yandex.cloud.organizationmanager.v1.saml.ListCertificatesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token`
to the [ListCertificatesResponse.next_page_token](#yandex.cloud.organizationmanager.v1.saml.ListCertificatesResponse)
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
      "federation_id": "string",
      "name": "string",
      "description": "string",
      "created_at": "google.protobuf.Timestamp",
      "data": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| certificates[] | **[Certificate](#yandex.cloud.organizationmanager.v1.saml.Certificate)**

List of certificates. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListCertificatesRequest.page_size](#yandex.cloud.organizationmanager.v1.saml.ListCertificatesRequest), use
the `next_page_token` as the value
for the [ListCertificatesRequest.page_token](#yandex.cloud.organizationmanager.v1.saml.ListCertificatesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Certificate {#yandex.cloud.organizationmanager.v1.saml.Certificate}

A certificate.

#|
||Field | Description ||
|| id | **string**

Required field. ID of the certificate. ||
|| federation_id | **string**

Required field. ID of the federation that the certificate belongs to. ||
|| name | **string**

Name of the certificate. ||
|| description | **string**

Description of the certificate. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| data | **string**

Required field. Certificate data in PEM format. ||
|#
---
editable: false
sourcePath: en/_api-ref-grpc/certificatemanager/v1/api-ref/grpc/Certificate/listVersions.md
---

# Certificate Manager API, gRPC: CertificateService.ListVersions {#ListVersions}

## gRPC request

**rpc ListVersions ([ListVersionsRequest](#yandex.cloud.certificatemanager.v1.ListVersionsRequest)) returns ([ListVersionsResponse](#yandex.cloud.certificatemanager.v1.ListVersionsResponse))**

## ListVersionsRequest {#yandex.cloud.certificatemanager.v1.ListVersionsRequest}

```json
{
  "certificateId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| certificateId | **string**

Required field. ID of the certificate to list versions for. ||
|| pageSize | **int64**

Page token. To get the next page of results, set `page_token` to the
[ListCertificatesResponse.nextPageToken](/docs/certificate-manager/api-ref/grpc/Certificate/list#yandex.cloud.certificatemanager.v1.ListCertificatesResponse) returned by a previous list request. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListCertificatesResponse.nextPageToken](/docs/certificate-manager/api-ref/grpc/Certificate/list#yandex.cloud.certificatemanager.v1.ListCertificatesResponse) returned by a previous list request. ||
|#

## ListVersionsResponse {#yandex.cloud.certificatemanager.v1.ListVersionsResponse}

```json
{
  "versions": [
    {
      "id": "string",
      "certificateId": "string",
      "createdAt": "google.protobuf.Timestamp"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| versions[] | **[Version](#yandex.cloud.certificatemanager.v1.Version)**

List of versions for the specified certificate. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number
of results is greater than the specified [ListCertificatesRequest.pageSize](/docs/certificate-manager/api-ref/grpc/Certificate/list#yandex.cloud.certificatemanager.v1.ListCertificatesRequest), use
the `next_page_token` as the value for the [ListCertificatesRequest.pageToken](/docs/certificate-manager/api-ref/grpc/Certificate/list#yandex.cloud.certificatemanager.v1.ListCertificatesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Version {#yandex.cloud.certificatemanager.v1.Version}

A certificate version

#|
||Field | Description ||
|| id | **string**

ID of the version. ||
|| certificateId | **string**

ID of the certificate that the version belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the version was created. ||
|#
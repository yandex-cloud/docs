---
editable: false
sourcePath: en/_api-ref/certificatemanager/v1/api-ref/Certificate/listVersions.md
---

# Certificate Manager API, REST: Certificate.ListVersions {#ListVersions}

## HTTP request

```
GET https://{{ api-host-certmanager }}/certificate-manager/v1/certificates/{certificateId}/versions
```

## Path parameters

#|
||Field | Description ||
|| certificateId | **string**

Required field. ID of the certificate to list versions for. ||
|#

## Query parameters {#yandex.cloud.certificatemanager.v1.ListVersionsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

Page token. To get the next page of results, set `page_token` to the
[ListCertificatesResponse.nextPageToken](/docs/certificate-manager/api-ref/Certificate/list#yandex.cloud.certificatemanager.v1.ListCertificatesResponse) returned by a previous list request. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListCertificatesResponse.nextPageToken](/docs/certificate-manager/api-ref/Certificate/list#yandex.cloud.certificatemanager.v1.ListCertificatesResponse) returned by a previous list request. ||
|#

## Response {#yandex.cloud.certificatemanager.v1.ListVersionsResponse}

**HTTP Code: 200 - OK**

```json
{
  "versions": [
    {
      "id": "string",
      "certificateId": "string",
      "createdAt": "string"
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
of results is greater than the specified [ListCertificatesRequest.pageSize](/docs/certificate-manager/api-ref/Certificate/list#yandex.cloud.certificatemanager.v1.ListCertificatesRequest), use
the `next_page_token` as the value for the [ListCertificatesRequest.pageToken](/docs/certificate-manager/api-ref/Certificate/list#yandex.cloud.certificatemanager.v1.ListCertificatesRequest) query parameter
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
|| createdAt | **string** (date-time)

Time when the version was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#
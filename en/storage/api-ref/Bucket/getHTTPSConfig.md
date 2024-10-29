---
editable: false
sourcePath: en/_api-ref/storage/v1/api-ref/Bucket/getHTTPSConfig.md
---

# Object Storage API, REST: Bucket.GetHTTPSConfig {#GetHTTPSConfig}

Returns the HTTPS configuration for the specified bucket.

## HTTP request

```
GET https://storage.{{ api-host }}/storage/v1/buckets/{name}:getHttpsConfig
```

## Path parameters

#|
||Field | Description ||
|| name | **string**

Required field. Name of the bucket to return the HTTPS configuration for. ||
|#

## Response {#yandex.cloud.storage.v1.HTTPSConfig}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "sourceType": "string",
  "issuer": "string",
  "subject": "string",
  "dnsNames": [
    "string"
  ],
  "notBefore": "string",
  "notAfter": "string",
  "certificateId": "string"
}
```

A resource for HTTPS configuration of a bucket.

#|
||Field | Description ||
|| name | **string**

Name of the bucket. ||
|| sourceType | **enum** (SourceType)

Type of TLS certificate source.

- `SOURCE_TYPE_UNSPECIFIED`
- `SOURCE_TYPE_SELF_MANAGED`: Your certificate, uploaded directly.
- `SOURCE_TYPE_MANAGED_BY_CERTIFICATE_MANAGER`: Certificate managed by Certificate Manager. ||
|| issuer | **string**

Issuer of the TLS certificate. ||
|| subject | **string**

Subject of the TLS certificate. ||
|| dnsNames[] | **string**

List of DNS names of the TLS certificate (Subject Alternative Name field). ||
|| notBefore | **string** (date-time)

Start of the TLS certificate validity period (Not Before field).

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| notAfter | **string** (date-time)

End of the TLS certificate validity period (Not After field)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| certificateId | **string**

ID of the TLS certificate in Certificate Manager.

To get information about the certificate from Certificate Manager, make a
[yandex.cloud.certificatemanager.v1.CertificateService.Get](/docs/certificate-manager/api-ref/Certificate/get#Get) request. ||
|#
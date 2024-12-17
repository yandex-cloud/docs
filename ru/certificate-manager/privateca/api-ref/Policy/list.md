---
editable: false
sourcePath: en/_api-ref/certificatemanager/v1/privateca/api-ref/Policy/list.md
---

# Certificate Manager Private CA API, REST: Policy.List

Retrieves the list of policies of the specified certificate authority.

## HTTP request

```
GET https://private-ca.certificate-manager.{{ api-host }}/privateca/v1/policies
```

## Query parameters {#yandex.cloud.certificatemanager.v1.privateca.ListPolicyRequest}

Request message for listing policies.

#|
||Field | Description ||
|| certificateAuthorityId | **string**

Required field. ID of the certificate authority to list policies for. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.
If the number of available results is larger than `page_size`,
the service returns a next_page_token.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListPolicyResponse.nextPageToken](#yandex.cloud.certificatemanager.v1.privateca.ListPolicyResponse) returned by a previous list request. ||
|#

## Response {#yandex.cloud.certificatemanager.v1.privateca.ListPolicyResponse}

**HTTP Code: 200 - OK**

```json
{
  "policy": [
    {
      "id": "string",
      "certificateAuthorityId": "string",
      "name": "string",
      "subjectPolicy": {
        "country": "string",
        "organization": "string",
        "organizationalUnit": "string",
        "distinguishedNameQualifier": "string",
        "stateOrProvince": "string",
        "commonName": "string",
        "emailAddress": "string",
        "serialNumber": "string",
        "locality": "string",
        "title": "string",
        "surname": "string",
        "givenName": "string",
        "initials": "string",
        "generationQualifier": "string"
      },
      "sanPolicy": {
        "otherNameOid": "string",
        "rfc_822Name": "string",
        "dnsName": "string",
        "directoryName": "string",
        "ediPartyName": {
          "nameAssigner": "string",
          "partyName": "string"
        },
        "uniformResourceIdentifier": "string",
        "ipAddress": "string",
        "registeredId": "string"
      },
      // Includes only one of the fields `keyUsagesWhiteList`, `keyUsagesBlackList`
      "keyUsagesWhiteList": {
        "keyUsage": [
          "string"
        ]
      },
      "keyUsagesBlackList": {
        "keyUsage": [
          "string"
        ]
      },
      // end of the list of possible fields
      // Includes only one of the fields `extendedKeyUsagesWhiteList`, `extendedKeyUsagesBlackList`
      "extendedKeyUsagesWhiteList": {
        "extendedKeyUsage": [
          "string"
        ]
      },
      "extendedKeyUsagesBlackList": {
        "extendedKeyUsage": [
          "string"
        ]
      },
      // end of the list of possible fields
      // Includes only one of the fields `extensionWhiteList`, `extensionBlackList`
      "extensionWhiteList": {
        "extensionOid": [
          "string"
        ]
      },
      "extensionBlackList": {
        "extensionOid": [
          "string"
        ]
      },
      // end of the list of possible fields
      "createdAt": "string",
      "updatedAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

Response message for listing policies.

#|
||Field | Description ||
|| policy[] | **[Policy](#yandex.cloud.certificatemanager.v1.privateca.Policy)**

List of policies for the specified certificate authority. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. ||
|#

## Policy {#yandex.cloud.certificatemanager.v1.privateca.Policy}

A policy defines the rules and constraints for issuing certificates within a certificate authority.

#|
||Field | Description ||
|| id | **string**

ID of the policy. ||
|| certificateAuthorityId | **string**

ID of the certificate authority the policy belongs to. ||
|| name | **string**

Name of the policy. ||
|| subjectPolicy | **[SubjectPolicy](#yandex.cloud.certificatemanager.v1.privateca.SubjectPolicy)**

Policy for the subject field of the certificate. ||
|| sanPolicy | **[SubjectAlternativeNamePolicy](#yandex.cloud.certificatemanager.v1.privateca.SubjectAlternativeNamePolicy)**

Policy for the Subject Alternative Name (SAN) extension of the certificate. ||
|| keyUsagesWhiteList | **[KeyUsagePolicy](#yandex.cloud.certificatemanager.v1.privateca.KeyUsagePolicy)**

Whitelist of allowed key usages.

Includes only one of the fields `keyUsagesWhiteList`, `keyUsagesBlackList`.

Policy for key usages. ||
|| keyUsagesBlackList | **[KeyUsagePolicy](#yandex.cloud.certificatemanager.v1.privateca.KeyUsagePolicy)**

Blacklist of disallowed key usages.

Includes only one of the fields `keyUsagesWhiteList`, `keyUsagesBlackList`.

Policy for key usages. ||
|| extendedKeyUsagesWhiteList | **[ExtendedKeyUsagePolicy](#yandex.cloud.certificatemanager.v1.privateca.ExtendedKeyUsagePolicy)**

Whitelist of allowed extended key usages.

Includes only one of the fields `extendedKeyUsagesWhiteList`, `extendedKeyUsagesBlackList`.

Policy for extended key usages. ||
|| extendedKeyUsagesBlackList | **[ExtendedKeyUsagePolicy](#yandex.cloud.certificatemanager.v1.privateca.ExtendedKeyUsagePolicy)**

Blacklist of disallowed extended key usages.

Includes only one of the fields `extendedKeyUsagesWhiteList`, `extendedKeyUsagesBlackList`.

Policy for extended key usages. ||
|| extensionWhiteList | **[ExtensionPolicy](#yandex.cloud.certificatemanager.v1.privateca.ExtensionPolicy)**

Whitelist of allowed extensions.

Includes only one of the fields `extensionWhiteList`, `extensionBlackList`.

Policy for certificate extensions. ||
|| extensionBlackList | **[ExtensionPolicy](#yandex.cloud.certificatemanager.v1.privateca.ExtensionPolicy)**

Blacklist of disallowed extensions.

Includes only one of the fields `extensionWhiteList`, `extensionBlackList`.

Policy for certificate extensions. ||
|| createdAt | **string** (date-time)

Timestamp when the policy was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Timestamp when the policy was last updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## SubjectPolicy {#yandex.cloud.certificatemanager.v1.privateca.SubjectPolicy}

Policy for the subject field of a certificate. Each string field could be a regexp

#|
||Field | Description ||
|| country | **string**

Allowed country name in the subject field. ||
|| organization | **string**

Allowed organization name in the subject field. ||
|| organizationalUnit | **string**

Allowed organizational unit name in the subject field. ||
|| distinguishedNameQualifier | **string**

Allowed distinguished name qualifier in the subject field. ||
|| stateOrProvince | **string**

Allowed state or province name in the subject field. ||
|| commonName | **string**

Allowed common name in the subject field. ||
|| emailAddress | **string**

Allowed email address in the subject field. ||
|| serialNumber | **string**

Allowed serial number in the subject field. ||
|| locality | **string**

Allowed locality name in the subject field. ||
|| title | **string**

Allowed title in the subject field. ||
|| surname | **string**

Allowed surname in the subject field. ||
|| givenName | **string**

Allowed given name in the subject field. ||
|| initials | **string**

Allowed initials in the subject field. ||
|| generationQualifier | **string**

Allowed generation qualifier in the subject field. ||
|#

## SubjectAlternativeNamePolicy {#yandex.cloud.certificatemanager.v1.privateca.SubjectAlternativeNamePolicy}

Policy for the Subject Alternative Name (SAN) field of a certificate. Each string field could be a regexp

#|
||Field | Description ||
|| otherNameOid | **string**

Allowed OIDs of the other name in the SAN field. ||
|| rfc_822Name | **string**

Allowed RFC 822 names (email addresses) in the SAN field. ||
|| dnsName | **string**

Allowed DNS names in the SAN field. ||
|| directoryName | **string**

Allowed directory names in the SAN field. ||
|| ediPartyName | **[EdiPartyName](#yandex.cloud.certificatemanager.v1.privateca.EdiPartyName)**

Allowed EDI party names in the SAN field. ||
|| uniformResourceIdentifier | **string**

Allowed URIs in the SAN field. ||
|| ipAddress | **string**

Allowed IP addresses in the SAN field. ||
|| registeredId | **string**

Allowed registered IDs in the SAN field. ||
|#

## EdiPartyName {#yandex.cloud.certificatemanager.v1.privateca.EdiPartyName}

#|
||Field | Description ||
|| nameAssigner | **string**

Specifies the entity or authority that assigned the partyName ||
|| partyName | **string**

The actual identifier of the EDI party ||
|#

## KeyUsagePolicy {#yandex.cloud.certificatemanager.v1.privateca.KeyUsagePolicy}

Policy for key usages in a certificate.

#|
||Field | Description ||
|| keyUsage[] | **enum** (KeyUsageExtension)

List of key usages that are allowed or disallowed.

- `KEY_USAGE_EXTENSION_UNSPECIFIED`
- `DIGITAL_SIGNATURE`
- `CONTENT_COMMITMENT`
- `KEY_ENCIPHERMENT`
- `DATA_ENCIPHERMENT`
- `KEY_AGREEMENT`
- `KEY_CERT_SIGN`
- `CRL_SIGN`
- `ENCIPHER_ONLY`
- `DECIPHER_ONLY` ||
|#

## ExtendedKeyUsagePolicy {#yandex.cloud.certificatemanager.v1.privateca.ExtendedKeyUsagePolicy}

Policy for extended key usages in a certificate.

#|
||Field | Description ||
|| extendedKeyUsage[] | **enum** (ExtendedKeyUsageExtension)

List of extended key usages that are allowed or disallowed.

- `EXTENDED_KEY_USAGE_EXTENSION_UNSPECIFIED`
- `SERVER_AUTH`
- `CLIENT_AUTH`
- `CODE_SIGNING`
- `EMAIL_PROTECTION`
- `TIME_STAMPING`
- `OCSP_SIGNING`
- `IPSEC_IKE`
- `MS_CODE_IND`
- `MS_CODE_COM`
- `MS_CTL_SIGN`
- `MS_EFS` ||
|#

## ExtensionPolicy {#yandex.cloud.certificatemanager.v1.privateca.ExtensionPolicy}

Policy for certificate extensions.

#|
||Field | Description ||
|| extensionOid[] | **string**

List of extension OIDs that are allowed or disallowed. ||
|#
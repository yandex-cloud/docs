# GetDomainIdentity method

This method returns information on an [address](../../concepts/glossary.md#adress) in a folder. The folder is selected based on the service account the request originates from.

## Request {#request}

```http
GET /v2/email/identities/{DomainIdentity} HTTP/2
```

### Path parameters {#path-parameters}

#|
|| **Parameter** | **Description** ||
|| `DomainIdentity` | **Type**: String.

Address you are requesting info on. The minimum length is one character. ||
|#

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

## Responses {#responses}

### 200 OK {#200}

```json
{
  "IdentityType": "<address_type>",
  "FeedbackForwardingStatus": <issue_notification_status>,
  "VerifiedForSendingStatus": <verification_status_for_sending_emails>,
  "DkimAttributes": {
    "SigningEnabled": <DKIM_usage>,
    "Status": "<DKIM_search_status>",
    "Tokens": [
      "<public_key_selector>"
    ],
    "SigningAttributesOrigin": "<DKIM_configuration_method>",
    "NextSigningKeyLength": "<compatibility_parameter>",
    "CurrentSigningKeyLength": "<compatibility_parameter>"
  },
  "Tags": [
    {
      "Key": "<label_key>",
      "Value": "<label_value>"
    }
  ],
  "ConfigurationSetName": "<configuration_name>",
  "VerificationStatus": "<address_verification_status>"
}
```

#|
|| **Parameter** | **Description** ||
|| `IdentityType` | **Type**: String.

Address type. Value: `DOMAIN`. ||
|| `FeedbackForwardingStatus` | **Type**: Boolean.

The possible values are `true` or `false`. If set to `true`, you will be getting notifications about issues with delivering and sending emails. ||
|| `VerifiedForSendingStatus` | **Type**: Boolean.

Indicates whether the address can be used to send emails. The possible values are `true` or `false`.
To send emails, you need to verify the address. ||
|| `DkimAttributes` | **Type**: Object.

Object that contains the DKIM signature parameters. ||
|| `SigningEnabled` | **Type**: Boolean.

Indicates whether a DKIM signature is used when sending from this address. The possible values are `true` or `false`. ||
|| `Status` | **Type**: String.

Indicates whether {{ postbox-name }} was able to detect a DKIM signature in the DNS configuration of the address. The possible values are:
  * `PENDING`: Search is ongoing, but {{ postbox-name }} has not yet detected a DKIM signature in the DNS configuration of this address.
  * `SUCCESS`: DKIM signature detected.
  * `FAILED`: Failed to detect a DKIM signature.
  * `TEMPORARY_FAILURE`: {{ postbox-name }} is not able to detect a DKIM signature due to a temporary issue.
  * `NOT_STARTED`: Search was not started. ||
|| `Tokens` | **Type**: Array.
  
List of selectors for public key identification. Selector type: String. ||
|| `SigningAttributesOrigin` | **Type**: String.

Indicates how the DKIM signature was configured. `EXTERNAL` means that the DKIM signature was configured using BYODKIM. ||
|| `NextSigningKeyLength` | **Type**: String.

Only used to ensure compatibility with AWS. ||
|| `CurrentSigningKeyLength` | **Type**: String.

Only used to ensure compatibility with AWS. ||
|| `Tags` | **Type**: Array.

Address label array. ||
|| `ConfigurationSetName` | **Type**: String.

Configuration name. ||
|| `VerificationStatus` | **Type**: String.

Verification status:
  * `PENDING`: Verification is ongoing, but so far {{ postbox-name }} was not able to verify the address.
  * `SUCCESS`: Address successfully verified.
  * `FAILED`: Verification failed.
  * `TEMPORARY_FAILURE`: {{ postbox-name }} is not able to identify the verification status due to a temporary issue.
  * `NOT_STARTED`: Verification was not started. ||
|#

### Errors {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

Possible errors:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request contains invalid headers or parameters. ||
|| `404 NotFoundException` | The requested resource was not found. ||
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|#
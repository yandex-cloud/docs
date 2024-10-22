# CreateDomainIdentity method

This method creates an [address](../../concepts/glossary.md#adress) in a folder. The folder is selected based on the service account the request originates from.

## Request {#request}

```http
POST /v2/email/identities HTTP/2
```

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

### Request body {#request-body}

```json
{
  "EmailIdentity": "<address>",
  "Tags": [
    {
      "Key": "<label_key>",
      "Value": "<label_value>"
    }
  ],
  "DkimSigningAttributes": {
    "DomainSigningSelector": "<selector_name>",
    "DomainSigningPrivateKey": "<private_key>"
  },
  "ConfigurationSetName": "<configuration_name>"
}
```

#|
|| **Parameter** | **Description** ||
|| `EmailIdentity` | **Type**: String.

Address. ||
|| `Tags` | **Type**: Array.

Address label array.

The maximum number of labels is 50. ||
|| `Key` | **Type**: String.

Label key.

The keyword may be from 1 to 63 characters long. ||
|| `Value` | **Type**: String.

Label value.

It may be from 0 (no value) to 256 characters long. ||
|| `DkimSigningAttributes` | **Type**: Object.

Object containing parameters for creating a DKIM signature. ||
|| `DomainSigningSelector` | **Type**: String.

Name of the selector used to identify the public key in the domain’s DNS configuration.

The selector name may be from 1 to 63 characters long. ||
|| `DomainSigningPrivateKey` | **Type**: String.

Private key used to generate a DKIM signature. The private key must use 1,024-bit or 2,048-bit RSA encryption and base64 encoding.

It may be from 1 to 20,480 characters long. ||
|| `ConfigurationSetName` | **Type**: String.

Name of the configuration you want to link to the address. The configuration must reside in the same folder as the address. ||
|#

## Responses {#responses}

### 200 OK {#200}

```json
{
  "IdentityType": "<address_type>",
  "VerifiedForSendingStatus": <verification_status_for_sending_emails>,
  "DkimAttributes": {
    "SigningEnabled": <use_DKIM>,
    "Status": "<DKIM_search_status>",
    "Tokens": [
      "<public_key_selector>"
    ],
    "SigningAttributesOrigin": "<DKIM_configuration_method>",
    "NextSigningKeyLength": "<next_key_length>",
    "CurrentSigningKeyLength": "<current_key_length>"
  }
}
```

#|
|| **Parameter** | **Description** ||
|| `IdentityType` | **Type**: String.

Address type. The possible value is `DOMAIN`. ||
|| `VerifiedForSendingStatus` | **Type**: Boolean.

Indicates whether address ownership is verified. The possible values are `true` or `false`.

You can send emails only from verified addresses. ||
|| `DkimAttributes` | **Type**: Object.

Object containing the DKIM signature parameters. ||
|| `SigningEnabled` | **Type**: Boolean.

Indicates whether a given address uses DKIM signing for sending emails. The possible values are `true` or `false`. ||
|| `Status` | **Type**: String.

Indicates whether {{ postbox-name }} was able to detect a DKIM signature in the DNS configuration of the address. The possible values are:

  * `PENDING`: Search is in progress, but {{ postbox-name }} has not yet detected a DKIM signature in the address DNS configuration.
  * `SUCCESS`: DKIM signature detected.
  * `FAILED`: Failed to detect a DKIM signature.
  * `TEMPORARY_FAILURE`: {{ postbox-name }} is not able to detect a DKIM signature due to a temporary issue.
  * `NOT_STARTED`: Search was not started. ||
|| `Tokens` | **Type**: Array.

List of selectors for public key identification. Selector type: String. ||
|| `SigningAttributesOrigin` | **Type**: String.

Indicates how DKIM signing was configured. `EXTERNAL`: DKIM was configured using BYODKIM. ||
|| `NextSigningKeyLengths` | **Type**: String.

Used exclusively for compatibility with AWS. ||
|| `CurrentSigningKeyLength` | **Type**: String.

Used exclusively for compatibility with AWS. ||
|#

The `200 OK` response may contain additional parameters. Its format may vary slightly from the above.

### Errors {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

Possible errors:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request contains invalid headers or parameters. ||
|| `404 NotFoundException` | The requested resource was not found. ||
|| `409 AlreadyExistsException` | A configuration with this name already exists. Specify a different name. ||
|| `409 ConcurrentModificationException` | There are conflicting operations. Wait for the previous operation to complete and repeat your request. ||
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|| `429 LimitExceededException` | The request [limit](../../concepts/limits.md) was exceeded. ||
|#

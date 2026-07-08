# CreateDomainIdentity method

This method creates an [address](../../concepts/glossary.md#adress) in a folder. The folder is selected based on the service account the request originates from.

When creating an address, you can set up the [DKIM signature](../../concepts/glossary.md#dkim) in one of these two ways:

* Simple (Easy DKIM): {{ postbox-name }} generates and stores DKIM keys all by itself. Used by default if the `DkimSigningAttributes` object is not provided or has only the `NextSigningKeyLength` field specified. In the response, the service returns selectors (`Tokens`) based on which you need to add CNAME records to the DNS of the user domain.
* Advanced (BYODKIM): A key is provided by the user. This method can be used only if both fields, `DomainSigningSelector` and `DomainSigningPrivateKey`, are provided in the `DkimSigningAttributes` object.


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
    "NextSigningKeyLength": "<key_length>",
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

Optional object containing the DKIM signature parameters. The DKIM configuration method is determined by the object's contents:

  * Easy DKIM: If the object is not provided or has only the `NextSigningKeyLength` field specified.
  * BYODKIM: If both fields are provided, `DomainSigningSelector` and `DomainSigningPrivateKey`.

If the object is not provided, the simple DKIM setting with a 2048-bit RSA key is used.

The request will fail if you provide only one of the two fields (`DomainSigningSelector` or `DomainSigningPrivateKey`), or provide `NextSigningKeyLength` together with these fields. ||
|| `NextSigningKeyLength` | **Type**: String.

This is an optional field. Length of the RSA key {{ postbox-name }} will generate when setting up Easy DKIM. The possible values are:

  * `RSA_2048_BIT`: 2048-bit key. This is a default value.
  * `RSA_1024_BIT`: 1024-bit key.

You cannot provide this field together with the `DomainSigningSelector` and `DomainSigningPrivateKey` fields. ||
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

Object that contains the DKIM signature parameters. ||
|| `SigningEnabled` | **Type**: Boolean.

Indicates whether a DKIM signature is used when sending from this address. The possible values are `true` or `false`. ||
|| `Status` | **Type**: String.

Indicates whether {{ postbox-name }} was able to detect a DKIM signature in the DNS configuration of the address. The possible values are:

  * `PENDING`: Search is in progress, but {{ postbox-name }} has not yet detected a DKIM signature in the address DNS configuration.
  * `SUCCESS`: DKIM signature detected.
  * `FAILED`: Failed to detect a DKIM signature.
  * `TEMPORARY_FAILURE`: {{ postbox-name }} is not able to detect a DKIM signature due to a temporary issue.
  * `NOT_STARTED`: Search was not started. ||
|| `Tokens` | **Type**: Array.

List of selectors for public key identification. The Easy DKIM setup returns two selectors: for each one, you need to add a CNAME record to the DNS of the user domain to [verify domain ownership](../../operations/check-domain.md). Selector type: String. ||
|| `SigningAttributesOrigin` | **Type**: String.

Indicates how the DKIM signature was configured. The possible values are:

  * `AWS_SES`: Easy DKIM. DKIM keys generated by {{ postbox-name }}.
  * `EXTERNAL`: BYODKIM. A key is provided by the user. ||
|| `NextSigningKeyLength` | **Type**: String.

Length of the RSA key that will be used for the next DKIM key rotation when using Easy DKIM. It can be either `RSA_2048_BIT` or `RSA_1024_BIT`. ||
|| `CurrentSigningKeyLength` | **Type**: String.

Length of the current RSA key used for DKIM signing when using Easy DKIM. It can be either `RSA_2048_BIT` or `RSA_1024_BIT`. ||
|#

The `200 OK` response may contain additional parameters. Its format may vary slightly from the above.

### Errors {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

The possible errors include:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request contains invalid headers or parameters. ||
|| `404 NotFoundException` | The requested resource was not found. ||
|| `409 AlreadyExistsException` | A configuration with this name already exists. Specify a different name. ||
|| `409 ConcurrentModificationException` | There are conflicting operations. Wait for the previous operation to complete and repeat your request. ||
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|| `429 LimitExceededException` | The request [limit](../../concepts/limits.md) was exceeded. ||
|#

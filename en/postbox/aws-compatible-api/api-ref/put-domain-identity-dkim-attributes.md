# PutDomainIdentityDkimAttributes method

Enables or disables [DKIM signing](https://en.wikipedia.org/wiki/DomainKeys_Identified_Mail) for an [address](../../concepts/glossary.md#adress). This option allows the recipient to check that an email was indeed sent from the claimed domain. It is used for anti-phishing and anti-spam measures.

## Request {#request}

```http
PUT /v2/email/identities/{DomainIdentity}/dkim HTTP/2
```

### Path parameters {#path-parameters}

#|
|| **Parameter** | **Description** ||
|| `DomainIdentity` | **Type**: String.

Address to enable or disable DKIM authentication for. The minimum length is one character. ||
|#

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

### Request body {#request-body}

```json
{
  "SigningEnabled": <DKIM_usage>
}
```

#|
|| **Parameter** | **Description** ||
|| `SigningEnabled` | **Type**: Boolean.

Enables or disables DKIM signing for sending emails from the specified address. Possible values: `true` or `false`. ||
|#

## Responses {#responses}

### 200 OK {#200}

{% include [api-response-200](../../../_includes/postbox/api-response-200.md) %}

### Errors {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

Possible errors:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request contains invalid headers or parameters. ||
|| `404 NotFoundException` | The requested resource was not found. ||
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|#
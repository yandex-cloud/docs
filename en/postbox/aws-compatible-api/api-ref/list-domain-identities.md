# ListDomainIdentities method

Returns a list of [addresses](../../concepts/glossary.md#adress) in a folder. The folder is selected based on the service account the request originates from.

## Request {#request}

```http
GET /v2/email/identities HTTP/2
```

### Query parameters {#query-parameters}

#|
|| **Parameter** | **Description** ||
|| `PageSize` | **Type**: Integer.

Maximum number of results you can get on one page in response to your request. If the number of results exceeds the `PageSize` value, the response returns the `NextToken` token to request the next results page.

The maximum permissible value for the parameter is `1000`. ||
|| `NextToken` | **Type**: String.

Token to get the next results page in response to a request. To do this, provide the `NextToken` value you get in response to your previous request.

The maximum string length for the parameter is 100 characters. ||
|#

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

## Responses {#responses}

### 200 OK {#200}

```json
{
  "EmailIdentities": [
    {
      "IdentityType": "<address_type>",
      "IdentityName": "<address>",
      "SendingEnabled": <address_state>,
      "VerificationStatus": "<verification_status>"
    }
  ],
  "NextToken": "<token>"
}
```

#|
|| **Parameter** | **Description** ||
|| `EmailIdentities` | **Type**: Array.

Array of addresses. ||
|| `IdentityType` | **Type**: String.

Type of address. Possible value: `DOMAIN`. ||
|| `IdentityName` | **Type**: String.

Address. ||
|| `SendingEnabled` | **Type**: Boolean.

Indicates whether you can send emails from this address. Possible values: `true` or `false`.

Before sending emails from this address, you must pass a verification as its owner. ||
|| `VerificationStatus` | **Type**: String.

Verification status:

* `PENDING`: Verification is ongoing, but so far {{ postbox-name }} has not verified the address.
* `SUCCESS`: Address successfully verified.
* `FAILED`: Verification failed.
* `TEMPORARY_FAILURE`: {{ postbox-name }} cannot detect the verification status due to a temporary issue.
* `NOT_STARTED`: Verification was not started. ||

|| `NextToken` | **Type**: String.

Token to get the next results page in response to a request. If the number of results exceeds the `PageSize` value, the response returns the `NextToken` token to request the next results page. Each page gets its own token for pagination. ||
|#

The `200 OK` response may contain additional parameters. Its format may vary slightly from the above.

### Errors {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

Possible errors:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request contains invalid headers or parameters. ||
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|#

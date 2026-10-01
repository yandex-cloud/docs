# GetSuppressedDestination method

Returns information about an address on the [custom suppression list](../../concepts/suppression-list.md#user). The cloud is determined based on the service account the request originates from.

## Request {#request}

```http
GET /v2/email/suppression/addresses/{EmailAddress} HTTP/2
```

### Path parameters {#path-parameters}

#|
|| **Parameter** | **Description** ||
|| `EmailAddress` | **Type**: String.

Recipient's address. Use percent encoding, e.g., `user%40example.com`. ||
|#

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

## Responses {#responses}

### 200 OK {#200}

```json
{
   "SuppressedDestination": {
      "EmailAddress": "user@example.com",
      "Reason": "BOUNCE",
      "LastUpdateTime": 1586552585.000,
      "Attributes": {
         "MessageId": "0000018f-..."
      }
   }
}
```

#|
|| **Parameter** | **Description** ||
|| `EmailAddress` | **Type**: String.

Recipient's address. ||
|| `Reason` | **Type**: String.

Reason to add the address to the suppression list: `BOUNCE` or `COMPLAINT` ||
|| `LastUpdateTime` | **Type**: Number.

The entry's last modification time in seconds, Unix format. ||
|| `Attributes` | **Type**: Object.

Returned only if the address was added to the suppression list automatically. Contains the `MessageId` field, i.e., the ID of the message due to which the address was added to the suppression list. There is no such an object for addresses added manually. ||
|#

### Errors {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

The possible errors include:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request gives an empty or invalid address. ||
|| `403` | Not enough permissions to execute the request. ||
|| `404 NotFoundException` | The address is not on the suppression list. ||
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|#

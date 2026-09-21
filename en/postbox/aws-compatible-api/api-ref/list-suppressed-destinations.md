# ListSuppressedDestinations method

Returns a list of addresses on the [custom suppression list](../../concepts/suppression-list.md#user). The cloud is determined based on the service account the request originates from.

## Request {#request}

```http
GET /v2/email/suppression/addresses HTTP/2
```

### Query parameters {#query-parameters}

#|
|| **Parameter** | **Description** ||
|| `PageSize` | **Type**: Integer.

Maximum number of results you can get on one page in response to your request. The default value is `100`; the maximum allowed value is `1000`. Values exceeding `1000` automatically default to `1000`. Negative values return an error. ||
|| `NextToken` | **Type**: String.

Token to get the next results page in response to a request. To do this, provide the `NextToken` value you get in response to your previous request. Token values cannot be manually parsed or generated. ||
|| `Reason` | **Type**: String.

Reason to add the address to the suppression list: `BOUNCE` or `COMPLAINT`. You can specify this parameter multiple times. If omitted, all addresses are returned regardless of the reason. ||
|| `StartDate` | **Type**: String.

Lower limit for the entry’s last modification time (inclusive). ||
|| `EndDate` | **Type**: String.

Upper limit for the entry’s last modification time (inclusive). ||
|#

Dates must be specified in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format (`2026-01-01T00:00:00Z`) or as a Unix timestamp in seconds. The allowed date range is from January 1, 1970 to December 31, 2105. `StartDate` must be less than or equal to `EndDate`.

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

## Responses {#responses}

### 200 OK {#200}

```json
{
   "SuppressedDestinationSummaries": [
      {
         "EmailAddress": "user@example.com",
         "Reason": "COMPLAINT",
         "LastUpdateTime": 1586552585.000
      }
   ],
   "NextToken": "<token>"
}
```

#|
|| **Parameter** | **Description** ||
|| `SuppressedDestinationSummaries` | **Type**: Array.

Array of suppression list addresses. Addresses are sorted from most recently modified to oldest. ||
|| `EmailAddress` | **Type**: String.

Recipient's address. ||
|| `Reason` | **Type**: String.

Reason to add the address to the suppression list: `BOUNCE` or `COMPLAINT` ||
|| `LastUpdateTime` | **Type**: Number.

The entry's last modification time in seconds, Unix format. ||
|| `NextToken` | **Type**: String.

Token to get the next results page in response to a request. It is returned only if the current page is full. An empty value indicates there is no more data. ||
|#

### Errors {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

The possible errors include:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request contains invalid headers or parameters: incorrect `NextToken`, negative `PageSize`, invalid or conflicting `StartDate` and `EndDate`. ||
|| `403` | Not enough permissions to execute the request. ||
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|#

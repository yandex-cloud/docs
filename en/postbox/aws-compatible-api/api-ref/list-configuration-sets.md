# ListConfigurationSets method

Returns the list of [configurations](../../concepts/glossary.md#configuration) in a folder. The folder is selected based on the service account the request originates from.

## Request {#request}

```http
GET /v2/email/configuration-sets HTTP/2
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

Use [common request headers](request-headers.md) in your requests.

## Responses {#responses}

### 200 OK {#200}

```json
{
   "ConfigurationSets": [
      "<configuration_1_name>",
      "<configuration_2_name>",
      ...
      "<configuration_N_name>"
   ],
   "NextToken": "<token>"
}
```

#|
|| **Parameter** | **Description** ||
|| `ConfigurationSets` | **Type**: Array.

Array of configuration names. Each name is provided as a separate string. ||
|| `NextToken` | **Type**: String.

Token to get the next results page in response to a request. If the number of results exceeds the `PageSize` value, the response returns the `NextToken` token to request the next results page. Each page gets its own token for pagination. ||
|#

The `200 OK` response may contain additional parameters. Its format may vary slightly from the above.

### Errors {#errors}

For all errors, the response body has the same format:

```json
{
   "Code": "<error_name>",
   "message": "<error_explanation>"
}
```

The name of the error is taken from its code, e.g., `BadRequestException`.

Possible errors:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request contains invalid headers. ||
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|#

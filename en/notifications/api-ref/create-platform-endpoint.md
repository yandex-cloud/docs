# CreatePlatformEndpoint

Creates an [endpoint for push notifications](../concepts/index.md#mobile-endpoints) (subscribes the user to push notifications).

## HTTP request {#request}

```http
POST https://{{ cns-host }}/
```

### Query parameters {#parameters}

| Parameter | Description |
--- | ---
| `Action` | **string**<br/>Required field.<br/>Parameter to indicate the operation type.<br/>Value: `CreatePlatformEndpoint`. |
| `PlatformApplicationArn` | **string**<br/>Required field.<br/>Mobile push notification channel ID.<br/>Example: `arn:aws:sns::aoegtvhtp8ob********:app/GCM/test-cns-9990`. |
| `Attributes.entry.N.key` | **string**<br/>Required field.<br/>[Attribute](#attributes) key. `N`: Numerical value.<br/>Example: `Attributes.entry.1.key=Token&Attributes.entry.2.key=CustomUserData`. |
| `Attributes.entry.N.value` | **string**<br/>Required field.<br/>Attribute value. `N`: Numerical value.<br/>Example: `Attributes.entry.1.value=c8gzjriSVxDDzX2fAV********&Attributes.entry.2.value=test-text`. |
| `ResponseFormat` | **string**<br/>Response format.<br/>The possible values include:<ul><li>`XML` (by default)</li><li>`JSON`.</li></ul> |

### Attributes {#attributes}

| Attribute | Description |
--- | ---
| `Token` | **string**<br/>Required field.<br/>Unique token on the user device (Registration ID) created by the notification service for the app. |
| `CustomUserData` | **string**<br/>Other user data that can be stored with the endpoint. {{ cns-name }} does not use this data in any way. |

{% note info %}

The `Enabled` attribute (enabling and disabling endpoint notifications) is currently not supported.

{% endnote %}

## Response {#response}

### Successful response {#response-200}

If there are no errors, {{ cns-name }} returns the `200` HTTP code.

A successful response contains additional data in XML or JSON format depending on the specified `ResponseFormat` parameter.

Data schema:

{% list tabs %}

- XML

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <CreatePlatformEndpointResponse>
   	  <ResponseMetadata>
   		  <RequestId>string</RequestId>
   	  </ResponseMetadata>
   	  <EndpointArn>string</EndpointArn>
   </CreatePlatformEndpointResponse>
   ```

- JSON

   ```json
   {
     "ResponseMetadata": {
       "RequestId": "string"
     },
     "EndpointArn": "string"
   }
   ```

{% endlist %}

Where:
* `RequestId`: Request ID
* `EndpointArn`: Mobile endpoint ID (ARN)

### Error response {#response-4xx}

In case of an error, {{ cns-name }} returns a message with the appropriate HTTP code.

For a list of common error codes for all actions, see [{#T}](common-errors.md).

## See also {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
* [CreatePlatformEndpoint API action](https://docs.aws.amazon.com/sns/latest/api/API_CreatePlatformEndpoint.html) in the AWS documentation.

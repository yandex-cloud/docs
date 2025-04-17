# CreatePlatformEndpoint

Creates an [endpoint for push notifications](../concepts/index.md#mobile-endpoints) (subscribes the user to push notifications).

## HTTP request {#request}

```http
POST https://{{ cns-host }}/
```

### Query parameters {#parameters}

Parameter | Description
--- | ---
`Action` | **string**<br/>Required field.<br/>Operation type parameter.<br/>Value: `CreatePlatformEndpoint`.
`PlatformApplicationArn` | **string**<br/>Required field.<br/>Mobile push notification channel or in-browser push notification channel ID.<br/>Example: `arn:aws:sns::aoegtvhtp8ob********:app/GCM/test-cns-9990`.
`Token` | **string**<br/>Required field.<br/>For mobile notifications: unique token on the user device (Registration ID) created by the notification service for the app. For in-browser notifications: [PushSubscription](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription) object received in the user's browser, in [JSON](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription/toJSON) format.
`CustomUserData` | **string**<br/>Other user data that can be stored together with the endpoint. {{ cns-name }} does not use this data in any way.
`ResponseFormat` | **string**<br/>Response format.<br/>The possible values are:<ul><li>`XML` (default)</li><li>`JSON`.</li></ul>

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
* `RequestId`: Request ID.
* `EndpointArn`: Mobile endpoint ID (ARN).

### Error response {#response-4xx}

In case of an error, {{ cns-name }} returns a message with the appropriate HTTP code.

For a list of common error codes for all actions, see [{#T}](common-errors.md).

## See also {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
* [CreatePlatformEndpoint API action](https://docs.aws.amazon.com/sns/latest/api/API_CreatePlatformEndpoint.html) in the AWS documentation.

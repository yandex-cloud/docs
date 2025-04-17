# SetEndpointAttributes

Sets attributes of the [endpoint for push notifications](../concepts/index.md#mobile-endpoints).

## HTTP request {#request}

```http
POST https://{{ cns-host }}/
```

### Query parameters {#parameters}

Parameter | Description
--- | ---
`Action` | **string**<br/>Required field.<br/>Operation type parameter.<br/>Value: `SetEndpointAttributes`.
`EndpointArn` | **string**<br/>Required field.<br/>Endpoint ID (ARN).<br/>Example: `arn:aws:sns::aoegtvhtp8ob********:endpoint/GCM/test-cns-9990/4cbe148515360244248c993abe0a12884d162bb15e87d6c16bd0c810********`.
`Attributes.entry.N.key` | **string**<br/>Required field.<br/>[Attribute](#attributes) key. `N` is a numeric value.<br/>Example: `Attributes.entry.1.key=Token&Attributes.entry.2.key=CustomUserData`.
`Attributes.entry.N.value` | **string**<br/>Required field.<br/>Attribute value. `N` is a numeric value.<br/>Example: `Attributes.entry.1.value=c8gzjriSVxDDzX2fAV********&Attributes.entry.2.value=test-text`.
`ResponseFormat` | **string**<br/>Response format.<br/>The possible values are:<ul><li>`XML` (default)</li><li>`JSON`.</li></ul>

### Attributes {#attributes}

Attribute | Description
--- | ---
`Token` | **string**<br/>Required field.<br/>For mobile notifications: unique token on the user device (Registration ID) created by the notification service for the app. For in-browser notifications: the [PushSubscription](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription) object received in the user's browser, in [JSON](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription/toJSON) format.
`CustomUserData` | **string**<br/>Other user data that can be stored together with the endpoint. {{ cns-name }} does not use this data in any way.

{% note info %}

The `Enabled` attribute for enabling and disabling endpoint notifications is currently not supported. 

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
  <SetEndpointAttributesResponse>
	  <ResponseMetadata>
		  <RequestId>string</RequestId>
	  </ResponseMetadata>
  </SetEndpointAttributesResponse>
  ```

- JSON

  ```json
  {
    "ResponseMetadata": {
      "RequestId": "string"
    }
  }
  ```

{% endlist %}

Where `RequestId` is the request ID.

### Error response {#response-4xx}

In case of an error, {{ cns-name }} returns a message with the appropriate HTTP code.

For a list of common error codes for all actions, see [{#T}](common-errors.md).

## See also {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
* [SetEndpointAttributes API action](https://docs.aws.amazon.com/sns/latest/api/API_SetEndpointAttributes.html) in the AWS documentation.

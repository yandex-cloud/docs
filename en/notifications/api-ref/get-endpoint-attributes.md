# GetEndpointAttributes

Gets attributes of the [endpoint for push notifications](../concepts/index.md#mobile-endpoints).

## HTTP request {#request}

```http
POST https://{{ cns-host }}/
```

### Query parameters {#parameters}

Parameter | Description
--- | ---
`Action` | **string**<br/>Required field.<br/>Operation type parameter.<br/>Value: `GetEndpointAttributes`.
`EndpointArn` | **string**<br/>Required field.<br/>Endpoint ID (ARN).<br/>Example: `arn:aws:sns::aoegtvhtp8ob********:endpoint/GCM/test-cns-9990/4cbe148515360244248c993abe0a12884d162bb15e87d6c16bd0c810********`.
`ResponseFormat` | **string**<br/>Response format.<br/>The possible values are:<ul><li>`XML` (default)</li><li>`JSON`</li></ul>

## Response {#response}

### Successful response {#response-200}

If there are no errors, {{ cns-name }} returns the `200` HTTP code.

A successful response contains additional data in XML or JSON format depending on the specified `ResponseFormat` parameter.

Data schema:

{% list tabs %}

- XML

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <GetEndpointAttributesResponse>
	  <ResponseMetadata>
		  <RequestId>string</RequestId>
	  </ResponseMetadata>
	  <CustomUserData>string</CustomUserData>
	  <Enabled>true</Enabled>
  </GetEndpointAttributesResponse>
  ```

- JSON

  ```json
  {
    "ResponseMetadata": {
      "RequestId": "string"
    },
    "CustomUserData": "string",
    "Enabled": true
  }
  ```

{% endlist %}

Where:
* `RequestId`: Request ID.
* `CustomUserData`: Other user data stored together with the endpoint. {{ cns-name }} does not use this data in any way.
* `Enabled`: Attribute for enabling and disabling endpoint notifications, currently not supported. It always returns `true`.

  {% note info %}

  For data protection purposes, you can not output the `Token` attribute.

  {% endnote %}

### Error response {#response-4xx}

In case of an error, {{ cns-name }} returns a message with the appropriate HTTP code.

For a list of common error codes for all actions, see [{#T}](common-errors.md).

## See also {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
* [GetEndpointAttributes API action](https://docs.aws.amazon.com/sns/latest/api/API_GetEndpointAttributes.html) in the AWS documentation.

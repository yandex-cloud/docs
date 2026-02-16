# DeletePlatformApplication

Deletes the [mobile push notification channel](../concepts/push.md) and all related [endpoints](../concepts/index.md#mobile-endpoints).

## HTTP request {#request}

```http
POST https://{{ cns-host }}/
```

### Query parameters {#parameters}

Parameter | Description
--- | ---
`Action` | **string**<br/>This is a required field.<br/>Parameter that indicates the type of operation.<br/>Value: `DeletePlatformApplication`.
`PlatformApplicationArn` | **string**<br/>This is a required field.<br/>ID of a mobile push notification channel.<br/>Example: `arn:aws:sns::aoegtvhtp8ob********:app/GCM/test-cns-9990`.
`ResponseFormat` | **string**<br/>Response format.<br/>Possible values:<ul><li>`XML` (default).</li><li>`JSON`.</li></ul>

## Response {#response}

### Successful response {#response-200}

If there are no errors, {{ cns-name }} returns the `200` HTTP code.

A successful response contains additional data in XML or JSON format depending on the specified `ResponseFormat` parameter.

Data schema:

{% list tabs %}

- XML

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <DeletePlatformApplicationResponse>
	  <ResponseMetadata>
		  <RequestId>string</RequestId>
	  </ResponseMetadata>
  </DeletePlatformApplicationResponse>
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
* [DeletePlatformApplication API action](https://docs.aws.amazon.com/sns/latest/api/API_DeletePlatformApplication.html) in the AWS documentation.

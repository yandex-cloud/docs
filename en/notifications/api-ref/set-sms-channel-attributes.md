# SetSMSChannelAttributes

Setting parameters for the [SMS notification channel](../concepts/sms.md).

## HTTP request {#request}

```http
POST https://{{ cns-host }}/
```

### Query parameters {#parameters}

Parameter | Description
--- | ---
`Action` | **string**<br/>Required field.<br/>Operation type parameter.<br/>Value: `SetSMSChannelAttributes`.
`SMSChannelArn` | **string**<br/>This is a required field.<br/>SMS notification channel ID.<br/>Example: `arn:aws:sns::b1gvlrnlei4l******:sms/channelname`.
`Attributes.entry.N.key` | **string**<br/>Required field.<br/>[Attribute](#attributes) key. `N` is a numeric value.<br/>Example: `Attributes.entry.1.key=Description`.
`Attributes.entry.N.value` | **string**<br/>Required field.<br/>Attribute value. `N` is a numeric value.<br/>Example: `Attributes.entry.1.value=Test-sms-channel`.
`ResponseFormat` | **string**<br/>Response format.<br/>The possible values are:<ul><li>`XML` (default)</li><li>`JSON`.</li></ul>

### Attributes {#attributes}

Attribute | Description
--- | ---
`IsDefault` | Specifies whether the channel is the default channel for outgoing SMS in this cloud. You can only set `IsDefault` for a channel in the `Sandbox` or `Active` state. Due to how {{ cns-name }} operates, this attribute cannot be provided along with other attributes.
`ChannelState` | Channel's target state. Possible states:<ul><li>`Active`: Active.</li><li>`Disabled`: Disabled.</li></ul>
`Description` | Description of the SMS notification channel.<br/>Example: `Test-sms-channel`.

## Response {#response}

### Successful response {#response-200}

If there are no errors, {{ cns-name }} returns the `200` HTTP code.

A successful response contains additional data in XML or JSON format depending on the specified `ResponseFormat` parameter.

Data schema:

{% list tabs %}

- XML

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <SetSMSChannelAttributesResponse>
	  <ResponseMetadata>
		  <RequestId>string</RequestId>
	  </ResponseMetadata>
  </SetSMSChannelAttributesResponse>
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

In case of an error, {{ cns-name }} returns a message with the appropriate HTTP code and its additional description in XML or JSON format depending on the specified `ResponseFormat` parameter.

Data schema:

{% list tabs %}

- XML

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <ErrorResponseXML>
	  <RequestId>string</RequestId>
	  <Error>
		  <Code>string</Code>
		  <Message>string</Message>
	  </Error>
  </ErrorResponseXML>
  ```

- JSON

  ```json
  {
    "ErrorResponse": {
      "RequestId": "string",
      "Error": {
        "Code": "string",
        "SubCode": "string",
        "Message": "string"
      }
    }
  }
  ```

{% endlist %}

Where:
* `RequestId`: Request ID.
* `Code`: Error code.
* `Message`: Error description.

For a list of common error codes for all actions, see [{#T}](common-errors.md).

Errors specific for `SetSMSChannelAttributes`:

HTTP | Error code | Extended code | Description
--- | --- | --- | ---
400 | UserError | InvalidSMSChannelStateTransition | Unable to enter the specified channel state.
400 | UserError | InvalidSMSChannelStateToSetDefault | In its current state, the channel cannot be set as the default channel.
400 | UserError | InvalidSMSChannelAttributeCombination | The `IsDefault` attribute cannot be provided along with other attributes.

## See also {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
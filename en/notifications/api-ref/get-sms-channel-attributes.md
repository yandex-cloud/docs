# GetSMSChannelAttributes

Gets [SMS notification channel](../concepts/sms.md) properties.

## HTTP request {#request}

```http
POST https://{{ cns-host }}/
```

### Query parameters {#parameters}

Parameter | Description
--- | ---
`Action` | **string**<br/>Required field.<br/>Operation type parameter.<br/>Value: `GetSMSChannelAttributes`.
`SMSChannelArn` | **string**<br/>Required field.<br/>SMS notification channel ID.<br/>Example: `arn:aws:sns::b1gvlrnlei4l******:sms/channelname`.
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
  <GetSMSChannelAttributesResponseXML>
	  <ResponseMetadata>
	  	<RequestId>string</RequestId>
  	</ResponseMetadata>
  	<GetSMSChannelAttributesResult>
	  	<Attributes>
		  	<entry>
		  		<key>string</key>
				  <value>string</value>
			  </entry>
		  </Attributes>
	  </GetSMSChannelAttributesResult>
  </GetSMSChannelAttributesResponseXML>
  ```

- JSON

  ```json
  {
    "ResponseMetadata": {
      "RequestId": "string"
    },
    "GetSMSChannelAttributesResult": {
      "Attributes": {
        "Attribute": "string"
      }
    }
  }
  ```

{% endlist %}

Where:
* `RequestId`: Request ID.
* `SMSChannelArn`: SMS notification channel ARN.
* `Attributes`: Attributes of the SMS notification channel.
  * `SenderID`:
    * For channels with an individual sender, contains the sender’s text name provided when the channel was created. 
    * For a channel with a shared sender, contains the `cns.shared` value.
  * `IsDefault`: Specifies whether the channel is the default channel for outgoing SMS in this cloud.
  * `IsBanned`: Specifies whether the channel is banned by the service.
  * `ChannelState`: Channel state. The possible values are: 
    * `Registering`: Registering.
    * `Sandbox`: In [sandbox](../concepts/sms.md#sandbox).
    * `Active`: Active.
    * `Disabled`: Disabled.
    * `Deregistering`: Deregistering.
    * `Deregistered`: Deregistered.
  * `Description`: SMS notification channel description.

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

## See also {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)

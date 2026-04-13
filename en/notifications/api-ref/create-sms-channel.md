# CreateSMSChannel

Creates an [SMS notification channel](../concepts/sms.md).

## HTTP request {#request}

```http
POST https://{{ cns-host }}/
```

### Query parameters {#parameters}

Parameter | Description
--- | ---
`Action` | **string**<br/>Required field.<br/>Operation type parameter.<br/>Value: `CreateSMSChannel`.
`SenderID` | **string**<br/>Sender's text name. If not set, creates an SMS notification channel with a [common sender](../concepts/sms.md#common-sender) in the [sandbox](../concepts/sms.md#sandbox). A cloud can contain only one such channel with a common sender.
`FolderId` | **string**<br/>Required field when authenticating via an IAM token.<br/>[ID of the folder](../../resource-manager/operations/folder/get-id.md) the SMS notification channel will be created in. When authenticating via a static service account key with `FolderId` not specified, the channel will be created in the same folder as the service account.<br/>Example: `b1gsm0k26v1l********`.
`Attributes.entry.N.key` | **string**<br/>Required field.<br/>[Attribute](#attributes) key. `N` is a numeric value.<br/>Example: `Attributes.entry.1.key=Description`.
`Attributes.entry.N.value` | **string**<br/>Required field.<br/>Attribute value. `N` is a numeric value.<br/>Example: `Attributes.entry.1.value=Test-sms-channel`.
`ResponseFormat` | **string**<br/>Response format.<br/>The possible values are:<ul><li>`XML` (default)</li><li>`JSON`.</li></ul>

### Attributes {#attributes}

Attribute | Description
--- | ---
`Description` | **string**<br/>Description of the SMS notification channel.<br/>Example: `Test-sms-channel`.

## Response {#response}

### Successful response {#response-200}

If there are no errors, {{ cns-name }} returns the `200` HTTP code.

A successful response contains additional data in XML or JSON format depending on the specified `ResponseFormat` parameter.

Data schema:

{% list tabs %}

- XML

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <CreateSMSChannelResponse>
	  <ResponseMetadata>
		  <RequestId>string</RequestId>
	  </ResponseMetadata>
	  <CreateSMSChannelResult>
		  <SMSChannelArn>string</SMSChannelArn>
	  </CreateSMSChannelResult>
  </CreateSMSChannelResponse>
  ```

- JSON

  ```json
  {
    "ResponseMetadata": {
      "RequestId": "string"
    },
    "CreateSMSChannelResult": {
      "SMSChannelArn": "string"
    }
  }
  ```

{% endlist %}

Where:
* `RequestId`: Request ID.
* `SMSChannelArn`: SMS notification channel ARN.

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

Errors specific for `CreateSMSChannel`:

HTTP | Error code | Extended code | Description
--- | --- | --- | ---
400 | UserError | SMSChannelLimitExceeded | Limit on the number of SMS notification channels in the cloud has been exceeded.
400 | UserError | ChannelAlreadyExists | There is an SMS notification channel with the same sender text name in the cloud.

## See also {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
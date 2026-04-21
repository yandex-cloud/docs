# ListSMSSandboxPhoneNumbers

Gets a list of test phone numbers for the SMS notification channel in the [sandbox](../concepts/sms.md#sandbox).

## HTTP request {#request}

```http
POST https://{{ cns-host }}/
```

### Query parameters {#parameters}

Parameter | Description
--- | ---
`Action` | **string**<br/>Required field.<br/>Operation type parameter.<br/>Value: `ListSMSSandboxPhoneNumbers`.
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
  <ListSMSSandboxPhoneNumbersResponseXML>
	  <ResponseMetadata>
	  	<RequestId>string</RequestId>
  	</ResponseMetadata>
  	<ListSMSSandboxPhoneNumbersResult>
	  	<PhoneNumbers>
	  		<member>
		  		<PhoneNumber>string</PhoneNumber>
		  		<Status>Pending</Status>
		  	</member>
	  	</PhoneNumbers>
	  </ListSMSSandboxPhoneNumbersResult>
  </ListSMSSandboxPhoneNumbersResponseXML>
  ```

- JSON

  ```json
  {
    "ResponseMetadata": {
      "RequestId": "string"
    },
    "ListSMSSandboxPhoneNumbersResult": {
      "PhoneNumbers": [
        {
          "PhoneNumber": "string",
          "Status": "Pending",
          "IsDeletable": true
        }
      ]
    }
  }
  ```

{% endlist %}

Where:
* `RequestId`: Request ID.
* `PhoneNumber`: Phone number.
* `Status`: Number status:
  * `Pending`: Pending confirmation.
  * `Verified`: Confirmed.
* `IsDeletable`: Indicates whether the phone number can be deleted. A test phone number can only be deleted 24 hours after it is added.

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
* [ListSMSSandboxPhoneNumbers](https://docs.aws.amazon.com/sns/latest/api/API_ListSMSSandboxPhoneNumbers.html) in AWS reference.
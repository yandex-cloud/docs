# CreateSMSSandboxPhoneNumber

Adds a test phone number for the SMS notification channel in the [sandbox](../concepts/sms.md#sandbox) and sends a confirmation code.

If the number is already pending confirmation, resends a new code.

## HTTP request {#request}

```http
POST https://{{ cns-host }}/
```

### Query parameters {#parameters}

Parameter | Description
--- | ---
`Action` | **string**<br/>Required field.<br/>Operation type parameter.<br/>Value: `CreateSMSSandboxPhoneNumber`.
`PhoneNumber` | **string**<br/>Required field.<br/>Phone number in [E.164](https://en.wikipedia.org/wiki/E.164) format.
`SMSChannelArn` | **string**<br/>Required field.<br/>SMS notification channel ID.<br/>Example: `arn:aws:sns::b1gvlrnlei4l******:sms/channelname`.
`LanguageCode` | **string**<br/>Language for the verification code.<br/>Possible values:<ul><li>`en-US` (default)</li><li>`ru-RU`.</li></ul>
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
  <CreateSMSSandboxPhoneNumberResponse>
	  <ResponseMetadata>
		  <RequestId>string</RequestId>
	  </ResponseMetadata>
  </CreateSMSSandboxPhoneNumberResponse>
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

Errors specific for `CreateSMSSandboxPhoneNumber`:

HTTP | Error code | Extended code | Description
--- | --- | --- | ---
400 | UserError | SMSSandboxPhoneNumberLimitExceeded | The [limit](../concepts/limits.md) for verified numbers per cloud or SMS notification channel is reached.
400 | UserError | WrongSMSChannelState | The SMS notification channel status is not `Sandbox`.
400 | UserError | SMSSandboxPhoneNumberAlreadyVerified | The phone number is already verified in this SMS notification channel.
400 | UserError | InvalidPhoneNumberRegion | Phone numbers from outside Russia are not supported.
400 | ThrottlingException | OTPRateLimitExceeded | The maximum OTP request frequency is exceeded.

## See also {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
* [CreateSMSSandboxPhoneNumber](https://docs.aws.amazon.com/sns/latest/api/API_CreateSMSSandboxPhoneNumber.html) in AWS reference.
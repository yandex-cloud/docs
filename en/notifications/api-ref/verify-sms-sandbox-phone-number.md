# VerifySMSSandboxPhoneNumber

Confirms the test phone number for the SMS notification channel in the [sandbox](../concepts/sms.md#sandbox) using a verification code.

## HTTP request {#request}

```http
POST https://{{ cns-host }}/
```

### Query parameters {#parameters}

Parameter | Description
--- | ---
`Action` | **string**<br/>Required field.<br/>Operation type parameter.<br/>Value: `VerifySMSSandboxPhoneNumber`.
`OneTimePassword` | **string**<br/>This is a required field.<br/>Confirmation code sent to the test phone number.
`PhoneNumber` | **string**<br/>Required field.<br/>Phone number in [E.164](https://en.wikipedia.org/wiki/E.164) format. Russian phone numbers are supported.
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

Errors specific for `VerifySMSSandboxPhoneNumber`:

HTTP | Error code | Extended code | Description
--- | --- | --- | ---
400 | UserError | InvalidOTP | The verification code is invalid, expired, or has been cancelled after an unsuccessful verification attempt.
404 | NotFound | SMSSandboxPhoneNumberNotFound | This number has not been added to the SMS notification channel for verification.

#### Useful links {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
* [VerifySMSSandboxPhoneNumber](https://docs.aws.amazon.com/sns/latest/api/API_VerifySMSSandboxPhoneNumber.html) in the AWS documentation

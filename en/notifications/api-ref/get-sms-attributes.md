# GetSMSAttributes

Gets parameters for sending SMS messages in the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).

## HTTP request {#request}

```http
POST https://{{ cns-host }}/
```

### Query parameters {#parameters}

Parameter | Description
--- | ---
`Action` | **string**<br/>Required field.<br/>Operation type parameter.<br/>Value: `GetSMSAttributes`.
`Attributes.member.N` | **string**<br/>Name of the attribute whose value you want to retrieve.<br/>Possible values:<ul><li>`MonthlySMSCountQuota`: Cloud [limit](../concepts/limits.md) on the number of SMS messages sent per month.</li><li>`DefaultSenderID`: Default sender ID.</li><li>`DefaultSMSType`: Default SMS type, `Promotional` or `Transactional`.</li></ul><br/>If no attributes are provided, the response will return all supported attributes.<br/>Example: `Attributes.member.1=MonthlySMSCountQuota`.
`Account` | **string**<br/>Cloud ID. Only used to send SMS messages. This parameter is required for authentication with an [IAM token](../../iam/concepts/authorization/iam-token.md).
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
  <GetSMSAttributesResponseXML>
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
  </GetSMSAttributesResponseXML>
  ```

- JSON

  ```json
  {
    "ResponseMetadata": {
      "RequestId": "string"
    },
    "GetSMSAttributesResult": {
      "Attributes": {
        "Attribute": "string"
      }
    }
  }
  ```

{% endlist %}

Where:
* `RequestId`: Request ID.
* `Attributes`: Parameters for sending SMS messages in the cloud.

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
* [GetSMSAttributes API action](https://docs.aws.amazon.com/sns/latest/api/API_GetSMSAttributes.html) in AWS reference.
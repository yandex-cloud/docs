# ListPlatformApplications

Gets a list of [mobile push notification channels](../concepts/push.md). The action always outputs one page and does not support pagination.

## HTTP request {#request}

```http
POST https://{{ cns-host }}/
```

### Query parameters {#parameters}

Parameter | Description
--- | ---
`Action` | **string**<br/>This is a required field.<br/>Parameter that indicates the type of operation.<br/>Value: `ListPlatformApplications`.
`FolderId` | **string**<br/>This is a required field.<br/>[ID of the folder](../../resource-manager/operations/folder/get-id.md) where the notification channels are located.<br/>Example: `b1gsm0k26v1l********`.
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
  <ListPlatformApplicationsResponseXML>
	  <ResponseMetadata>
		  <RequestId>string</RequestId>
	  </ResponseMetadata>
	  <ListPlatformApplicationsResult>
		  <PlatformApplications>
			  <member>
				  <PlatformApplicationARN>string</PlatformApplicationARN>
				  <Attributes>
					  <entry>
						  <key>string</key>
						  <value>string</value>
					  </entry>
				  </Attributes>
			  </member>
		  </PlatformApplications>
	  </ListPlatformApplicationsResult>
  </ListPlatformApplicationsResponseXML>
  ```

  Where:
  * `RequestId`: Request ID
  * `PlatformApplicationArn`: Notification channel ID (ARN)
  * `Attributes`: Notification channel attributes. The following attributes are supported:
    * `ApplePlatformTeamID`: Developer ID, only when using a token.
    * `ApplePlatformBundleID`: App ID (bundle ID), only when using a token.
    * `AppleCertificateExpiryDate`: Certificate expiry date, only when using a certificate.

- JSON

  ```json
  {
    "ResponseMetadata": {
      "RequestId": "string"
    },
    "ListPlatformApplicationsResult": {
      "PlatformApplications": [
        {
          "PlatformApplicationARN": "string",
          "Attributes": {
            "Attribute": "string"
          }
        }
      ]
    }
  }
  ```

  Where:
  * `RequestId`: Request ID
  * `PlatformApplicationArn`: Notification channel ID (ARN)
  * `Attributes`: Notification channel attributes. The following attributes are supported:
    * `ApplePlatformTeamID`: Developer ID, only when using a token.
    * `ApplePlatformBundleID`: App ID (bundle ID), only when using a token.
    * `AppleCertificateExpiryDate`: Certificate expiry date, only when using a certificate.
    * `Name`: Name of the mobile push notification channel.
    * `Description`: Description of the mobile push notification channel.
    * `Platform`: Platform for sending mobile push notifications:
      * `APNS`: [Apple Push Notification service](https://developer.apple.com/notifications/).
      * `APNS_SANDBOX`: Apple Push Notification service for testing the app.
      * `FCM`: [Firebase Cloud Messaging](https://firebase.google.com/).
      * `HMS`: [Huawei Mobile Services](https://developer.huawei.com/consumer/).
    * `CreatedAt`: Date and time when the mobile push notification channel was created.

{% endlist %}

### Error response {#response-4xx}

In case of an error, {{ cns-name }} returns a message with the appropriate HTTP code.

For a list of common error codes for all actions, see [{#T}](common-errors.md).

## See also {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
* [ListPlatformApplications API action](https://docs.aws.amazon.com/sns/latest/api/API_ListPlatformApplications.html) in the AWS documentation.

# GetPlatformApplicationAttributes

Gets parameters of the [mobile push notification channel](../concepts/index.md#mobile-channel).

## HTTP request {#request}

```http
POST https://{{ cns-host }}/
```

### Query parameters {#parameters}

| Parameter | Description |
--- | ---
| `Action` | **string**<br/>Required field.<br/>Parameter to indicate the operation type.<br/>Value: `GetPlatformApplicationAttributes`. |
| `PlatformApplicationArn` | **string**<br/>Required field.<br/>Mobile push notification channel ID.<br/>Example: `arn:aws:sns::aoegtvhtp8ob********:app/GCM/test-cns-9990`. |
| `ResponseFormat` | **string**<br/>Response format.<br/>The possible values include:<ul><li>`XML` (by default)</li><li>`JSON`.</li></ul> |

## Response {#response}

### Successful response {#response-200}

If there are no errors, {{ cns-name }} returns the `200` HTTP code.

A successful response contains additional data in XML or JSON format depending on the specified `ResponseFormat` parameter.

Data schema:

{% list tabs %}

- XML

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <GetPlatformApplicationAttributesResponseXML>
   	  <ResponseMetadata>
   		  <RequestId>string</RequestId>
   	  </ResponseMetadata>
   	  <GetPlatformApplicationAttributesResult>
   		  <Attributes>
   			  <entry>
   				  <key>string</key>
   				  <value>string</value>
   			  </entry>
   		  </Attributes>
   	  </GetPlatformApplicationAttributesResult>
   </GetPlatformApplicationAttributesResponseXML>
   ```

   Where:
   * `RequestId`: Request ID.
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
     "GetPlatformApplicationAttributesResult": {
       "Attributes": {
         "Attribute": "string"
       }
     }
   }
   ```

   Where:
   * `RequestId`: Request ID.
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
* [GetPlatformApplicationAttributes API action](https://docs.aws.amazon.com/sns/latest/api/API_GetPlatformApplicationAttributes.html) in the AWS documentation.

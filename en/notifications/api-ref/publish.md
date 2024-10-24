# Publish

Sends a push notification to an [endpoint](../concepts/index.md#mobile-endpoints).

## HTTP request {#request}

```http
POST https://{{ cns-host }}/
```

### Query parameters {#parameters}

| Parameter | Description |
--- | ---
| `Action` | **string**<br/>Required field.<br/>Parameter to indicate the operation type.<br/>Value: `Publish`. |
| `Message` | **string**<br/>Required field.<br/>Message to send to an endpoint.<br/> The possible formats include:<ul><li>Simple text</li><li>JSON</li></ul><br/>In JSON format, you can optionally provide text for a specific mobile platform, e.g.:<br/>`{ "default": "This is the default message which must be present when publishing a message to a topic. The default message will only be used if a message is not present for one of the notification platforms.", "APNS": "{"aps":{"alert": "Check out these awesome deals!","url":"yandex.cloud"} }", "GCM": "{"data":{"message":"Check out these awesome deals!","url":"yandex.cloud"},"notification":{"title":"GCM notification title"}}" "HMS": "{"data":{"message":"Check out these awesome deals!","url":"yandex.cloud"},"notification":{"title":"HMS notification title"}}" }`<br/>Messages for the FCM and HMS platforms must contain at least one of the `data` or `notification` fields. |
| `MessageStructure` | **string**<br/> If you are providing a message in the `Message` field in JSON format, set the `MessageStructure` field to `json`. |
| `MessageAttributes.entry.N.key` | **string**<br/>Required field.<br/>[Attribute](#attributes) key. `N`: Numerical value.<br/>Example: `MessageAttributes.entry.1.key=AWS.SNS.MOBILE.APNS.PUSH_TYPE&MessageAttributes.entry.2.key=AWS.SNS.MOBILE.APNS.PRIORITY`. |
| `MessageAttributes.entry.N.value` | **string**<br/>Required field.<br/>Attribute value. `N`: Numerical value.<br/>Example: `MessageAttributes.entry.1.value={"DataType":"String","StringValue":"background"}&MessageAttributes.entry.2.value={"DataType":"String","StringValue":"5"}`. |
| `TargetArn` | **string**<br/>Required field.<br/>Mobile endpoint ID (ARN).<br/>Example: `arn:aws:sns::aoegtvhtp8ob********:endpoint/GCM/test-cns-9990/4cbe148515360244248c993abe0a12884d162bb15e87d6c16bd0c810********`. |
| `ResponseFormat` | **string**<br/>Response format.<br/>The possible values include:<ul><li>`XML` (by default)</li><li>`JSON`.</li></ul> |

### Attributes {#attributes}

You can use attributes to provide mobile platform-specific parameters. You cannot provide binary data in the `MessageAttributes` values.

#### APNS and APNS_SANDBOX attributes {#attributes-apns}

| Attribute | Description |
--- | ---
| AWS.SNS.MOBILE.APNS.TTL | Notification lifetime in seconds |
| AWS.SNS.MOBILE.APNS_SANDBOX.TTL | Notification lifetime in seconds for apps under testing |
| AWS.SNS.MOBILE.APNS_VOIP.TTL | Lifetime of an incoming VoIP call notification in seconds |
| AWS.SNS.MOBILE.APNS_VOIP_SANDBOX.TTL | Lifetime of an incoming VoIP call notification in seconds for apps under testing |
| AWS.SNS.MOBILE.APNS.COLLAPSE_ID | ID for multiple notifications that are collapsed into one |
| AWS.SNS.MOBILE.APNS.PRIORITY | Notification output priority, which is a value from `1` to `10` |
| AWS.SNS.MOBILE.APNS.PUSH_TYPE | Notification type; see the [Apple documentation](https://developer.apple.com/documentation/usernotifications/sending-notification-requests-to-apns#Know-when-to-use-push-types) |
| AWS.SNS.MOBILE.APNS.TOPIC | Notification topic; see the [Apple documentation](https://developer.apple.com/documentation/usernotifications/sending-notification-requests-to-apns#Send-a-POST-request-to-APNs) |

#### FCM attributes {#attributes-fcm}

| Attribute | Description |
--- | ---
| AWS.SNS.MOBILE.FCM.TTL | Message lifetime in seconds |

## Response {#response}

### Successful response {#response-200}

If there are no errors, {{ cns-name }} returns the `200` HTTP code.

### Error response {#response-4xx}

In case of an error, {{ cns-name }} returns a message with the appropriate HTTP code.

For a list of common error codes for all actions, see [{#T}](common-errors.md).

## See also {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
* [Publish API action](https://docs.aws.amazon.com/sns/latest/api/API_Publish.html) in the AWS documentation.

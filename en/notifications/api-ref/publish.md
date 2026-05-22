# Publish

Sends a [push notification](../concepts/push.md) to an [endpoint](../concepts/index.md#mobile-endpoints), or an [SMS](../concepts/sms.md) to a phone number.

## HTTP request {#request}

```http
POST https://{{ cns-host }}/
```

### Query parameters {#parameters}

Parameter | Description
--- | ---
`Action` | **string**<br/>Required field.<br/>Operation type parameter.<br/>Value: `Publish`.
`Message` | **string**<br/>Required field.<br/>Message you want to send to the endpoint.<br/>The possible formats are:<ul><li>Plain text</li><li>JSON</li></ul><br/>In JSON format, you can optionally provide text for a specific mobile platform, e.g.:<br/>`{ "default": "Default message", "APNS": "{"aps":{"alert": "Check out these awesome deals!","url":"yandex.cloud"} }", "GCM": "{"data":{"message":"Check out these awesome deals!","url":"yandex.cloud"},"notification":{"title":"GCM notification title"}}" "HMS": "{"data":{"message":"Check out these awesome deals!","url":"yandex.cloud"},"notification":{"title":"HMS notification title"}}" }`<br/>Messages for FCM and HMS platforms must contain at least one of the `data` or `notification` fields.
`MessageStructure` | **string**<br/>If providing a message in JSON format in the `Message` field, set the `MessageStructure` field to `json`.
`MessageAttributes.entry.N.key` | **string**<br/>Required field.<br/>[Attribute](#attributes) key. `N` is a numeric value.<br/>Example: `MessageAttributes.entry.1.key=AWS.SNS.MOBILE.APNS.PUSH_TYPE&MessageAttributes.entry.2.key=AWS.SNS.MOBILE.APNS.PRIORITY`.
`MessageAttributes.entry.N.value` | **string**<br/>Required field.<br/>Attribute value. `N` is a numeric value.<br/>Example: `MessageAttributes.entry.1.value={"DataType":"String","StringValue":"background"}&MessageAttributes.entry.2.value={"DataType":"String","StringValue":"5"}`.
`TargetArn` | **string**<br/>This is a required field.<br/>Mobile endpoint ARN. You must specify either `TargetArn` or `PhoneNumber`. You cannot use this parameter along with `PhoneNumber`. <br/>Here is an example: `arn:aws:sns::aoegtvhtp8ob********:endpoint/GCM/test-cns-9990/4cbe148515360244248c993abe0a12884d162bb15e87d6c16bd0c810********`.
`PhoneNumber` | **string**<br/>This is a required field.<br/>Enter a phone number in [E.164](https://en.wikipedia.org/wiki/E.164) format. Sending SMS to Russian numbers is supported. You must specify either `TargetArn` or `PhoneNumber`. You cannot use this parameter along with `TargetArn`.
`ResponseFormat` | **string**<br/>Response format.<br/>The possible values are:<ul><li>`XML` (default)</li><li>`JSON`.</li></ul>

### Attributes {#attributes}

You can use attributes to provide mobile platform-specific parameters. You cannot provide binary data in the `MessageAttributes` values.

#### APNS and APNS_SANDBOX attributes {#attributes-apns}

Attribute | Description
--- | ---
AWS.SNS.MOBILE.APNS.TTL | Notification lifetime in seconds
AWS.SNS.MOBILE.APNS_SANDBOX.TTL | Notification lifetime in seconds for apps under testing
AWS.SNS.MOBILE.APNS_VOIP.TTL | Lifetime of an incoming VoIP call notification in seconds
AWS.SNS.MOBILE.APNS_VOIP_SANDBOX.TTL | Lifetime of an incoming VoIP call notification in seconds for apps under testing
AWS.SNS.MOBILE.APNS.COLLAPSE_ID | ID for multiple notifications that are collapsed into one
AWS.SNS.MOBILE.APNS.PRIORITY | Notification output priority. A value from `1` to `10`.
AWS.SNS.MOBILE.APNS.PUSH_TYPE | Notification type. See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/sending-notification-requests-to-apns#Know-when-to-use-push-types) for details.
AWS.SNS.MOBILE.APNS.TOPIC | Notification topic. See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/sending-notification-requests-to-apns#Send-a-POST-request-to-APNs) for details.

#### FCM attributes {#attributes-fcm}

Attribute | Description
--- | ---
AWS.SNS.MOBILE.FCM.TTL | Message lifetime in seconds

#### SMS attributes {#attributes-sms}

Attribute | Description
--- | ---
AWS.SNS.SMS.SenderID | Sender's text name
AWS.SNS.SMS.SMSType | SMS type.<br/>The possible values are:<ul><li>`Promotional`: Default value. Promotion-related messages.</li><li>`Transactional`: Operation-related messages, e.g., one-time passwords.</li></ul>

#### RUSTORE attributes {#attributes-rustore}

Attribute | Description
--- | ---
CNS.MOBILE.RUSTORE.TTL | Message lifetime in seconds

## Response {#response}

### Successful response {#response-200}

If there are no errors, {{ cns-name }} returns the `200` HTTP code.

### Error response {#response-4xx}

In case of an error, {{ cns-name }} returns a message with the appropriate HTTP code.

For a list of common error codes for all actions, see [{#T}](common-errors.md).

Errors specific for `Publish`:

HTTP | Error code | Extended code | Description
--- | --- | --- | ---
400 | InvalidParameter | InvalidMessageAttribute | An invalid `MessageAttribute` attribute was provided. See the `ParamName` field for the attribute name.
400 | InvalidParameter | MessageLimitExceeded | The message size including the attributes exceeds the limit.
400 | InvalidParameter | SMSBodyWithMixedWords | Attempting to send an SMS containing words that were a combination of Latin and Cyrillic characters
400 | UserError | SMSSandboxNumberNotVerified | Attempting to send an SMS to an unverified phone number via the SMS notification channel in the [sandbox](../concepts/sms.md#sandbox)
400 | UserError | WrongSMSChannelState | Attempting to send an SMS from a channel that is in a state that does not allow sending messages
400 | UserError | SMSChannelIsBanned | Attempting to send an SMS using a blocked channel
400 | UserError | InvalidPhoneNumberRegion | Phone numbers from outside Russia are not supported.

## See also {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
* [Publish API action](https://docs.aws.amazon.com/sns/latest/api/API_Publish.html) in the AWS documentation

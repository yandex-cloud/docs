# CreatePlatformApplication

Creates a [mobile push notification channel](../concepts/index.md#mobile-channel).

## HTTP request {#request}

```http
POST https://{{ cns-host }}/
```

### Query parameters {#parameters}

Parameter | Description
--- | ---
`Action` | **string**<br/>This is a required field.<br/>Parameter that indicates the type of operation.<br/>Value: `CreatePlatformApplication`.
`Name` | **string**<br/>This is a required field.<br/>Notification channel name. The name must be unique within the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud). It may contain lowercase and uppercase Latin letters, numbers, underscores, hyphens, and periods. It may be from 1 to 256 characters long. For APNs channels, we recommend specifying the bundle ID as the name, and for FCM and HMS, the full package name.<br/>Example: `com.example.app`.
`Platform` | **string**<br/>This is a required field.<br/>Platform for sending mobile push notifications.<br/>Possible values:<ul><li>`APNS`: [Apple Push Notification service](https://developer.apple.com/notifications/).</li>`APNS_SANDBOX`: Apple Push Notification service for application testing.</li><li>`FCM`: [Firebase Cloud Messaging](https://firebase.google.com/).</li><li>`HMS`: [Huawei Mobile Services](https://developer.huawei.com/consumer/).</li></ul>
`FolderId` | **string**<br/>This is a required field.<br/>[ID of the folder](../../resource-manager/operations/folder/get-id.md) to create a network load balancer in.<br/>Example: `b1gsm0k26v1l********`.
`Attributes.entry.N.key` | **string**<br/>This is a required field.<br/>[Attribute](#attributes) key. `N` is a numeric value.<br/>Example: `Attributes.entry.1.key=PlatformPrincipal&Attributes.entry.2.key=PlatformCredential`.
`Attributes.entry.N.value` | **string**<br/>This is a required field.<br/>Attribute value. `N` is a numeric value.<br/>Example: `Attributes.entry.1.value=c8gzjriSVxDDzX2fAV********&Attributes.entry.2.value=CgB6e3x9iW/qiE9l9wAUPK0e/bJQe5uIgTlYUD4bP********`.
`ResponseFormat` | **string**<br/>Response format.<br/>Possible values:<ul><li>`XML` (default).</li><li>`JSON`.</li></ul>

### Attributes {#attributes}

#### Common attributes {#attributes-common}

Attribute | Description
--- | ---
`Description` | **string**<br/>Application description.<br/>Example: `Test application`.

#### APNS and APNS_SANDBOX attributes {#attributes-apns}

Attribute | Description
--- | ---
`PlatformPrincipal` | **string**<br/>Token ID in `.p8` format or SSL certificate in `.p12` format. Token-based authentication is preferred as it is more modern.
`PlatformCredential` | **string**<br/>Token or private key of the SSL certificate.
`ApplePlatformTeamID` | **string**<br/>Developer ID, only when using a token.
`ApplePlatformBundleID` | **string**<br/>App ID (bundle ID), only when using a token.

#### FCM attributes {#attributes-fcm}

Attribute | Description
--- | ---
`PlatformCredential` | **string**<br/>Key of the Google Cloud service account in JSON format for authentication with the HTTP v1 API or API key (server key) for authentication with the legacy API. The HTTP v1 API is preferred as [FCM will no longer support](https://firebase.google.com/docs/cloud-messaging/migrate-v1) the legacy API starting from June 2024.

#### HMS attributes {#attributes-hms}

Attribute | Description
--- | ---
`PlatformPrincipal` | **string**<br/>Key ID
`PlatformCredential` | **string**<br/>API key

For more information about authentication attributes, see the [Mobile push notification channels](../concepts/index.md#mobile-channel) subsection.

## Response {#response}

### Successful response {#response-200}

If there are no errors, {{ cns-name }} returns the `200` HTTP code.

A successful response contains additional data in XML or JSON format depending on the specified `ResponseFormat` parameter.

Data schema:

{% list tabs %}

- XML

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <CreatePlatformApplicationResponse>
	  <ResponseMetadata>
		  <RequestId>string</RequestId>
	  </ResponseMetadata>
	  <CreatePlatformApplicationResult>
		  <PlatformApplicationArn>string</PlatformApplicationArn>
	  </CreatePlatformApplicationResult>
  </CreatePlatformApplicationResponse>
  ```

- JSON

  ```json
  {
    "ResponseMetadata": {
      "RequestId": "string"
    },
    "CreatePlatformApplicationResult": {
      "PlatformApplicationArn": "string"
    }
  }
  ```

{% endlist %}

Where:
* `RequestId`: Request ID
* `PlatformApplicationArn`: Notification channel ID (ARN)

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
* `RequestId`: Request ID
* `Code`: Error code
* `Message`: Error description

For a list of common error codes for all actions, see [{#T}](common-errors.md).

Errors specific for `CreatePlatformApplication`:

HTTP | Error code | Description
--- | --- | ---
400 | InvalidParameter | A mobile push notification channel with such name and platform already exists.
400 | InvalidParameter | You cannot use the name and platform to create a new mobile push notification channel because a channel with the same parameters was recently deleted, and the mobile platform data has not yet been updated.

## See also {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
* [CreatePlatformApplication API action](https://docs.aws.amazon.com/sns/latest/api/API_CreatePlatformApplication.html) in the AWS documentation

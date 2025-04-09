# SetPlatformApplicationAttributes

Sets parameters of the [mobile push notification channel](../concepts/push.md).

## HTTP request {#request}

```http
POST https://{{ cns-host }}/
```

### Query parameters {#parameters}

Parameter | Description
--- | ---
`Action` | **string**<br/>Required field.<br/>Operation type parameter.<br/>Value: `SetPlatformApplicationAttributes`.
`PlatformApplicationArn` | **string**<br/>Required field.<br/>Mobile push notification channel ID.<br/>Example: `arn:aws:sns::aoegtvhtp8ob********:app/GCM/test-cns-9990`.
`Attributes.entry.N.key` | **string**<br/>Required field.<br/>[Attribute](#attributes) key. `N` is a numeric value.<br/>Example: `Attributes.entry.1.key=PlatformPrincipal&Attributes.entry.2.key=PlatformCredential`.
`Attributes.entry.N.value` | **string**<br/>Required field.<br/>Attribute value. `N` is a numeric value.<br/>Example: `Attributes.entry.1.value=c8gzjriSVxDDzX2fAV********&Attributes.entry.2.value=CgB6e3x9iW/qiE9l9wAUPK0e/bJQe5uIgTlYUD4bP********`.
`ResponseFormat` | **string**<br/>Response format.<br/>The possible values include:<ul><li>`XML` (default)</li><li>`JSON`.</li></ul>

### Attributes {#attributes}

#### Common attributes {#attributes-common}

Attribute | Description
--- | ---
`Description` | **string**<br/>Application description.<br/>Example: `Test application`

#### APNS and APNS_SANDBOX attributes {#attributes-apns}

Attribute | Description
--- | ---
`PlatformPrincipal` | **string**<br/>Token in `.p8` format or SSL certificate in `.p12` format. Token-based authentication is preferred as a more modern option.
`PlatformCredential` | **string**<br/>Token ID or private key of the SSL certificate.
`ApplePlatformTeamID` | **string**<br/>Developer ID, only when using a token.
`ApplePlatformBundleID` | **string**<br/>App ID (bundle ID), only when using a token.

#### FCM attributes {#attributes-fcm}

Attribute | Description
--- | ---
`PlatformCredential` | **string**<br/>Key of the Google Cloud service account in JSON format for authentication with the HTTP v1 API or API key (server key) for authentication with the legacy API. The HTTP v1 API is preferred as [FCM will no longer support](https://firebase.google.com/docs/cloud-messaging/migrate-v1) the legacy API starting from June 2024.

#### HMS attributes {#attributes-hms}

Attribute | Description
--- | ---
`PlatformPrincipal` | **string**<br/>Key ID.
`PlatformCredential` | **string**<br/>API key.

#### RUSTORE attributes {#attributes-rustore}

Attribute | Description
--- | ---
`PlatformPrincipal` | **string**<br/>Project ID.
`PlatformCredential` | **string**<br/> Service token.

For more information about authentication attributes, see the [Mobile push notification channels](../concepts/push.md) subsection.

## Response {#response}

### Successful response {#response-200}

If there are no errors, {{ cns-name }} returns the `200` HTTP code.

A successful response contains additional data in XML or JSON format depending on the specified `ResponseFormat` parameter.

Data schema:

{% list tabs %}

- XML

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <SetPlatformApplicationAttributes>
	  <ResponseMetadata>
		  <RequestId>string</RequestId>
	  </ResponseMetadata>
  </SetPlatformApplicationAttributes>
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

In case of an error, {{ cns-name }} returns a message with the appropriate HTTP code.

For a list of common error codes for all actions, see [{#T}](common-errors.md).

## See also {#see-also}

* [{#T}](index.md)
* [{#T}](send-request.md)
* [SetPlatformApplicationAttributes API action](https://docs.aws.amazon.com/sns/latest/api/API_SetPlatformApplicationAttributes.html) in the AWS documentation.

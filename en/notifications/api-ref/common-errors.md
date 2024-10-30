# Errors

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

## List of common error codes {#errors}

HTTP | Error code | Extended code | Description
--- | --- | --- | ---
400 | InvalidParameter | InvalidParameter | An invalid parameter was provided. See the `ParamName` field for the parameter name.
400 | InvalidParameter | InvalidAttribute | An invalid attribute was provided. See the `ParamName` field for the attribute name.
403 | AuthorizationError | NoCredentials | [AWS Signature V4](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html) or [IAM token](../../iam/concepts/authorization/iam-token.md) was either not provided or provided in an invalid format.
403 | AuthorizationError | Unauthenticated | Authentication failed.
403 | AuthorizationError | Unauthorized | Not enough permissions to perform the operation.
404 | NotFound | AccountNotFound | The account ([cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) ID) was not found.
404 | NotFound | FolderNotFound | There is no [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with this ID.
429 | ThrottlingException | TooManyRequests | Too many requests. Reduce the request rate.

## List of error codes specific for actions with PlatformApplication or PlatformEndpoint {#errors-push}

HTTP | Error code | Extended code | Description
--- | --- | --- | ---
404 | NotFound | AppNotFound | There is no mobile push notification channel with this ID (ARN).
404 | NotFound | EndpointNotFound | There is no mobile endpoint with this ID (ARN).

## List of error codes specific for actions with text messages (SMS) {#errors-sms}

HTTP | Error code | Extended code | Description
--- | --- | --- | ---
400 | serError | SMSChannelIsBanned | The SMS notification channel is banned.
404 | NotFound | SMSChannelNotFound | There is no SMS notification channel with this ID (ARN).
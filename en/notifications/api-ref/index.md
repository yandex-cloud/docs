# {{ cns-full-name }} HTTP API overview

The {{ cns-name }} HTTP API is compatible with the [Amazon SNS API](https://docs.aws.amazon.com/sns/latest/api/welcome.html).

For a more user-friendly experience, you can use the [AWS CLI](../tools/aws-cli.md), [AWS SDK for Python (boto3)](../tools/sdk-python.md), and other [AWS-compatible SDKs](../tools/).

For authentication in the API, CLI and SDK, use a [static access key](../../iam/concepts/authorization/access-key.md). A static access key is issued for the [service account](../../iam/concepts/users/service-accounts.md), and all actions are performed on behalf of that service account.

{% note info %}

API requests to {{ cns-name }} with a static key must be signed using the [AWS Signature V4](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html) algorithm.

{% endnote %}

To avoid signing API requests to {{ cns-name }}, you can use an [IAM token](../../iam/concepts/authorization/iam-token.md) instead of a static key. For more information, see [{#T}](send-request.md).

For a list of common error codes for all actions, see [{#T}](common-errors.md).

## Supported actions {#actions}

### PlatformApplications {#platform-applications}

| Action | Description |
| --- | --- |
| [Create](create-platform-application.md) | Creating a [mobile push notification channel](../concepts/push.md) |
| [GetAttributes](get-platform-application-attributes.md) | Getting parameters of the mobile push notification channel |
| [SetAttributes](set-platform-application-attributes.md) | Setting parameters of the mobile push notification channel |
| [List](list-platform-applications.md) | Getting a list of mobile push notification channels |
| [Delete](delete-platform-application.md) | Deleting a mobile push notification channel |

### Endpoint {#endpoint}

| Action | Description |
| --- | --- |
| [Create](create-platform-endpoint.md) | Creating an [endpoint for push notifications](../concepts/index.md#mobile-endpoints) (subscribing the user to push notifications) |
| [GetAttributes](get-endpoint-attributes.md) | Getting endpoint parameters |
| [SetAttributes](set-endpoint-attributes.md) | Setting endpoint parameters |
| [List](list-endpoints.md) | Getting a list of endpoints |
| [Delete](delete-endpoint.md) | Deleting an endpoint (unsubscribing the user from push notifications)  |

### SMS {#sms}

| Action | Description |
| --- | --- |
| [Create](create-sms-channel.md) | Creating an [SMS notification channel](../concepts/sms.md). |
| [GetAttributes](get-sms-channel-attributes.md) | Getting SMS notification channel properties. |
| [GetSmsAttributes](get-sms-attributes.md) | Getting properties to send SMS notifications in cloud. |
| [SetAttributes](set-sms-channel-attributes.md) | Setting SMS notification channel properties. |
| [List](list-sms-channels.md) | Getting a list of SMS notification channels. |
| [Delete](delete-sms-channel.md) | Deleting an SMS notification channel. |

### Sandbox {#sandbox}

| Action | Description |
| --- | --- |
| [Create](create-sms-sandbox-phone-number.md) | Adding a [test phone number](../concepts/sms.md#sandbox) to an SMS notification channel and sending a one-time password to a phone number. |
| [Verify](verify-sms-sandbox-phone-number.md) | Verifying a phone number with a one-time password. |
| [List](list-sms-sandbox-phone-numbers.md) | Getting a list of verified phone numbers. |
| [Delete](delete-sms-sandbox-phone-number.md) | Deleting a verified phone number. |

### Publish {#publish}

| Action | Description |
| --- | --- |
| [Publish](publish.md) | Sending a push notification or SMS. |
# Getting started with {{ cns-full-name }} using AWS CLI

{% include [preview-stage](../../_includes/notifications/preview-stage.md) %}

{% include [ask-for-turning-on](../../_includes/notifications/ask-for-turning-on.md) %}

{% include [about-service](../../_includes/notifications/about-service.md) %}

{% include [channels-push-preview](../../_includes/notifications/channels-push-preview.md) %}

With {{ cns-name }}, you can send notifications to apps registered in the following services:
* [Apple Push Notification service](https://developer.apple.com/notifications/) (APNs).
* [Firebase Cloud Messaging](https://firebase.google.com/) (FCM).
* [Huawei Mobile Services](https://developer.huawei.com/consumer/) (HMS).

To get started with the AWS CLI:
1. [Prepare your cloud](#before-you-begin).
1. [Get a static access key](#static-key).
1. [Set up the AWS CLI](#aws-cli).
1. [Create a notification channel](#create-channel).
1. [Get a list of channels](#list-channel).
1. [Create an endpoint](#create-endpoint).
1. [Send a notification](#publish).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Get a static access key {#static-key}

{% include [sa-role-static-key](../../_includes/notifications/sa-role-static-key.md) %}

## Set up the AWS CLI {#aws-cli}

The [AWS CLI](https://aws.amazon.com/cli/) is a command line interface designed for AWS services. The {{ cns-name }} HTTP API is compatible with the [Amazon SNS API](https://docs.aws.amazon.com/sns/latest/api/welcome.html). To learn [how to run commands](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/index.html), see the official Amazon documentation.

To configure the AWS CLI:
1. [Install](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) the AWS CLI.
1. Enter the command to configure the AWS CLI:

   ```bash
   aws configure
   ```

1. Enter the values for these parameters:
    * `AWS Access Key ID`: Static key ID
    * `AWS Secret Access Key`: Secret key
    * `Default region name`: `{{ region-id }}`

      {% note info %}

      To work with {{ cns-name }}, always specify `{{ region-id }}` as the region. A different region value may lead to an authorization error.

      {% endnote %}

1. Leave the other parameter values unchanged.
1. Set the {{ cns-name }} endpoint:

    ```bash
    aws configure set endpoint_url https://{{ cns-host }}/
    ```

{% cut "Sample configuration files" %}

* `~/.aws/config`:

  ```text
  [default]
  region = {{ region-id }}
  endpoint_url = https://{{ cns-host }}/
  ```

* `~/.aws/credentials`:

  ```text
  [default]
  aws_access_key_id = <static_key_ID>
  aws_secret_access_key = <secret_key>
  ```

{% endcut %}

For more information about setting up the AWS CLI, see the [AWS documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html).

## Create a notification channel {#create-channel}

To create a [notification channel](../concepts/index.md#channels), run this command:

```bash
aws sns create-platform-application \
  --name <channel_name> \
  --platform GCM \
  --attributes PlatformCredential=<FCM_API_key>
```

Where:
* `--name`: Notification channel name, user-defined. The name must be unique within the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud). It may contain lowercase and uppercase Latin letters, numbers, underscores, hyphens, and periods. It may be from 1 to 256 characters long. For APNs channels, we recommend specifying the bundle ID in the name, and for FCM and HMS, the full package name.
* `--platform`: Mobile platform type:
  * `APNS` and `APNS_SANDBOX`: Apple Push Notification service (APNs). Use `APNS_SANDBOX` to test the application.
  * `GCM`: Firebase Cloud Messaging (FCM).
  * `HMS`: Huawei Mobile Services (HMS).
* `--attributes`: Mobile platform authentication parameters in `key=value` format. The values depend on platform:
  * APNs:
    * Token-based authentication:
      * `PlatformPrincipal`: Path to the signature key file from Apple.
      * `PlatformCredential`: Key ID.
      * `ApplePlatformTeamID`: Team ID.
      * `ApplePlatformBundleID`: Bundle ID.
    * Certificate-based authentication:
      * `PlatformPrincipal`: SSL certificate in `.pem` format.
      * `PlatformCredential`: Certificate private key in `.pem` format.

        {% include [convert-p12-to-pem](../../_includes/notifications/convert-p12-to-pem.md) %}

    Token-based authentication is preferred as it is more modern.
  * FCM: `PlatformCredential` is the Google Cloud service account key in JSON format for authentication with the HTTP v1 API or API key (server key) for authentication with the legacy API.

    We recommend escaping the file contents using the `jq @json <<< cat private_key.json` command, as the AWS CLI accepts this parameter in string format.

    The HTTP v1 API is preferred as [FCM will no longer support](https://firebase.google.com/docs/cloud-messaging/migrate-v1) the legacy API starting from June 2024.
  * HMS:
    * `PlatformPrincipal`: Key ID
    * `PlatformCredential`: API key

As a result, you will get a notification channel ID (ARN). Save it for future use.

For more information about the `aws sns create-platform-application` command, see the [AWS documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/create-platform-application.html).

## Get a list of notification channels {#list-channel}

```bash
aws sns list-platform-applications
```

You will get the list of notification channels located in the same folder as the service account.

For more information about the `aws sns list-platform-applications` command, see the [AWS documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/list-platform-applications.html).

## Create an endpoint {#create-endpoint}

To create a [mobile endpoint](../concepts/index.md#mobile-endpoints), run the following command:

```bash
aws sns create-platform-endpoint \
  --platform-application-arn <notification_channel_ARN> \
  --token <push_token>
```

Where:
* `--platform-application-arn`: Notification channel ID (ARN).
* `--token`: Unique push token for the application on the user’s device.

As a result, you will get a mobile endpoint ID (ARN). Save it for future use.

For more information about the `aws sns create-platform-endpoint` command, see the [AWS documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/create-platform-endpoint.html).

## Send a notification {#publish}

### Explicit notifications (Bright Push) {#bright-push}

{% list tabs %}

- Apple iOS (APNs)

  ```bash
  aws sns publish \
    --target-arn "<endpoint_ARN>" \
    --message-structure json \
    --message '{"default": "<notification_text>", "APNS": "{ \"aps\": { \"alert\": \"<notification_text>\"} }" }'
  ```

- Google Android (FCM)

  ```bash
  aws sns publish \
    --target-arn "<endpoint_ARN>" \
    --message-structure json \
    --message '{"default": "<notification_text>", "GCM": "{ \"notification\": { \"body\": \"<notification_text>\"} }" }'
  ```

{% endlist %}

Where:
* `--target-arn`: Mobile endpoint ID (ARN)
* `--message-structure`: Message format
* `--message`: Message

### Silent notifications (Silent Push) {#silent-push}

```bash
aws sns publish \
  --target-arn <endpoint_ARN> \
  --message-structure json \
  --message '{"data": { "key": "value" } }'
```

Where:
* `--target-arn`: Mobile endpoint ID (ARN)
* `--message-structure`: Message format
* `--message`: Message

For more information about the `aws sns publish` command, see the [AWS documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/publish.html).

## See also {#see-also}

* [Getting started](../quickstart.md)
* [AWS SDK for Python (boto3)](sdk-python.md)
* [Concepts](../concepts/index.md)

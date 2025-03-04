---
title: Getting started with {{ cns-full-name }} using AWS CLI
description: The {{ cns-name }} HTTP API is compatible with the Amazon SNS API.
---

# Getting started with {{ cns-full-name }} using AWS CLI

{% include [preview-stage](../../_includes/notifications/preview-stage.md) %}

To get started with the AWS CLI:
1. [Get your cloud ready](#before-you-begin).
1. [Get a static access key](#static-key).
1. [Set up the AWS CLI](#aws-cli).
1. [Create a notification channel](#create-channel).
1. [Get a list of channels](#list-channel).
1. [Create an endpoint](#create-endpoint).
1. [Send a notification](#publish).

## Get your cloud ready {#before-you-begin}

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

{% include [push-channel-create-aws](../../_includes/notifications/push-channel-create-aws.md) %}


## Get a list of notification channels {#list-channel}

```bash
aws sns list-platform-applications
```

You will get the list of notification channels located in the same folder as the service account.

For more information about the `aws sns list-platform-applications` command, see the [AWS documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/list-platform-applications.html).

## Create an endpoint {#create-endpoint}

To create a [mobile endpoint](../concepts/index.md#mobile-endpoints), run the following command:

{% include [endpoint-create-aws](../../_includes/notifications/endpoint-create-aws.md) %}


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

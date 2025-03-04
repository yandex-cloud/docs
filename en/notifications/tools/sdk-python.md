# Getting started with the AWS SDK for Python (boto3) in {{ cns-full-name }}

{% include [preview-stage](../../_includes/notifications/preview-stage.md) %}

[boto3](https://github.com/boto/boto3) is a software development kit (SDK) for the Python 3.x programming language. The SDK is designed for working with services compatible with the [Amazon SNS API](https://docs.aws.amazon.com/sns/latest/api/welcome.html).

To get started with the AWS SDK for Python (boto3):
1. [Get your cloud ready](#before-you-begin).
1. [Get a static access key](#static-key).
1. [Configure the AWS SDK](#aws-sdk).
1. [Create a notification channel](#create-channel).
1. [Get a list of channels](#list-channel).
1. [Create an endpoint](#create-endpoint).
1. [Send a notification](#publish).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Get a static access key {#static-key}

{% include [sa-role-static-key](../../_includes/notifications/sa-role-static-key.md) %}

## Configure the AWS SDK {#aws-sdk}

1. [Install Python](https://wiki.python.org/moin/BeginnersGuide/Download).
1. Install the AWS SDK for Python (boto3) using this command:

    ```bash
    pip install boto3
    ```

1. Create a client:

    ```python
    import boto3

    client = boto3.client(
        "sns",
        endpoint_url="https://{{ cns-host }}/",
        region_name="{{ region-id }}",
        aws_access_key_id="<static_key_ID>",
        aws_secret_access_key="<secret_key>",
        verify=False # Disable SSL verification for {{ cns-host }}
    )
    ```

    Where:
    * `aws_access_key_id`: Static key ID.
    * `aws_secret_access_key`: Secret key.

## Create a notification channel {#create-channel}

{% include [push-channel-create-python](../../_includes/notifications/push-channel-create-python.md) %}

## Get a list of notification channels {#list-channel}

```python
response = client.list_platform_applications()
for app in response["PlatformApplications"]:
    print("Application ARN:", app["PlatformApplicationArn"])
```

You will get the list of notification channels located in the same folder as the service account.

## Create an endpoint {#create-endpoint}

{% include [endpoint-create-python](../../_includes/notifications/endpoint-create-python.md) %}


## Send a notification {#publish}

### Explicit notifications (Bright Push) {#bright-push}

{% list tabs %}

- Apple iOS (APNs)

  ```python
  response = client.publish(
      TargetArn="<endpoint_ID>",
      Message=json.dumps({
          "default": "<notification_text>",
          "APNS": json.dumps({
              "aps": {
                  "alert": "<notification_text>"
              }
          })
      }),
      MessageStructure="json"
  )
  print ("Message id:", response["MessageId"])
  ```

- Google Android (FCM)

  ```python
  response = client.publish(
      TargetArn="<endpoint_ID>",
      Message=json.dumps({
          "default": "<notification_text>",
          "GCM": json.dumps({
              "notification": {
                  "body": "<notification_text>"
              }
          })
      }),
      MessageStructure="json"
  )
  print ("Message id:", response["MessageId"])
  ```

{% endlist %}

Where:
* `TargetArn`: Mobile endpoint ID (ARN).
* `MessageStructure`: Message format.
* `Message`: Message.

### Silent notifications (Silent Push) {#silent-push}

```python
response = client.publish(
    TargetArn="<endpoint ARN>",
    Message='{"data": { "key": "value" } }')
print ("Message id:", response["MessageId"])
```

Where:
* `TargetArn`: Mobile endpoint ID (ARN)
* `Message`: Message

## See also {#see-also}

* [Getting started](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Concepts](../concepts/index.md)

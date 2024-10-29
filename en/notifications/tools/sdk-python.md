# Getting started with the AWS SDK for Python (boto3) in {{ cns-full-name }}

[boto3](https://github.com/boto/boto3) is a software development kit (SDK) for the Python 3.x programming language. The SDK is designed for working with services compatible with the [Amazon SNS API](https://docs.aws.amazon.com/sns/latest/api/welcome.html).

To get started with the AWS SDK for Python (boto3):
1. [Prepare your cloud](#before-you-begin).
1. [Get a static access key](#static-key).
1. [Configure the AWS SDK](#aws-sdk).
1. [Create a notification channel](#create-channel).
1. [Get a list of channels](#list-channel).
1. [Create an endpoint](#create-endpoint).
1. [Send a notification](#publish).

## Prepare your cloud {#before-you-begin}

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

```python
response = client.create_platform_application(
    Name="<channel_name>",
    Platform="GCM",
    Attributes= {
         "PlatformCredential": "<FCM_API_key>"
    }
)
print ("Platform application ARN:", response['PlatformApplicationArn'])
```

Where:
* `Name`: Notification channel name, user-defined. The name must be unique within the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud). It may contain lowercase and uppercase Latin letters, numbers, underscores, hyphens, and periods. It may be 1 to 256 characters long. For APNs channels, we recommend specifying the bundle ID in the name, and for FCM and HMS, the full package name.
* `Platform`: Mobile platform type:
  * `APNS` and `APNS_SANDBOX`: Apple Push Notification service (APNs). Use `APNS_SANDBOX` to test the application.
  * `GCM`: Firebase Cloud Messaging (FCM).
  * `HMS`: Huawei Mobile Services (HMS).
* `Attributes`: Mobile platform authentication parameters in `key=value` format. The values depend on the platform type:
  * APNs:
    * Token-based authentication:
      * `PlatformPrincipal`: Token in `.p8` format.
      * `PlatformCredential`: Token ID.
      * `ApplePlatformTeamID`: Developer ID.
      * `ApplePlatformBundleID`: Bundle ID.
    * Certificate-based authentication:
      * `PlatformPrincipal`: SSL certificate in `.p12` format.
      * `PlatformCredential`: Certificate private key.

    Token-based authentication is preferred as it is more modern.
  * FCM: `PlatformCredential` is the Google Cloud service account key in JSON format for authentication with the HTTP v1 API or API key (server key) for authentication with the Legacy API.

    The HTTP v1 API is preferred as [FCM will no longer support](https://firebase.google.com/docs/cloud-messaging/migrate-v1) the Legacy API starting June 2024.
  * HMS:
    * `PlatformPrincipal`: Key ID
    * `PlatformCredential`: API key

As a result, you will get a notification channel ID (ARN).

## Get a list of notification channels {#list-channel}

```python
response = client.list_platform_applications()
for app in response["PlatformApplications"]:
    print("Application ARN:", app["PlatformApplicationArn"])
```

You will get the list of notification channels located in the same folder as the service account.

## Create an endpoint {#create-endpoint}

```python
response = client.create_platform_endpoint(
    PlatformApplicationArn="<notification_channel_ARN>",
    Token="<push_token>",
)
print ("Endpoint ARN:", response["EndpointArn"])
```

Where:
* `PlatformApplicationArn`: Notification channel ID (ARN).
* `Token`: Unique push token for the app on the user’s device.

As a result, you will get a mobile endpoint ID (ARN).

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
* `TargetArn`: Mobile endpoint ID (ARN).
* `Message`: Message.

## See also {#see-also}

* [Getting started](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Concepts](../concepts/index.md)

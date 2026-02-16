# Sending an HTTP API request to {{ cns-full-name }}

The service's HTTP API is compatible with the [Amazon SNS API](https://docs.aws.amazon.com/sns/latest/api/welcome.html).

You can find all the supported actions in the [API reference](../api-ref/index.md).

To get started with the HTTP API using curl:
1. [Get your cloud ready](#before-you-begin).
1. [Get the authentication data](#get-key).
1. [Create a notification channel](#create-channel).
1. [Get a list of channels](#list-channel).
1. [Create an endpoint](#create-endpoint).
1. [Send a notification](#publish).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Get the authentication credentials {#get-key}

For authentication in the API, use a [static access key](../../iam/concepts/authorization/access-key.md) or [IAM token](../../iam/concepts/authorization/iam-token.md).

{% note info %}

API requests to {{ cns-name }} with a static key must be signed using the [AWS Signature V4](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html) algorithm. To avoid signing requests, use an IAM token.

{% endnote %}

See these guides on how to get an IAM token:
* [{#T}](../../iam/operations/iam-token/create.md)
* [{#T}](../../iam/operations/iam-token/create-for-federation.md)
* [{#T}](../../iam/operations/iam-token/create-for-sa.md)

{% cut "How to get a static access key" %}

{% include [sa-role-static-key](../../_includes/notifications/sa-role-static-key.md) %}

{% endcut %}

To make API requests, a user or service account must have at least the `editor` [role](../../iam/roles-reference.md#editor) for the folder.

## Create a notification channel {#create-channel}

```bash
export IAM_TOKEN=<IAM_token>
curl \
  --header "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data-urlencode "Action=CreatePlatformApplication" \
  --data-urlencode "ResponseFormat=JSON" \
  --data-urlencode "FolderId=<folder_ID>" \
  --data-urlencode "Name=<channel_name>" \
  --data-urlencode "Platform=GCM" \
  --data-urlencode "Attributes.entry.1.key=PlatformCredential" \
  --data-urlencode "Attributes.entry.1.value=<FCM_API_key>"
  "https://{{ cns-host }}/"
```

Where:
* `IAM_TOKEN`: [IAM token](../../iam/concepts/authorization/iam-token.md).
* `Action`: [Operation type](index.md#actions).
* `ResponseFormat`: Response format, JSON or XML.
* `FolderId`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
* `Name`: Notification channel name, user-defined.

  {% include [channel-name](../../_includes/notifications/channel-name.md) %}

* `Platform`: Mobile platform type:
  
  {% include [platform-types](../../_includes/notifications/platform-types.md) %}

* `Attributes.entry.N.key`: Authentication attribute keys on the mobile platform. The values depend on the platform:
  * APNs:
    * Token-based authentication:
      * `PlatformPrincipal`: Token in `.p8` format.
      * `PlatformCredential`: Token ID.
      * `ApplePlatformTeamID`: Developer ID.
      * `ApplePlatformBundleID`: Bundle ID.
    * Certificate-based authentication:
      * `PlatformPrincipal`: SSL certificate in `.p12` format.
      * `PlatformCredential`: Certificate private key.

    Token-based authentication is preferred as a more modern option.
  * FCM: `PlatformCredential` is the Google Cloud service account key in JSON format for authentication with the HTTP v1 API or API key (server key) for authentication with the Legacy API.

    The HTTP v1 API is preferred as [FCM will no longer support](https://firebase.google.com/docs/cloud-messaging/migrate-v1) the Legacy API starting June 2024.
  * HMS:
    * `PlatformPrincipal`: Key ID.
    * `PlatformCredential`: API key.
  * RuStore:
    * `PlatformPrincipal`: Project ID (ProjectID).
    * `PlatformCredential`: Service token (ServiceToken).
* `Attributes.entry.N.key`: Authentication attribute keys on the mobile platform.

As a result, you will get a notification channel ID (ARN).

For more information, see [{#T}](create-platform-application.md).

## Get a list of channels {#list-channel}

```bash
export IAM_TOKEN=<IAM_token>
curl \
  --header "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data-urlencode "Action=ListPlatformApplications" \
  --data-urlencode "ResponseFormat=JSON" \
  --data-urlencode "FolderId=<folder_ID>" \
  "https://{{ cns-host }}/"
```

Where:
* `IAM_TOKEN`: [IAM token](../../iam/concepts/authorization/iam-token.md).
* `Action`: [Operation type](index.md#actions).
* `ResponseFormat`: Response format, JSON or XML.
* `FolderId`: [Folder ID](../../resource-manager/operations/folder/get-id.md).

For more information, see [{#T}](list-platform-applications.md).

## Create an endpoint {#create-endpoint}

```bash
export IAM_TOKEN=<IAM_token>
curl \
  --header "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data-urlencode "Action=CreatePlatformEndpoint" \
  --data-urlencode "ResponseFormat=JSON" \
  --data-urlencode "PlatformApplicationArn=<notification_channel_ARN>" \
  --data-urlencode "Token=<push_token>" \
  "https://{{ cns-host }}/"
```

Where:
* `IAM_TOKEN`: [IAM token](../../iam/concepts/authorization/iam-token.md).
* `Action`: [Operation type](index.md#actions).
* `ResponseFormat`: Response format, JSON or XML.
* `PlatformApplicationArn`: Notification channel ID (ARN).
* `Token`: Unique push token for the app on the user’s device.

As a result, you will get a mobile endpoint ID (ARN).

For more information, see [{#T}](create-platform-endpoint.md).

## Send a notification {#publish}

### Explicit notifications (Bright Push) {#bright-push}

```bash
export IAM_TOKEN=<IAM_token>
curl \
  --header "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data-urlencode "Action=Publish" \
  --data-urlencode "ResponseFormat=JSON" \
  --data-urlencode "TargetArn=<endpoint_ID>" \
  --data-urlencode "Message={"default": "<notification_text>", "GCM": "{ \"notification\": { \"body\": \"<notification_text>\"} }" }" \
  --data-urlencode "MessageStructure=json" \
  "https://{{ cns-host }}/"
```

Where:
* `IAM_TOKEN`: [IAM token](../../iam/concepts/authorization/iam-token.md).
* `Action`: [Operation type](index.md#actions).
* `ResponseFormat`: Response format, JSON or XML.
* `TargetArn`: Mobile endpoint ID (ARN).
* `Message`: Message.
* `MessageStructure`: Message format.

### Silent notifications (Silent Push) {#silent-push}

```bash
export IAM_TOKEN=<IAM_token>
curl \
  --header "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data-urlencode "Action=Publish" \
  --data-urlencode "ResponseFormat=JSON" \
  --data-urlencode "TargetArn=<endpoint_ID>" \
  --data-urlencode "Message={\"data\": { \"key\": \"value\" } }" \
  --data-urlencode "MessageStructure=json" \
  "https://{{ cns-host }}/"
```

Where:
* `IAM_TOKEN`: [IAM token](../../iam/concepts/authorization/iam-token.md).
* `Action`: [Operation type](index.md#actions).
* `ResponseFormat`: Response format, JSON or XML.
* `TargetArn`: Mobile endpoint ID (ARN).
* `Message`: Message.
* `MessageStructure`: Message format.

For more information, see [{#T}](publish.md).
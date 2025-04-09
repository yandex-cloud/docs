# How to get started with the AWS SDK for JavaScript in {{ cns-full-name }}

{% include [preview-stage](../../_includes/notifications/preview-stage.md) %}

To get started with the AWS SDK for JavaScript:

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

You can find the prerequisites and an AWS SDK for JavaScript installation guide in the relevant [AWS documentation](https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/setting-up.html).

1. [Install](https://nodejs.org/en/download) Node.js.
1. Initialize your project in the selected directory:

    ```bash
    npm init -y
    ```

1. Install the package with the AWS SNS client:

    ```bash
    npm i @aws-sdk/client-sns
    ```

1. Add `"type": "module"` to the `package.json` file to use the ESM syntax.
1. Create a client in the `index.js` file:

    ```javascript
    import * as AWS from "@aws-sdk/client-sns";
    
    const snsClient = new AWS.SNSClient({
        endpoint: "https://{{ cns-host }}/",
        region: "{{ region-id }}",
        credentials: {
            accessKeyId: "<static_key_ID>",
            secretAccessKey: "<secret_key>",
        },
    })
    ```

1. Command to run the program:

    ```bash
    node index.js
    ```


## Create a notification channel {#create-channel}

```javascript
const response = await client.send(
    new AWS.CreatePlatformApplicationCommand({
        Name: "<channel_name>",
        Platform: "<platform_type>",
        Attributes: { <authentication_type>: "<key>" },
    })
);
console.log(`PlatformApplication ARN: ${response.PlatformApplicationArn}`);
```

Where:

* `Name`: Notification channel name, user-defined.
  
    {% include [channel-name](../../_includes/notifications/channel-name.md) %}
    
* `Platform`: Mobile platform type:

    {% include [platform-types](../../_includes/notifications/platform-types.md) %}

* `Attributes`: Mobile platform authentication parameters in `key=value` format. The values depend on the platform:

    {% include [auth-attributes](../../_includes/notifications/auth-attributes.md) %}


## Get a list of notification channels {#list-channel}

```javascript
const response = await client.send(new AWS.ListPlatformApplicationsCommand({}));
console.log(
    response.PlatformApplications.map(
        (t) => `Application ARN: ${t.PlatformApplicationArn}`
    ).join("\n")
);
```

You will get the list of notification channels located in the same folder as the service account.


## Create an endpoint {#create-endpoint}

```javascript
const response = await client.send(
    new AWS.CreatePlatformEndpointCommand({
        PlatformApplicationArn: "<notification_channel_ARN>",
        Token: "<push_token>",
    })
);
console.log(`Endpoint ARN: ${response.EndpointArn}`);
```

Where:

* `PlatformApplicationArn`: Notification channel ID (ARN).
* `Token`: Unique push token for the application on the user’s device.


## Send a notification {#publish}

### Explicit notifications (Bright Push) {#bright-push}

{% list tabs %}

- Apple iOS (APNs)

  ```javascript
  const message = {
      default: "<notification_text>",
      APNS: JSON.stringify({
          aps: {
              alert: "<notification_text>",
          },
      }),
  };

  const response = await client.send(
      new AWS.PublishCommand({
          Message: JSON.stringify(message),
          TargetArn: "<endpoint_ARN>",
          MessageStructure: "json",
      })
  );
  console.log(`Message id: ${response.MessageId}`);
  ```

- Google Android (GCM)

  ```javascript
  const message = {
      default: "<notification_text>",
      GCM: JSON.stringify({
          notification: {
              body: "<notification_text>",
          },
      }),
  };
  const response = await client.send(
      new AWS.PublishCommand({
          Message: JSON.stringify(message),
          TargetArn: "<endpoint_ARN>",
          MessageStructure: "json",
      })
  );
  console.log(`Message id: ${response.MessageId}`);
  ```

{% endlist %}

Where:

* `message`: Message
* `TargetArn`: Mobile endpoint ID (ARN)
* `MessageStructure`: Message format


### Silent notifications (Silent Push) {#silent-push}

{% list tabs %}

- Apple iOS (APNs)

  ```javascript
  const message = {
      default: "<notification_text>",
      APNS: JSON.stringify({
          key: "value",
      }),
  };
  const response = await client.send(
      new AWS.PublishCommand({
          Message: JSON.stringify(message),
          TargetArn: "<endpoint_ARN>",
          MessageStructure: "json",
      })
  );
  console.log(`Message id: ${response.MessageId}`);
  ```

- Google Android (GCM)

  ```javascript
  const message = {
      default: "<notification_text>",
      GCM: JSON.stringify({
          data: {
              key: "value",
          },
      }),
  };

  const response = await client.send(
      new AWS.PublishCommand({
          Message: JSON.stringify(message),
          TargetArn: "<endpoint_ARN>",
          MessageStructure: "json",
      })
  );
  console.log(`Message id: ${response.MessageId}`);
  ```

{% endlist %}

Where:

* `message`: Message
* `TargetArn`: Mobile endpoint ID (ARN)
* `MessageStructure`: Message format


### Text message {#sms-messages}

```javascript
const response = await client.send(
    new AWS.PublishCommand({
        PhoneNumber: "<phone_number>",
        Message: "<notification_text>",
        MessageAttributes: {
            "AWS.SNS.SMS.SenderID": {
                DataType: "String",
                StringValue: "<sender's_text_name>"
            }
        }
    })
);
console.log(`Message id: ${response.MessageId}`);
```

Where:

* `PhoneNumber`: Recipient's phone number
* `Message`: Notification text
* `StringValue`: Sender's text name


## See also {#see-also}

* [Getting started](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Concepts](../concepts/index.md)
* [AWS developer guide](https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/getting-started-nodejs.html)
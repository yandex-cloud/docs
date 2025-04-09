# How to get started with the AWS SDK for Go in {{ cns-full-name }}

{% include [preview-stage](../../_includes/notifications/preview-stage.md) %}

To get started with the AWS SDK for Go:

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

You can find the prerequisites and an AWS SDK for Go installation guide in the relevant [AWS documentation](https://docs.aws.amazon.com/sdk-for-go/v2/developer-guide/getting-started.html).

1. [Install](https://go.dev/doc/install) Go.
1. Initialize the local project in the selected directory:

    ```shell
    go mod init example
    ```

1. Install the required modules:

    ```shell
    go get github.com/aws/aws-sdk-go-v2
    go get github.com/aws/aws-sdk-go-v2/config
    go get github.com/aws/aws-sdk-go-v2/service/sns
    ```

1. Create a client:

    ```go
    package main
    
    import (
        "github.com/aws/aws-sdk-go-v2/aws"
        "github.com/aws/aws-sdk-go-v2/service/sns"
    )
    
    var endpoint = string("https://{{ cns-host }}/")
    var credProvider = aws.CredentialsProviderFunc(func(context.Context) (aws.Credentials, error) {
        cred := aws.Credentials{
            AccessKeyID:     "<static_key_ID>",
            SecretAccessKey: "<secret_key>",
        }
        return cred, nil
    })
    
    func main() {
        config := aws.NewConfig()
        config.BaseEndpoint = &endpoint
        config.Region = "{{ region-id }}"
        config.Credentials = credProvider
        client := sns.NewFromConfig(*config)
    }
    ```

    Where:

    * `AccessKeyID`: Static key ID
    * `SecretAccessKey`: Secret key


## Create a notification channel {#create-channel}

```go
attributes := map[string]string{}
attributes["<authentication_type>"] = "<key>"
name := "<channel_name>"
platform := "<platform_type>"
createPlatformApplicationInput := sns.CreatePlatformApplicationInput{
    Attributes: attributes,
    Name:       &name,
    Platform:   &platform,
}

createPlatformApplicationOutput, err := client.CreatePlatformApplication(context.TODO(), &createPlatformApplicationInput)
if err != nil {
    log.Println(err.Error())
} else {
    fmt.Println("Platform application ARN:", *createPlatformApplicationOutput.PlatformApplicationArn)
}
```

Where:

* `attributes`: Mobile platform authentication parameters in `key=value` format. The values depend on the platform:

    {% include [auth-attributes](../../_includes/notifications/auth-attributes.md) %}

* `name`: Notification channel name, user-defined.
  
    {% include [channel-name](../../_includes/notifications/channel-name.md) %}
    
* `platform`: Mobile platform type:

    {% include [platform-types](../../_includes/notifications/platform-types.md) %}


## Get a list of notification channels {#list-channel}

```go
apps, err := client.ListPlatformApplications(context.TODO(), &sns.ListPlatformApplicationsInput{})
if err != nil {
    log.Println(err.Error())
} else {
    for _, app := range apps.PlatformApplications {
  fmt.Println("Application ARN:", *app.PlatformApplicationArn)
    }
}
```

You will get the list of notification channels located in the same folder as the service account.


## Create an endpoint {#create-endpoint}

```go
appArn := "<notification_channel_ARN>"
token := "<push_token>"
createPlatformEndpointInput := sns.CreatePlatformEndpointInput{
    PlatformApplicationArn: &appArn,
    Token:                  &token,
}

createPlatformEndpointOutput, err := client.CreatePlatformEndpoint(context.TODO(), &createPlatformEndpointInput)
if err != nil {
    log.Println(err.Error())
} else {
    fmt.Println("Endpoint ARN:", *createPlatformEndpointOutput.EndpointArn)
}
```

Where:

* `appArn`: Notification channel ID (ARN).
* `token`: Unique push token for the application on the user’s device.


## Send a notification {#publish}

### Explicit notifications (Bright Push) {#bright-push}

{% list tabs %}

- Apple iOS (APNs)

  ```go
  targetArn := "<endpoint_ARN>"
  message := `{"default": "<notification_text>", "APNS": "{\"aps\": {\"alert\": \"<notification_text>\"}}"}`
  messageStructure := "json"
  publishInput := sns.PublishInput{
      TargetArn:        &targetArn,
      Message:          &message,
      MessageStructure: &messageStructure,
  }

  publishOutput, err := client.Publish(context.TODO(), &publishInput)
  if err != nil {
      log.Println(err.Error())
  } else {
      fmt.Println("Message id:", *publishOutput.MessageId)
  }
  ```

- Google Android (GCM)

  ```go
  targetArn := "<endpoint_ARN>"
  message := `{"default": "<notification_text>", "GCM": "{\"notification\": {\"body\": \"<notification_text>\"}}"}`
  messageStructure := "json"
  publishInput := sns.PublishInput{
      TargetArn:        &targetArn,
      Message:          &message,
      MessageStructure: &messageStructure,
  }

  publishOutput, err := client.Publish(context.TODO(), &publishInput)
  if err != nil {
      log.Println(err.Error())
  } else {
      fmt.Println("Message id:", *publishOutput.MessageId)
  }
  ```

{% endlist %}

Where:

* `targetArn`: Mobile endpoint ID (ARN)
* `messageStructure`: Message format
* `message`: Message


### Silent notifications (Silent Push) {#silent-push}

{% list tabs %}

- Apple iOS (APNs)

  ```go
  targetArn := "<endpoint_ARN>"
  message := `{"default": "<notification_text>", "APNS": "{\"key\": \"value\"}"}`
  messageStructure := "json"
  publishInput := sns.PublishInput{
      TargetArn:        &targetArn,
      Message:          &message,
      MessageStructure: &messageStructure,
  }

  publishOutput, err := client.Publish(context.TODO(), &publishInput)
  if err != nil {
      log.Println(err.Error())
  } else {
      fmt.Println("Message id:", *publishOutput.MessageId)
  }
  ```

- Google Android (GCM)

  ```go
  targetArn := "<endpoint_ARN>"
  message := `{"default": "<notification_text>", "GCM": "{\"data\": {\"key\": \"value\"}}"}`
  messageStructure := "json"
  publishInput := sns.PublishInput{
      TargetArn:        &targetArn,
      Message:          &message,
      MessageStructure: &messageStructure,
  }

  publishOutput, err := client.Publish(context.TODO(), &publishInput)
  if err != nil {
      log.Println(err.Error())
  } else {
      fmt.Println("Message id:", *publishOutput.MessageId)
  }
  ```

{% endlist %}

Where:

* `targetArn`: Mobile endpoint ID (ARN)
* `message`: Message
* `messageStructure`: Message format


### Text message {#sms-messages}

```go
phoneNumber := "<phone_number>"
message := "<notification_text>"
dataType := "String"
stringValue := "<sender's_text_name>"
messageAttributes := map[string]types.MessageAttributeValue{}
messageAttributes["AWS.SNS.SMS.SenderID"] = types.MessageAttributeValue{
  DataType:    &dataType,
  StringValue: &stringValue,
}
publishSMSInput := sns.PublishInput{
  Message:           &message,
  PhoneNumber:       &phoneNumber,
  MessageAttributes: messageAttributes,
}
publishSMSOutput, err := client.Publish(context.TODO(), &publishSMSInput)
if err != nil {
  log.Println(err.Error())
} else {
  fmt.Println("Message id:", *publishSMSOutput.MessageId)
}
```

Where:

* `phoneNumber`: Recipient's phone number
* `message`: Notification text
* `stringValue`: Sender's text name


## See also {#see-also}

* [Getting started](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Concepts](../concepts/index.md)
# How to get started with the AWS SDK for .NET in {{ cns-full-name }}

{% include [preview-stage](../../_includes/notifications/preview-stage.md) %}

To get started with the AWS SDK for .NET:

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

You can find the prerequisites and an AWS SDK for .NET installation guide in the relevant [AWS documentation](https://docs.aws.amazon.com/sdk-for-net/v3/developer-guide/welcome.html).

The guide below is for .NET 8.

1. [Install](https://learn.microsoft.com/en-us/dotnet/core/install/) .NET Core SDK.
1. Initialize your project in the selected directory:

    ```bash
    dotnet new console --name example-app
    ```

1. Install the AWS SDK for .NET for SNS:

    ```bash
    cd example-app/
    dotnet add package AWSSDK.SimpleNotificationService
    ```

1. Create a client. Replace the `Program.cs` file contents with this code:

    ```csharp
    using Amazon.Runtime;
    using Amazon.SimpleNotificationService;
    using Amazon.SimpleNotificationService.Model;
    
    public static class ExampleSNS
    {
        static async Task Main(string[] args)
        {
            var endpoint = "https://{{ cns-host }}/";
            var credentials = new BasicAWSCredentials(
                "<static_key_ID>",
                "<secret_key>"
            );
    
            var snsClient = new AmazonSimpleNotificationServiceClient(
                credentials,
                new AmazonSimpleNotificationServiceConfig
                {
                    ServiceURL = endpoint,
                    AuthenticationRegion = "{{ region-id }}"
                }
            );
        }
    }
    ```

    Where `credentials` contains the static key ID and secret key.

1. Build and run the project:

    ```bash
    dotnet build
    dotnet run
    ```

## Create a notification channel {#create-channel}

```csharp
try
{
    var request = new CreatePlatformApplicationRequest
    {
        Name = "<channel_name>",
        Platform = "<platform_type>",
        Attributes = new Dictionary<string, string>
        {
            { "<authentication_type>", "<key>" }
        }
    };

    var response = await snsClient.CreatePlatformApplicationAsync(request);

    Console.WriteLine("Platform application ARN: " + response.PlatformApplicationArn);
}
catch (Exception ex)
{
    Console.WriteLine("Error creating platform application: " + ex.Message);
}
```

Where:

* `Name`: Notification channel name, user-defined.

    {% include [channel-name](../../_includes/notifications/channel-name.md) %}
    
* `Platform`: Mobile platform type:

    {% include [platform-types](../../_includes/notifications/platform-types.md) %}

* `Attributes`: Mobile platform authentication parameters in `key=value` format. The values depend on the platform:

    {% include [auth-attributes](../../_includes/notifications/auth-attributes.md) %}


## Get a list of notification channels {#list-channel}

```csharp
var response = await snsClient.ListPlatformApplicationsAsync(new ListPlatformApplicationsRequest());

response.PlatformApplications.ForEach(app =>
    Console.WriteLine($"Platform Application ARN: {app.PlatformApplicationArn}\n")
);
```

You will get the list of notification channels located in the same folder as the service account.


## Create an endpoint {#create-endpoint}

```csharp
try
{
    var response = await snsClient.CreatePlatformEndpointAsync(new CreatePlatformEndpointRequest
    {
        PlatformApplicationArn = "<notification_channel_ARN>",
        Token = "<push_token>"
    });

    Console.WriteLine($"Endpoint ARN: {response.EndpointArn}");
}
catch (Exception ex)
{
    Console.WriteLine($"Error creating platform endpoint: {ex.Message}");
}
```

Where:

* `PlatformApplicationArn`: Notification channel ID (ARN).
* `Token`: Unique push token for the application on the user’s device.


## Send a notification {#publish}

### Explicit notifications (Bright Push) {#bright-push}

{% list tabs %}

- Apple iOS (APNs)

  ```csharp
  try
  {
      var targetArn = "<endpoint_ARN>";
      var message = @"{
          ""default"": ""<notification_text>"",
          ""APNS"": ""{\""aps\"": {\""alert\"": \""<notification_text>\""}}""
      }";
      var messageStructure = "json";

      var request = new PublishRequest
      {
          TargetArn = targetArn,
          Message = message,
          MessageStructure = messageStructure
      };

      var response = await snsClient.PublishAsync(request);

      Console.WriteLine("Message ID: " + response.MessageId);
  }
  catch (Exception ex)
  {
      Console.WriteLine("Error publishing message: " + ex.Message);
  }
  ```

- Google Android (GCM)

  ```csharp
  try
  {
      var targetArn = "<endpoint_ARN>";
      var message = @"{
          ""default"": ""<notification_text>"",
          ""GCM"": ""{\""notification\"": {\""body\"": \""<notification_text>\""}}""}";
      var messageStructure = "json";

      var request = new PublishRequest
      {
          TargetArn = targetArn,
          Message = message,
          MessageStructure = messageStructure
      };

      var response = await snsClient.PublishAsync(request);

      Console.WriteLine("Message ID: " + response.MessageId);
  }
  catch (Exception ex)
  {
      Console.WriteLine("Error publishing message: " + ex.Message);
  }
  ```

{% endlist %}

Where:

* `TargetArn`: Mobile endpoint ID (ARN)
* `Message`: Message
* `MessageStructure`: Message format


### Silent notifications (Silent Push) {#silent-push}

{% list tabs %}

- Apple iOS (APNs)

  ```csharp
  try
  {
      var targetArn = "<endpoint_ARN>";
      var message = @"{
          ""default"": ""<notification_text>"",
          ""APNS"": ""{\""key\"": \""value\""}""
      }";
      var messageStructure = "json";

      var request = new PublishRequest
      {
          TargetArn = targetArn,
          Message = message,
          MessageStructure = messageStructure
      };

      var response = await snsClient.PublishAsync(request);

      Console.WriteLine("Message ID: " + response.MessageId);
  }
  catch (Exception ex)
  {
      Console.WriteLine("Error publishing message: " + ex.Message);
  }
  ```

- Google Android (GCM)

  ```csharp
  try
  {
      var targetArn = "<endpoint_ARN>";
      var message = @"{
          ""default"": ""<notification_text>"",
          ""GCM"": ""{\""data\"": {\""key\"": \""value\""}}""}";
      var messageStructure = "json";

      var request = new PublishRequest
      {
          TargetArn = targetArn,
          Message = message,
          MessageStructure = messageStructure
      };

      var response = await snsClient.PublishAsync(request);

      Console.WriteLine("Message ID: " + response.MessageId);
  }
  catch (Exception ex)
  {
      Console.WriteLine("Error publishing message: " + ex.Message);
  }
  ```

{% endlist %}

Where:

* `TargetArn`: Mobile endpoint ID (ARN)
* `Message`: Message
* `MessageStructure`: Message format


### Text message {#sms-messages}

```csharp
try
{
    var phoneNumber = "<phone_number>";
    var message = "<notification_text>";

    var request = new PublishRequest
    {
        PhoneNumber = phoneNumber,
        Message = message,
        MessageAttributes = new Dictionary<string, MessageAttributeValue>
        {
            { 
                "AWS.SNS.SMS.SenderID", 
                new MessageAttributeValue
                {
                    DataType = "String",
                    StringValue = "<sender's_text_name>"
                }
            }
        }
    };

    var response = await snsClient.PublishAsync(request);

    Console.WriteLine("Message ID: " + response.MessageId);
}
catch (Exception ex)
{
    Console.WriteLine("Error sending SMS: " + ex.Message);
}
```

Where:

* `PhoneNumber`: Recipient's phone number
* `Message`: Notification text
* `StringValue`: Sender's text name


## See also {#see-also}

* [Getting started](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Concepts](../concepts/index.md)
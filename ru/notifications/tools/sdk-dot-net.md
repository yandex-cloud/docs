# Как начать работать с AWS SDK для .NET в {{ cns-full-name }}

{% include [preview-stage](../../_includes/notifications/preview-stage.md) %}

Чтобы начать работу с AWS SDK для .NET:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Получите статический ключ доступа](#static-key).
1. [Настройте AWS SDK](#aws-sdk).
1. [Создайте канал уведомлений](#create-channel).
1. [Получите список каналов](#list-channel).
1. [Создайте эндпоинт](#create-endpoint).
1. [Отправьте уведомление](#publish).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


## Получите статический ключ доступа {#static-key}

{% include [sa-role-static-key](../../_includes/notifications/sa-role-static-key.md) %}


## Настройте AWS SDK {#aws-sdk}

Пререквизиты и инструкция по установке AWS SDK для .NET также описаны в [документации AWS](https://docs.aws.amazon.com/sdk-for-net/v3/developer-guide/welcome.html).

Инструкция ниже приведена для версии .NET 8.

1. [Установите](https://learn.microsoft.com/en-us/dotnet/core/install/) .NET Core SDK.
1. Инициализируйте проект в выбранной директории:

    ```bash
    dotnet new console --name example-app
    ```

1. Установите пакет AWS SDK for .NET для SNS:

    ```bash
    cd example-app/
    dotnet add package AWSSDK.SimpleNotificationService
    ```

1. Создайте клиент. Замените содержимое файла `Program.cs` следующим кодом:

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
                "<идентификатор_статического_ключа>",
                "<секретный_ключ>"
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

    Где `credentials` содержит идентификатор статического ключа и секретный ключ.

1. Соберите и запустите проект:

    ```bash
    dotnet build
    dotnet run
    ```

## Создайте канал уведомлений {#create-channel}

```csharp
try
{
    var request = new CreatePlatformApplicationRequest
    {
        Name = "<имя_канала>",
        Platform = "<тип_платформы>",
        Attributes = new Dictionary<string, string>
        {
            { "<тип_аутентификации>", "<ключ>" }
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

Где:

* `Name` — имя канала уведомлений, задается пользователем.

    {% include [channel-name](../../_includes/notifications/channel-name.md) %}
    
* `Platform` — тип мобильной платформы:

    {% include [platform-types](../../_includes/notifications/platform-types.md) %}

* `Attributes` — параметры аутентификации на мобильной платформе в формате `ключ=значение`. Значения зависят от типа платформы:

    {% include [auth-attributes](../../_includes/notifications/auth-attributes.md) %}


## Получите список каналов уведомлений {#list-channel}

```csharp
var response = await snsClient.ListPlatformApplicationsAsync(new ListPlatformApplicationsRequest());

response.PlatformApplications.ForEach(app =>
    Console.WriteLine($"Platform Application ARN: {app.PlatformApplicationArn}\n")
);
```

В результате будет выведен список каналов уведомлений, размещенных в том же каталоге, в котором находится сервисный аккаунт.


## Создайте эндпоинт {#create-endpoint}

```csharp
try
{
    var response = await snsClient.CreatePlatformEndpointAsync(new CreatePlatformEndpointRequest
    {
        PlatformApplicationArn = "<ARN_канала_уведомлений>",
        Token = "<Push-токен>"
    });

    Console.WriteLine($"Endpoint ARN: {response.EndpointArn}");
}
catch (Exception ex)
{
    Console.WriteLine($"Error creating platform endpoint: {ex.Message}");
}
```

Где:

* `PlatformApplicationArn` — идентификатор (ARN) канала уведомлений.
* `Token` — уникальный Push-токен приложения на устройстве пользователя.


## Отправьте уведомление {#publish}

### Явные уведомления (Bright Push) {#bright-push}

{% list tabs %}

- Apple iOS (APNs)

  ```csharp
  try
  {
      var targetArn = "<ARN_ендпоинта>";
      var message = @"{
          ""default"": ""<текст_уведомления>"",
          ""APNS"": ""{\""aps\"": {\""alert\"": \""<текст_уведомления>\""}}""
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
      var targetArn = "<ARN_эндпоинта>";
      var message = @"{
          ""default"": ""<текст_уведомления>"",
          ""GCM"": ""{\""notification\"": {\""body\"": \""<текст_уведомления>\""}}""}";
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

Где:

* `TargetArn` — идентификатор (ARN) мобильного эндпоинта.
* `Message` — сообщение.
* `MessageStructure` — формат сообщения.


### Тихие уведомления (Silent Push) {#silent-push}

{% list tabs %}

- Apple iOS (APNs)

  ```csharp
  try
  {
      var targetArn = "<ARN_ендпоинта>";
      var message = @"{
          ""default"": ""<текст_уведомления>"",
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
      var targetArn = "<ARN_эндпоинта>";
      var message = @"{
          ""default"": ""<текст_уведомления>"",
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

Где:

* `TargetArn` — идентификатор (ARN) мобильного эндпоинта.
* `Message` — сообщение.
* `MessageStructure` — формат сообщения.


### SMS-сообщения {#sms-messages}

```csharp
try
{
    var phoneNumber = "<номер_телефона>";
    var message = "<текст_уведомления>";

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
                    StringValue = "<текстовое_имя_отправителя>"
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

Где:

* `PhoneNumber` — номер телефона получателя.
* `Message` — текст уведомления.
* `StringValue` — текстовое имя отправителя.


## См. также {#see-also}

* [Начало работы](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Концепции](../concepts/index.md)
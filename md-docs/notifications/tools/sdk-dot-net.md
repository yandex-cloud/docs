# Как начать работать с AWS SDK для .NET в Yandex Cloud Notification Service


Чтобы начать работу с AWS SDK для .NET:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Получите статический ключ доступа](#static-key).
1. [Настройте AWS SDK](#aws-sdk).
1. [Создайте канал уведомлений](#create-channel).
1. [Получите список каналов](#list-channel).
1. [Создайте эндпоинт](#create-endpoint).
1. [Отправьте уведомление](#publish).


## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


## Получите статический ключ доступа {#static-key}

Для аутентификации в Cloud Notification Service используется [статический ключ доступа](../../iam/concepts/authorization/access-key.md). Этот ключ выпускается на [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), и все действия выполняются от имени этого сервисного аккаунта.

Чтобы получить статический ключ доступа:
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../iam/roles-reference.md#editor) `editor` на каталог.
1. Для сервисного аккаунта [создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статический ключ доступа.

    Сохраните идентификатор и секретный ключ.


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
            var endpoint = "https://notifications.yandexcloud.net/";
            var credentials = new BasicAWSCredentials(
                "<идентификатор_статического_ключа>",
                "<секретный_ключ>"
            );
    
            var snsClient = new AmazonSimpleNotificationServiceClient(
                credentials,
                new AmazonSimpleNotificationServiceConfig
                {
                    ServiceURL = endpoint,
                    AuthenticationRegion = "ru-central1"
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

    Имя должно быть уникальным для всего CNS. После создания канала изменить имя нельзя. Имя может содержать строчные и заглавные буквы латинского алфавита, цифры, подчеркивания, дефисы и точки. Длина — от 1 до 256 символов. Рекомендуется для каналов APNs указывать в имени идентификатор приложения (Bundle ID), для FCM и HMS — полное название пакета приложения (Package name), для RuStore — значение `packageName`.
    
* `Platform` — тип мобильной платформы:

    * `APNS` и `APNS_SANDBOX` — Apple Push Notification service (APNs). Для тестирования приложения используйте `APNS_SANDBOX`.
    * `GCM` — Firebase Cloud Messaging (FCM).
    * `HMS` — Huawei Mobile Services (HMS).
    * `RUSTORE` — RuStore Android.

* `Attributes` — параметры аутентификации на мобильной платформе в формате `ключ=значение`. Значения зависят от типа платформы:

    * APNs:
    
        * Аутентификация с токеном:
    
            * `PlatformPrincipal` — путь к файлу с ключом подписи токена, полученный в Apple.
            * `PlatformCredential` — идентификатор ключа подписи (Key ID).
            * `ApplePlatformTeamID` — идентификатор разработчика (Team ID).
            * `ApplePlatformBundleID` — идентификатор приложения (Bundle ID).
    
        * Аутентификация с сертификатом:
    
            * `PlatformPrincipal` — SSL-сертификат в формате `.pem`.
            * `PlatformCredential` — закрытый ключ сертификата в формате `.pem`.
    
                Чтобы сохранить сертификат и закрытый ключ в отдельных файлах формата `.pem`, вы можете воспользоваться утилитой [openssl](https://docs.openssl.org/1.1.1/man1/pkcs12) в Linux:
                
                ```bash
                openssl pkcs12 -in Certificates.p12 -nokeys -nodes -out certificate.pem
                openssl pkcs12 -in Certificates.p12 -nocerts -nodes -out privatekey.pem
                ```
    
        Аутентификация с токеном — более современный и безопасный метод.
    
    * FCM: `PlatformCredential` — ключ сервисного аккаунта Google Cloud в формате JSON для аутентификации с помощью HTTP v1 API или API-ключ (server key) для аутентификации с помощью Legacy API.
    
        Используйте HTTP v1 API, так как с июля 2024 года [FCM legacy API не поддерживается](https://firebase.google.com/docs/cloud-messaging/migrate-v1).
    
    * HMS:
    
        * `PlatformPrincipal` — идентификатор ключа.
        * `PlatformCredential` — API-ключ.


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


#### Полезные ссылки {#see-also}

* [Начало работы](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Концепции](../concepts/index.md)
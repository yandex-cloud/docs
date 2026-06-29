# Как начать работать с AWS SDK для Go в Yandex Cloud Notification Service


Чтобы начать работу с AWS SDK для Go:

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

Пререквизиты и инструкция по установке AWS SDK для Go также [описаны в документации AWS](https://docs.aws.amazon.com/sdk-for-go/v2/developer-guide/getting-started.html).

1. [Установите](https://go.dev/doc/install) Go.
1. Инициализируйте локальный проект в выбранной директории:

    ```shell
    go mod init example
    ```

1. Установите необходимые модули:

    ```shell
    go get github.com/aws/aws-sdk-go-v2
    go get github.com/aws/aws-sdk-go-v2/config
    go get github.com/aws/aws-sdk-go-v2/service/sns
    ```

1. Создайте клиент:

    ```go
    package main
    
    import (
        "github.com/aws/aws-sdk-go-v2/aws"
        "github.com/aws/aws-sdk-go-v2/service/sns"
    )
    
    var endpoint = string("https://notifications.yandexcloud.net/")
    var credProvider = aws.CredentialsProviderFunc(func(context.Context) (aws.Credentials, error) {
        cred := aws.Credentials{
            AccessKeyID:     "<идентификатор_статического_ключа>",
            SecretAccessKey: "<секретный_ключ>",
        }
        return cred, nil
    })
    
    func main() {
        config := aws.NewConfig()
        config.BaseEndpoint = &endpoint
        config.Region = "ru-central1"
        config.Credentials = credProvider
        client := sns.NewFromConfig(*config)
    }
    ```

    Где:

    * `AccessKeyID` — идентификатор статического ключа.
    * `SecretAccessKey` — секретный ключ.


## Создайте канал уведомлений {#create-channel}

```go
attributes := map[string]string{}
attributes["<тип_аутентификации>"] = "<ключ>"
name := "<имя_канала>"
platform := "<тип_платформы>"
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

Где:

* `attributes` — параметры аутентификации на мобильной платформе в формате `ключ=значение`. Значения зависят от типа платформы:

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

* `name` — имя канала уведомлений, задается пользователем.
  
    Имя должно быть уникальным для всего CNS. После создания канала изменить имя нельзя. Имя может содержать строчные и заглавные буквы латинского алфавита, цифры, подчеркивания, дефисы и точки. Длина — от 1 до 256 символов. Рекомендуется для каналов APNs указывать в имени идентификатор приложения (Bundle ID), для FCM и HMS — полное название пакета приложения (Package name), для RuStore — значение `packageName`.
    
* `platform` — тип мобильной платформы:

    * `APNS` и `APNS_SANDBOX` — Apple Push Notification service (APNs). Для тестирования приложения используйте `APNS_SANDBOX`.
    * `GCM` — Firebase Cloud Messaging (FCM).
    * `HMS` — Huawei Mobile Services (HMS).
    * `RUSTORE` — RuStore Android.


## Получите список каналов уведомлений {#list-channel}

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

В результате будет выведен список каналов уведомлений, размещенных в том же каталоге, в котором находится сервисный аккаунт.


## Создайте эндпоинт {#create-endpoint}

```go
appArn := "<ARN_канала_уведомлений>"
token := "<Push-токен>"
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

Где:

* `appArn` — идентификатор (ARN) канала уведомлений.
* `token` — уникальный Push-токен приложения на устройстве пользователя.


## Отправьте уведомление {#publish}

### Явные уведомления (Bright Push) {#bright-push}

{% list tabs %}

- Apple iOS (APNs)

  ```go
  targetArn := "<ARN_ендпоинта>"
  message := `{"default": "<текст_уведомления>", "APNS": "{\"aps\": {\"alert\": \"<текст_уведомления>\"}}"}`
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
  targetArn := "<ARN_ендпоинта>"
  message := `{"default": "<текст_уведомления>", "GCM": "{\"notification\": {\"body\": \"<текст_уведомления>\"}}"}`
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

Где:

* `targetArn` — идентификатор (ARN) мобильного эндпоинта.
* `messageStructure` — формат сообщения.
* `message` — сообщение.


### Тихие уведомления (Silent Push) {#silent-push}

{% list tabs %}

- Apple iOS (APNs)

  ```go
  targetArn := "<ARN_ендпоинта>"
  message := `{"default": "<текст_уведомления>", "APNS": "{\"key\": \"value\"}"}`
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
  targetArn := "<ARN_ендпоинта>"
  message := `{"default": "<текст_уведомления>", "GCM": "{\"data\": {\"key\": \"value\"}}"}`
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

Где:

* `targetArn` — идентификатор (ARN) мобильного эндпоинта.
* `message` — сообщение.
* `messageStructure` — формат сообщения.


### SMS-сообщения {#sms-messages}

```go
phoneNumber := "<номер_телефона>"
message := "<текст_уведомления>"
dataType := "String"
stringValue := "<текстовое_имя_отправителя>"
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

Где:

* `phoneNumber` — номер телефона получателя.
* `message` — текст уведомления.
* `stringValue` — текстовое имя отправителя.


#### Полезные ссылки {#see-also}

* [Начало работы](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Концепции](../concepts/index.md)
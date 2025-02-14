# Как начать работать с AWS SDK для Go в {{ cns-full-name }}

{% include [preview-stage](../../_includes/notifications/preview-stage.md) %}

Чтобы начать работу с AWS SDK для Go:

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
    
    var endpoint = string("https://{{ cns-host }}/")
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
        config.Region = "{{ region-id }}"
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

    {% include [auth-attributes](../../_includes/notifications/auth-attributes.md) %}

* `name` — имя канала уведомлений, задается пользователем. Должно быть уникальным в [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud). Может содержать строчные и заглавные буквы латинского алфавита, цифры, подчеркивания, дефисы и точки. Допустимая длина — от 1 до 256 символов. Рекомендуется для каналов APNs указывать в имени идентификатор приложения (Bundle ID), для FCM и HMS — полное название пакета приложения (Package name).
* `platform` — тип мобильной платформы:

    {% include [platform-types](../../_includes/notifications/platform-types.md) %}


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


## См. также {#see-also}

* [Начало работы](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Концепции](../concepts/index.md)
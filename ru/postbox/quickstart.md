# Как начать работать с {{ postbox-full-name }}

С помощью этой инструкции вы создадите свой адрес и отправите проверочное письмо.

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Создайте сервисный аккаунт и ключи {#service-account-and-keys}

Для отправки писем вам потребуется сервисный аккаунт, статический ключ для использования в AWS CLI и публичный ключ для создания DKIM-подписи.

1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md) c ролью `postbox.sender`.
1. [Создайте статический ключ](../iam/operations/sa/create-access-key.md) сервисного аккаунта.
1. [Установите и настройте AWS CLI](https://aws.amazon.com/ru/cli/), указав идентификатор, секретный ключ и регион `ru-central1`.
1. Сгенерируйте приватный ключ: `openssl genrsa -out privatekey.pem 2048`.

## Создайте адрес {#create-address}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать адрес.
1. В списке сервисов выберите **{{ postbox-name }}**.
1. Нажмите кнопку **Создать адрес**.
1. Укажите **Домен**, с которого вы будете отправлять письма. Домен может быть любого уровня.
1. Укажите **Cелектор**: `mail`.
1. Скопируйте в поле **Приватный ключ** содержимое файла приватного ключа `privatekey.pem`, созданного на [этапе подготовки](#service-account-and-keys).
1. Нажмите кнопку **Создать**.

## Пройдите проверку владения доменом {#verify-domain}

Чтобы рассылать письма, подтвердите владение доменом. После создания записи на ее странице сформируются настройки DKIM-подписи. Их нужно указать в качестве значений ресурсной записи, которую необходимо добавить в вашу доменную зону. Вы можете добавить запись у вашего регистратора или в сервисе [{{ dns-full-name }}](../dns/), если вы делегировали ваш домен. 

Пример создания ресурсной записи в **{{ dns-name }}**:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится ваша доменная зона.
1. В списке сервисов выберите **{{ dns-name }}**.
1. Выберите вашу доменную зону.
1. Нажмите кнопку **Создать запись**.
1. В поле **Имя** укажите сгенерированное при создании адреса имя вида `mail._domainkey.example.com`.
1. В списке **Тип** выберите `TXT`.
1. В поле **Значение** скопируйте содержимое поля **Значение** из блока **Подтверждение подписи**. Обратите внимание, что значение записи нужно разбить на отдельные строки, например:
		
		( "v=DKIM1;h=sha256;k=rsa; "

		"p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAui6NEIfZdLfcbcJV4oqY5lWyYXV1ht1zYdrSHCVCWWBaOZ2mIGVzycDKPicLSDZBlN4I8HO2ajclFfQn3013klP7i6VrDSXMmO9hRGgVU+ZhoFJrsMRdbDK/1SIU1k7xiJIudB+YPcc69Y/jHQJk32q7b"

		"UC617oEwSL/sQHeueS0rMLrmPyOtXELLLHrx9IiHM8ACb6zFY/lWx3AnuOLOv4JXYPAQe+b2zvERpHA+AbaCUHi8dJVm1aY/TceakHkUMlWzh4YeSfuQkaNI1PEnLGA3u0WIGyvtTdA3FWhT3w3BFsVWCTFPIxjORvaY/eZMMcj3WM7GUtORbebAOUyBwIDAQAB" )
1. Нажмите кнопку **Создать**.

Подождите несколько минут. Если запись верна, статус верификации на странице адреса должен смениться на `Success`.

## Отправьте проверочное письмо {#send-test-letter}

Отправьте проверочное письмо с помощью AWS CLI. Подготовьте два JSON-файла:

`destination.json` — файл со списком адресов назначения:

```json
{
  "ToAddresses": ["test@example.com"]
}
```

`message.json` — файл с темой и содержимым письма:

```json
{
  "Simple": {
    "Subject": {
      "Data": "Test message",
      "Charset": "UTF-8"
    },
    "Body": {
      "Text": {
        "Data": "Test message. Hello!",
        "Charset": "UTF-8"
      }
    }
  }
}
```

Отправьте письмо с помощью AWS CLI:

```bash
aws sesv2 send-email --from-email-address mail@example.com --destination file://destination.json --content file://message.json --endpoint-url https://postbox.cloud.yandex.net
```

Проверьте почтовый ящик, указанный в `destination.json`, — туда должно прийти тестовое письмо.
# Как начать работать с {{ postbox-full-name }}

С помощью этой инструкции вы создадите свой адрес и отправите проверочное письмо.

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Создайте сервисный аккаунт и ключи {#service-account-and-keys}

1. [Создайте](../iam/operations/sa/create.md) сервисный аккаунт `postbox-user` c ролью `postbox.sender`.
1. [Создайте](../iam/operations/sa/create-access-key.md) статические ключи доступа. Надежно сохраните идентификатор и секретный ключ. После того как вы закроете окно, параметры секретного ключа станут недоступны.
1. Сгенерируйте ключ для создания DKIM-подписи:
    ```
    openssl genrsa -out privatekey.pem 2048
    ```

## Создайте адрес {#create-address}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать адрес.
1. В списке сервисов выберите **{{ postbox-name }}**.
1. Нажмите кнопку **Создать адрес**.
1. Укажите **Домен**, с которого будете отправлять письма. Домен может быть любого уровня.
1. Укажите **Селектор**: `mail`.
1. Скопируйте в поле **Приватный ключ** содержимое файла приватного ключа `privatekey.pem`, [созданного ранее](#service-account-and-keys).
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

Отправить проверочное письмо можно с помощью:
* AWS CLI.
* протокола SMTP.

### AWS CLI

1. [Установите](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) утилиту командной строки AWS CLI.
1. Настройте AWS CLI:
    1. Запустите интерактивную настройку профиля:
        ```
        aws configure
        ```
    1. Укажите полученный ранее идентификатор ключа сервисного аккаунта `postbox-user`:
        ```
        AWS Access Key ID [****************ver_]: <идентификатор_ключа_сервисного_аккаунта>
        ```
    1. Укажите полученный ранее секретный ключ сервисного аккаунта `postbox-user`:
        ```
        AWS Secret Access Key [****************w5lb]: <секретный_ключ_сервисного_аккаунта>
        ```
    1. Укажите имя региона по умолчанию {{ region-id }}:
        ```
        Default region name [{{ region-id }}]: {{ region-id }}
        ```
    1. Укажите формат выходных данных по умолчанию json:
        ```
        Default output format [None]: json
        ```

1. Подготовьте два JSON-файла:

    * `destination.json` — файл со списком адресов назначения:

        ```json
        {
          "ToAddresses": ["test@example.com"]
        }
        ```

     * `message.json` — файл с темой и содержимым письма:

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

1. Отправьте письмо с помощью AWS CLI:

    ```bash
    aws sesv2 send-email --from-email-address mail@example.com --destination file://destination.json --content file://message.json --endpoint-url https://postbox.cloud.yandex.net
    ```

1. Проверьте почтовый ящик, указанный в `destination.json`, — туда должно прийти тестовое письмо.

### SMTP

1. Получите пароль, используя секретный ключ сервисного аккаунта `postbox-user`. Для этого вызовите скрипт `generate.py`:
    ```
    python generate.py <секретный_ключ_сервисного_аккаунта>
    ```

    {% cut "generate.py" %}

    ```
    #!/usr/bin/env python3

    import hmac
    import hashlib
    import base64
    import argparse

    # These values are required to calculate the signature. Do not change them.
    DATE = "20230926"
    SERVICE = "postbox"
    MESSAGE = "SendRawEmail"
    REGION = "{{ region-id }}"
    TERMINAL = "aws4_request"
    VERSION = 0x04


    def sign(key, msg):
        return hmac.new(key, msg.encode("utf-8"), hashlib.sha256).digest()


    def calculate_key(secret_access_key):
        signature = sign(("AWS4" + secret_access_key).encode("utf-8"), DATE)
        signature = sign(signature, REGION)
        signature = sign(signature, SERVICE)
        signature = sign(signature, TERMINAL)
        signature = sign(signature, MESSAGE)
        signature_and_version = bytes([VERSION]) + signature
        smtp_password = base64.b64encode(signature_and_version)
        return smtp_password.decode("utf-8")


    def main():
        parser = argparse.ArgumentParser(
            description="Convert a Secret Access Key to an SMTP password."
        )
        parser.add_argument("secret", help="The Secret Access Key to convert.")
        args = parser.parse_args()

        print(calculate_key(args.secret))


    if __name__ == "__main__":
        main()
    ```

    {% endcut %}

1. Укажите следующие параметры в вашем почтовом клиенте:
    * имя сервера — `postbox.cloud.yandex.net`;
    * порт — `25`;
    * имя пользователя — идентификатор ключа сервисного аккаунта `postbox-user`;
    * пароль, полученный на предыдущем шаге.

    {% note info %}

    Почтовый клиент должен поддерживать [расширение STARTTLS](https://ru.wikipedia.org/wiki/STARTTLS) для шифрования передаваемых писем.

    {% endnote %}

1. Отправьте письмо с помощью вашего почтового клиента и убедитесь, что оно пришло на указанные адреса.

# Отправка письма

В Yandex Cloud Postbox можно отправить письмо:
* с помощью [AWS CLI](#aws-cli);
* из почтового клиента по [протоколу SMTP](#smtp);
* с помощью [AWS SDK](#aws-sdk);
* с помощью утилиты [cURL](#curl).

{% note info %}

Для обеспечения безопасности передачи данных сервис Yandex Cloud Postbox поддерживает версии протокола TLS 1.2 и 1.3.

{% endnote %}

## Перед началом работы {#before-begin}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт в том же каталоге, в котором находится адрес. Если вы создадите сервисный аккаунт и адрес в разных каталогах, при попытке отправить письмо возникнет ошибка.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../security/index.md#postbox-sender) `postbox.sender`.
1. Создайте ключ для сервисного аккаунта:

    * [API-ключ](../../iam/operations/authentication/manage-api-keys.md#create-api-key). При создании API-ключа задайте область действия `yc.postbox.send`. Надежно сохраните полученный секретный ключ. После того как вы закроете окно, параметры секретного ключа станут недоступны.

    * [Статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key). Надежно сохраните идентификатор и секретный ключ. После того как вы закроете окно, параметры секретного ключа станут недоступны.

    * [IAM-токен](../../iam/operations/iam-token/create-for-sa.md). Этот способ авторизации подходит для отправки писем из [функций](../../functions/concepts/function.md) Cloud Functions и [контейнеров](../../serverless-containers/concepts/container.md) Serverless Containers, а также для [виртуальных машин](../../compute/concepts/vm.md) Compute Cloud, к которым привязан сервисный аккаунт. Выбирайте его, если не хотите создавать и хранить статические ключи доступа.

        {% note warning %}

        Учитывайте, что IAM-токен действует не больше 12 часов. Если нужно прописать данные для аутентификации в конфигурационном файле почтового клиента, используйте аутентификацию по API-ключу или паролю.

        {% endnote %}

    Доступные комбинации способов аутентификации и отправки письма:

    ![arrow_right](../../_assets/console-icons/arrow-right.svg)<br>**Способ отправки письма**<br>**Способ аутентификации**<br>![arrow_down](../../_assets/console-icons/arrow-down.svg) | **AWS CLI** | **SMTP** | **AWS SDK** | **cURL**
    :---: | --- | --- | --- | ---
    |**API-ключ** | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) ||
    **Статический ключ доступа** | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) ||
    **IAM-токен** | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg)

## Отправить письмо {#send-email}

### AWS CLI {#aws-cli}

{% list tabs %}

- Cтатический ключ доступа

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
        1. Укажите имя региона по умолчанию ru-central1:
            ```
            Default region name [ru-central1]: ru-central1
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
        aws sesv2 send-email \
          --from-email-address mail@example.com \
          --destination file://destination.json \
          --content file://message.json \
          --endpoint-url https://postbox.cloud.yandex.net
        ```
    
    1. Проверьте почтовый ящик, указанный в `destination.json`, — туда должно прийти письмо.

{% endlist %}

### SMTP {#smtp}

{% list tabs group=auth_keys %}

- API-ключ {#api-key}

    1. В настройках SMTP-сервера вашего почтового клиента укажите следующие параметры:
    
        #|
        || | **Почтовый клиент поддерживает STARTTLS** | **Почтовый клиент не поддерживает STARTTLS, но поддерживает SMTPS** ||
        || **Имя сервера** | `postbox.cloud.yandex.net` {align="center"} | > ||
        || **Порт** | `587` | `465` ||
        || **Имя пользователя** | Идентификатор созданного API-ключа {align="center"} | > ||
        || **Пароль** | Секретная часть созданного API-ключа {align="center"} | > ||
        |#
    
    1. Отправьте письмо с помощью вашего почтового клиента и убедитесь, что оно пришло на указанные адреса.

- Cтатический ключ доступа {#static-key}

    1. Получите пароль, используя созданный ранее статический ключ доступа сервисного аккаунта. Для этого вызовите скрипт `generate.py`. Используйте Python не ниже версии 3.
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
        import sys
    
        # These values are required to calculate the signature. Do not change them.
        DATE = "20230926"
        SERVICE = "postbox"
        MESSAGE = "SendRawEmail"
        REGION = "ru-central1"
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
            if sys.version_info[0] < 3:
                raise Exception("Must be using Python 3")
    
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
    
    1. В настройках SMTP-сервера вашего почтового клиента укажите следующие параметры:
    
        #|
        || | **Почтовый клиент поддерживает STARTTLS** | **Почтовый клиент не поддерживает STARTTLS, но поддерживает SMTPS** ||
        || **Имя сервера** | `postbox.cloud.yandex.net` {align="center"} | > ||
        || **Порт** | `587` | `465` ||
        || **Имя пользователя** | Идентификатор созданного ранее статического ключа доступа {align="center"} | > ||
        || **Пароль** | Пароль, полученный на предыдущем шаге {align="center"} | > ||
        |#
    
    1. Отправьте письмо с помощью вашего почтового клиента и убедитесь, что оно пришло на указанные адреса.

- IAM-токен {#iam-token}

    1. В настройках вашего почтового SMTP-клиента укажите следующие параметры:
    
        #|
        || | **Почтовый клиент поддерживает STARTTLS** | **Почтовый клиент не поддерживает STARTTLS, но поддерживает SMTPS** ||
        || **Имя сервера** | `postbox.cloud.yandex.net` {align="center"} | > ||
        || **Порт** | `587` | `465` ||
        || **Имя пользователя** | `IAM_TOKEN` {align="center"} | > ||
        || **Пароль** | IAM-токен сервисного аккаунта {align="center"} | > ||
        |#
    
    1. Отправьте письмо с помощью вашего почтового клиента и убедитесь, что оно пришло на указанные адреса.

{% endlist %}

### AWS SDK {#aws-sdk}

Вы можете отправить письмо с помощью AWS SDK для .NET Core, Go, JavaScript и Python. Подробнее в руководствах:

* [Отправка писем с помощью AWS SDK для .NET Core](../tutorials/send-emails-aws-sdk-csharp.md)
* [Отправка писем с помощью AWS SDK для Go](../tutorials/send-emails-aws-sdk-go.md)
* [Отправка писем с помощью AWS SDK для JavaScript](../tutorials/send-emails-aws-sdk-js.md)
* [Отправка писем с помощью AWS SDK для Python](../tutorials/send-emails-aws-sdk-python.md)

### cURL {#curl}

Чтобы отправить письмо с помощью утилиты [cURL](https://curl.se/), выполните команду:

{% list tabs %}

- Статический ключ доступа

    ```bash
    curl \
        --request POST \
        --url 'https://postbox.cloud.yandex.net/v2/email/outbound-emails' \
        --header 'Content-Type: application/json' \
        --user "${KEY_ID}:${SECRET_KEY}" \
        --aws-sigv4 "aws:amz:ru-central1:ses" \
        --data-binary '@email.json'
    ```

- IAM-токен

    ```bash
    curl \
        --request POST \
        --url 'https://postbox.cloud.yandex.net/v2/email/outbound-emails' \
        --header 'Content-Type: application/json' \
        --header 'X-YaCloud-SubjectToken: <IAM-токен>' \
        --data '{
            "FromEmailAddress": "<отправитель>",
            "Destination": {
                "ToAddresses": ["<получатель>"]
            },
            "Content": {
                "Simple": {
                    "Subject": {
                        "Data": "<тема>"
                    },
                    "Body": {
                        "Text": {
                            "Data": "<текст письма>"
                        }
                    }
                }
            }
        }'
    ```

{% endlist %}

Тело [запроса](../aws-compatible-api/api-ref/send-email.md) можно передавать в аргументе командной строки или файле.

{% cut "Пример файла" %}

```json
{
    "FromEmailAddress": "<отправитель>",
    "Destination": {
        "ToAddresses": ["<получатель>"]
    },
    "Content": {
        "Simple": {
            "Subject": {
                "Data": "<тема>"
            },
            "Body": {
                "Text": {
                    "Data": "<текст письма>"
                }
            }
        }
    }
}
```

{% endcut %}

Чтобы использовать [AWS Signature Version 4](https://docs.amazonaws.cn/en_us/IAM/latest/UserGuide/reference_aws-signing.html) для подписи запроса, укажите параметр `--aws-sigv4`. Как формировать подпись самостоятельно, читайте в разделе [Подписывание запросов](../aws-compatible-api/signing-requests.md).
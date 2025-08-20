---
title: Отправка письма в {{ postbox-full-name }}
description: Следуя данной инструкции, вы сможете отправить письмо в {{ postbox-name }}.
---

# Отправка письма

В {{ postbox-name }} можно отправить письмо:
* с помощью [AWS CLI](#aws-cli);
* из почтового клиента по [протоколу SMTP](#smtp);
* с помощью [AWS SDK](#aws-sdk);
* с помощью утилиты [cURL](#curl).

{% include [tls](../../_includes/postbox/tls.md) %}

## Перед началом работы {#before-begin}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт в том же каталоге, в котором находится адрес. Если вы создадите сервисный аккаунт и адрес в разных каталогах, при попытке отправить письмо возникнет ошибка.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../security/index.md#postbox-sender) `postbox.sender`.
1. Создайте ключ для сервисного аккаунта:

    * [API-ключ](../../iam/operations/authentication/manage-api-keys.md#create-api-key). При создании API-ключа задайте область действия `yc.postbox.send`. Надежно сохраните полученный секретный ключ. После того как вы закроете окно, параметры секретного ключа станут недоступны.

    * [Статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key). Надежно сохраните идентификатор и секретный ключ. После того как вы закроете окно, параметры секретного ключа станут недоступны.

    * [IAM-токен](../../iam/operations/iam-token/create-for-sa.md). Этот способ авторизации подходит для отправки писем из [функций](../../functions/concepts/function.md) {{ sf-name }} и [контейнеров](../../serverless-containers/concepts/container.md) {{ serverless-containers-name }}, а также для [виртуальных машин](../../compute/concepts/vm.md) {{ compute-name }}, к которым привязан сервисный аккаунт. Выбирайте его, если не хотите создавать и хранить статические ключи доступа.

        {% note warning %}

        Учитывайте, что IAM-токен действует не больше 12 часов. Если нужно прописать данные для авторизации в конфигурационном файле почтового клиента, используйте аутентификацию по API-ключу или паролю.

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

    {% include [send-email-aws](../../_includes/postbox/send-email-aws.md) %}

{% endlist %}

### SMTP {#smtp}

{% list tabs %}

- API-ключ

    {% include [smtp-send-api](../../_includes/postbox/smtp-send-api.md) %}

- Cтатический ключ доступа

    {% include [smtp-send-python](../../_includes/postbox/smtp-send-python.md) %}

- IAM-токен

    {% include [smtp-send-iam-token](../../_includes/postbox/smtp-send-iam-token.md) %}

{% endlist %}

### AWS SDK {#aws-sdk}

Вы можете отправить письмо с помощью AWS SDK для .NET Core, Go, JavaScript и Python. Подробнее см. в руководствах:

* [{#T}](../../postbox/tutorials/send-emails-aws-sdk-csharp.md)
* [{#T}](../../postbox/tutorials/send-emails-aws-sdk-go.md)
* [{#T}](../../postbox/tutorials/send-emails-aws-sdk-js.md)
* [{#T}](../../postbox/tutorials/send-emails-aws-sdk-python.md)

### cURL {#curl}

Чтобы отправить письмо с помощью утилиты [cURL](https://curl.se/), выполните команду:

{% list tabs %}

- Статический ключ доступа

    ```bash
    curl \
        --request POST \
        --url '{{ postbox-endpoint }}/v2/email/outbound-emails' \
        --header 'Content-Type: application/json' \
        --user "${KEY_ID}:${SECRET_KEY}" \
        --aws-sigv4 "aws:amz:ru-central1:ses" \
        --data-binary '@email.json'
    ```

- IAM-токен

    ```bash
    curl \
        --request POST \
        --url '{{ postbox-endpoint }}/v2/email/outbound-emails' \
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

Тело [запроса](../../postbox/aws-compatible-api/api-ref/send-email.md) можно передавать в аргументе командной строки или файле.

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

Чтобы использовать [AWS Signature Version 4](https://docs.amazonaws.cn/en_us/IAM/latest/UserGuide/reference_aws-signing.html) для подписи запроса, укажите параметр `--aws-sigv4`. Как формировать подпись самостоятельно, см. в разделе [{#T}](../../postbox/aws-compatible-api/signing-requests.md).

[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Postbox](../index.md) > [Пошаговые инструкции](index.md) > Шаблонизация письма

# Шаблонизация письма

Чтобы отправлять письма с заполненным шаблоном, передайте шаблон и данные, которые нужно подставить в него, с помощью [AWS CLI](#aws-cli-send) или [API](../aws-compatible-api/api-ref/send-email.md).

## Перед началом работы {#before-begin}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт в том же каталоге, в котором находится адрес. Если вы создадите сервисный аккаунт и адрес в разных каталогах, при попытке отправить письмо возникнет ошибка.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../security/index.md#postbox-sender) `postbox.sender`.
1. [Создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статический ключ доступа. Надежно сохраните идентификатор и секретный ключ. После того как вы закроете окно, параметры секретного ключа станут недоступны.
1. [Настройте AWS CLI](../tools/aws-cli.md#setup).

## Отправка письма через AWS CLI {#aws-cli-send}

1. Подготовьте шаблон письма. Например, создайте файл  `message.json` со следующим содержимым:

   ```json
   {
      "FromEmailAddress": "Alice <alice@example.com>",
      "Destination": {
         "ToAddresses": [
            "bob@example.com",
            "Charlie <charlie@example.com>"
         ]
      },
      "Content": {
         "Template": {
            "Headers": [
               {
                  "Name": "List-Unsubscribe",
                  "Value": "<https://example.com/unsubscribe?user_id=sercet_hash>"
               },
               {
                  "Name": "List-Unsubscribe-Post",
                  "Value": "List-Unsubscribe=One-Click"
               }
            ],
            "TemplateContent": {
               "Subject": "Greetings, {{name}}!",
               "Text": "Dear {{name}},\r\nYour favorite animal is {{favoriteanimal}}.",
               "Html": "<h1>Hello {{name}},</h1><p>Your favorite animal is {{favoriteanimal}}.</p>"
            },
            "TemplateData": "{ \"name\":\"Bob\", \"favoriteanimal\": \"bobcat\" }"
         }
      },
      "ConfigurationSetName": "ConfigSet"
   }
   ```

1. Чтобы отправить письмо, выполните команду:

   ```bash
   aws sesv2 send-email --cli-input-json file://message.json \
     --endpoint-url https://postbox.cloud.yandex.net
   ```

   {% note info %}

   В шаблоне используется синтаксис [Handlebars](https://handlebarsjs.com/guide/). При передаче шаблона в запросе можно использовать только простые подстановки. Циклы, условия и другие конструкции не поддерживаются.

   {% endnote %}
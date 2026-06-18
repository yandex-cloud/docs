# Массовая отправка писем

С помощью метода `SendBulkEmail` можно отправить несколько шаблонных писем одним запросом. В запросе передается общий шаблон и набор писем к отправке. Для каждого письма можно указать адресатов, данные для подстановки в шаблон, заголовки и метки.

## Перед началом работы {#before-begin}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт в том же каталоге, в котором находится адрес. Если вы создадите сервисный аккаунт и адрес в разных каталогах, при попытке отправить письмо возникнет ошибка.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../security/index.md#postbox-sender) `postbox.sender`.
1. [Создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статический ключ доступа. Надежно сохраните идентификатор и секретный ключ. После того как вы закроете окно, параметры секретного ключа станут недоступны.
1. [Настройте AWS CLI](../tools/aws-cli.md#setup).

## Отправить письма {#send-bulk-email}

1. Подготовьте файл `bulk-email.json`:

   ```json
   {
      "FromEmailAddress": "Alice <alice@example.com>",
      "DefaultContent": {
         "Template": {
            "Headers": [
               {
                  "Name": "List-Unsubscribe",
                  "Value": "<https://example.com/unsubscribe?user_id=sercet_hash>"
               }
            ],
            "TemplateContent": {
               "Subject": "Hello, {{name}}!",
               "Text": "Dear {{name}},\r\nYour order {{order_id}} is ready.",
               "Html": "<h1>Hello, {{name}}!</h1><p>Your order {{order_id}} is ready.</p>"
            },
            "TemplateData": "{\"order_id\":\"0000\"}"
         }
      },
      "BulkEmailEntries": [
         {
            "Destination": {
               "ToAddresses": [
                  "bob@example.com"
               ]
            },
            "ReplacementEmailContent": {
               "ReplacementTemplate": {
                  "ReplacementTemplateData": "{\"name\":\"Bob\",\"order_id\":\"1234\"}"
               }
            },
            "ReplacementHeaders": [
               {
                  "Name": "X-Customer-Segment",
                  "Value": "new"
               }
            ],
            "ReplacementTags": [
               {
                  "Name": "customer",
                  "Value": "bob"
               }
            ]
         },
         {
            "Destination": {
               "ToAddresses": [
                  "charlie@example.com"
               ]
            },
            "ReplacementEmailContent": {
               "ReplacementTemplate": {
                  "ReplacementTemplateData": "{\"name\":\"Charlie\",\"order_id\":\"5678\"}"
               }
            }
         }
      ],
      "DefaultEmailTags": [
         {
            "Name": "campaign",
            "Value": "orders"
         }
      ],
      "ConfigurationSetName": "ConfigSet"
   }
   ```

   Где:

   * `FromEmailAddress` — верифицированный адрес отправителя.
   * `DefaultContent.Template.TemplateContent` — общий шаблон темы и тела письма.
   * `DefaultContent.Template.TemplateData` — данные по умолчанию для заполнения шаблона. Значение должно быть JSON-объектом, сериализованным в строку.
   * `BulkEmailEntries` — список писем к отправке. Для каждого элемента списка можно указать `ReplacementTemplateData`, чтобы переопределить данные шаблона для конкретного письма.
   * `DefaultEmailTags` и `ReplacementTags` — метки письма. Метки из `ReplacementTags` дополняют или переопределяют метки из `DefaultEmailTags`.

   {% note info %}

   В шаблоне используется синтаксис [Handlebars](https://handlebarsjs.com/guide/) с простыми подстановками.

   {% endnote %}

1. Отправьте письма:

   ```bash
   aws sesv2 send-bulk-email \
     --cli-input-json file://bulk-email.json \
     --endpoint-url https://postbox.cloud.yandex.net
   ```

   Результат:

   ```json
   {
      "BulkEmailEntryResults": [
         {
            "Status": "SUCCESS",
            "MessageId": "<идентификатор_письма>"
         },
         {
            "Status": "SUCCESS",
            "MessageId": "<идентификатор_письма>"
         }
      ]
   }
   ```

   Порядок элементов в `BulkEmailEntryResults` соответствует порядку элементов в `BulkEmailEntries`. Если отдельное письмо не принято, в соответствующем элементе результата вернется статус ошибки и описание в поле `Error`.

#### См. также {#see-also}

* [Метод SendBulkEmail](../aws-compatible-api/api-ref/send-bulk-email.md)
* [Шаблонизация письма](send-templated-email.md)
---
title: Массовая отправка писем в {{ postbox-full-name }}
description: Следуя данной инструкции, вы сможете отправить несколько шаблонных писем одним запросом в {{ postbox-name }}.
---

# Массовая отправка писем

С помощью метода `SendBulkEmail` можно отправить несколько шаблонных писем одним запросом. В запросе передается общий шаблон и набор писем к отправке. Для каждого письма можно указать адресатов, данные для подстановки в шаблон, заголовки и метки.

{% include [before-begin](../../_includes/postbox/before-begin.md) %}

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
               "Subject": "Hello, not_var{{name}}!",
               "Text": "Dear not_var{{name}},\r\nYour order not_var{{order_id}} is ready.",
               "Html": "<h1>Hello, not_var{{name}}!</h1><p>Your order not_var{{order_id}} is ready.</p>"
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
     --endpoint-url {{ postbox-endpoint }}
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

#### Полезные ссылки {#see-also}

* [{#T}](../aws-compatible-api/api-ref/send-bulk-email.md)
* [{#T}](send-templated-email.md)

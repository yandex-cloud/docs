---
title: Bulk email sending in {{ postbox-full-name }}
description: Follow this guide to send multiple template emails in one request in {{ postbox-name }}.
---

# Bulk email sending

Using the `SendBulkEmail` method, you can send multiple template emails in one request. The request contains a shared template and emails to send. For each email, you can specify recipients, data to populate the template, headers, and tags.

{% include [before-begin](../../_includes/postbox/before-begin.md) %}

## Sending emails {#send-bulk-email}

1. Prepare a `bulk-email.json` file:

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

   Where:

   * `FromEmailAddress`: Sender's verified email address.
   * `DefaultContent.Template.TemplateContent`: Shared template for the email subject and body.
   * `DefaultContent.Template.TemplateData`: Default data to populate the template. The value must be a JSON object serialized to a string.
   * `BulkEmailEntries`: List of emails to send. For each list item, you can specify `ReplacementTemplateData` to override the template data for that specific email.
   * `DefaultEmailTags` and `ReplacementTags`: Email tags. Tags from `ReplacementTags` complement or override those from `DefaultEmailTags`.

   {% note info %}

   Template uses the [Handlebars](https://handlebarsjs.com/guide/) syntax and supports simple substitutions.

   {% endnote %}

1. Send emails:

   ```bash
   aws sesv2 send-bulk-email \
     --cli-input-json file://bulk-email.json \
     --endpoint-url {{ postbox-endpoint }}
   ```

   Result:

   ```json
   {
      "BulkEmailEntryResults": [
         {
            "Status": "SUCCESS",
            "MessageId": "<email_ID>"
         },
         {
            "Status": "SUCCESS",
            "MessageId": "<email_ID>"
         }
      ]
   }
   ```

   The item order in `BulkEmailEntryResults` matches that in `BulkEmailEntries`. Where an individual email is not delivered, the returned result contains the error status and description in the `Error` field of the corresponding item.

#### Useful links {#see-also}

* [{#T}](../aws-compatible-api/api-ref/send-bulk-email.md)
* [{#T}](send-templated-email.md)

---
title: Templating an email in {{ postbox-full-name }}
description: Follow this guide to send an email from {{ postbox-name }} using a template.
---

# Templating an email

To send emails using a populated template, submit both the template and data to insert via the [AWS CLI](#aws-cli-send) or [API](../aws-compatible-api/api-ref/send-email.md).

## Getting started {#before-begin}

1. [Create](../../iam/operations/sa/create.md) a service account in the folder as the address. If you create the service account and address in different folders, you will get an error when attempting to send an email.
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `postbox.sender` [role](../security/index.md#postbox-sender) to the service account.
1. [Create](../../iam/operations/authentication/manage-access-keys.md#create-access-key) a static access key. Save the ID and secret key to a secure location. You will not be able to view the secret key parameters again after you close the window.

## Sending an email via the AWS CLI {#aws-cli-send}

1. Prepare an email template. For example, create a file named `message.json` with the following contents:

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
               "Subject": "Greetings, not_var{{name}}!",
               "Text": "Dear not_var{{name}},\r\nYour favorite animal is not_var{{favoriteanimal}}.",
               "Html": "<h1>Hello not_var{{name}},</h1><p>Your favorite animal is not_var{{favoriteanimal}}.</p>"
            },
            "TemplateData": "{ \"name\":\"Bob\", \"favoriteanimal\": \"bobcat\" }"
         }
      },
      "ConfigurationSetName": "ConfigSet"
   }
   ```

1. To send an email, run this command:

   ```bash
   aws sesv2 send-email --cli-input-json file://message.json \
     --endpoint-url {{ postbox-endpoint }}
   ```

   {% note info %}

   Template use the [Handlebars](https://handlebarsjs.com/guide/) syntax. When providing a template in a request, you can only use simple subsitutions. Loops, conditions, and other structures are not supported.

   {% endnote %}

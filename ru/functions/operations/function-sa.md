---
title: Получение IAM-токена сервисного аккаунта с помощью функции
description: Следуя данной инструкции, вы сможете получить IAM-токен сервисного аккаунта с помощью функции.
---

# Получение IAM-токена сервисного аккаунта с помощью функции

Если версия функции создана с сервисным аккаунтом, вы можете получить для него IAM-токен из:

* [контекста](../concepts/function.md#model-desc) обработчика. IAM-токен находится в поле `access_token` параметра `context`.
* сервиса метаданных в формате [Google Compute Engine](../../compute/operations/vm-info/get-info.md#inside-instance) с помощью API.

Чтобы получить IAM-токен:

1. [Создайте](../operations/function/function-create.md) функцию. При создании первой версии функции выберите [среду выполнения](../concepts/runtime/index.md) Node.js или Python.
1. Отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** выберите **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}**.
1. Подготовьте ZIP-архив с кодом функции:

   {% list tabs group=programming_language %}

    - Node.js {#node}

        1. Сохраните следующий код в файл с названием `index.js`, чтобы получить IAM-токен:

           * из контекста обработчика:

             ```js
             exports.main = async function (event, context) {
                 return {
                     'statusCode': 200,
                     'headers': {
                         'Content-Type': 'text/plain'
                     },
                     'isBase64Encoded': false,
                     'body': context.token
                 }
             };
             ```

           * с помощью API:

             ```js
             const fetch = require("node-fetch");
             let url = 'http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token';
             let headers = {'Metadata-Flavor': 'Google'};

             exports.main = async function (event) {
                 const resp = await fetch(url, {
                     headers: headers,
                 });
                 return {
                     code: resp.status,
                     body: await resp.text()
                 };
             };
             ```

        1. Если будете получать IAM-токен с помощью API, сохраните следующий код в файл с названием `package.json`:

           ```json
           {
               "name": "my-app",
               "dependencies": {
                   "node-fetch": "2.x"
               }
           }
           ```

        1. Добавьте файл `index.js` и, если будете получать IAM-токен с помощью API, файл `package.json` в ZIP-архив `index-js.zip`.

        1. Нажмите **Прикрепить файл** и выберите подготовленный ZIP-архив `index-js.zip`.

    - Python {#python}

        1. Сохраните следующий код в файл с названием `index.py`, чтобы получить IAM-токен:

           * из контекста обработчика:

               ```py
               def main(event, context):

                   return {
                       'statusCode': 200,
                       'headers': {
                           'Content-Type': 'text/plain'
                       },
                       'isBase64Encoded': False,
                       'body': context.token
                   }
               ```

           * с помощью API:

               ```py
               import requests
               url = 'http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token'
               headers = {'Metadata-Flavor': 'Google'}
               def main(event, context):
                   resp = requests.get(url, headers=headers)
                   return {
                       'statusCode': 200,
                       'headers': {
                           'Content-Type': 'text/plain'
                       },
                       'isBase64Encoded': False,
                       'body': resp.content.decode('UTF-8')
                   }
               ```

     1. Добавьте файл `index.py` в ZIP-архив `index-py.zip`.

     1. Нажмите **Прикрепить файл** и выберите подготовленный ZIP-архив `index-py.zip`.

   {% endlist %}

1. [Создайте](../operations/function/version-manage.md) версию функции.

   1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** укажите `index.main`.

   1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** выберите сервисный аккаунт, для которого нужно получить IAM-токен, или создайте новый.

1. [Выполните](../operations/function/function-invoke.md) функцию.

   В случае успешного выполнения функции вы получите следующий ответ:

   ```json
   {
       "statusCode": 200,
       "headers": {"Content-Type": "text/plain"},
       "isBase64Encoded": false,
       "body":
       {
           "access_token": "t1.9euelZrPm5O********",
           "expires_in": 43200,
           "token_type": "Bearer"
       }
   }
   ```

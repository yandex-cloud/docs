---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Получение IAM-токена сервисного аккаунта с помощью функции

Если версия функции создана с сервисным аккаунтом, вы можете получить для него IAM-токен из: 

* [контекста](../concepts/function.md#model-desc) обработчика. IAM-токен находится в поле `access_token` параметра `context`.
* сервиса метаданных в формате [Google Compute Engine](../../compute/operations/vm-info/get-info.md#gce-metadata) с помощью API.

Чтобы получить IAM-токен:

1. [Создайте](../operations/function/function-create.md) функцию.

1. Выберите язык программирования и создайте версию функции:

     {% list tabs %}

     - Node.js
        1. Сохраните следующий код в файл с названием `index.js`, чтобы получить IAM-токен:      
            * из контекста обработчика.
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
            * с помощью API.
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
        1. Добавьте файл  `index.js` в ZIP-архив `index-js.zip`.
        1. [Создайте](../operations/function/version-manage.md#version-create) версию функции. Укажите:
            * среду выполнения `nodejs12`;
            * сервисный аккаунт, для которого нужно получить IAM-токен;
            * точку входа `index.main`.

    - Python
        1. Сохраните следующий код в файл с названием `index.py`, чтобы получить IAM-токен:      
            * из контекста обработчика.
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
            * с помощью API.
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
        1. Добавьте файл  `index.py` в ZIP-архив `index-py.zip`.
        1. [Создайте](../operations/function/version-manage.md#version-create) версию функции. Укажите:
            * среду выполнения `python37`;
            * сервисный аккаунт, для которого нужно получить IAM-токен;
            * точку входа `index.main`.

    {% endlist %}

1. [Выполните](../operations/function/function-invoke.md) функцию.

    Ответ функции будет выглядеть следующим образом:

    ```json
    {
        "access_token": "CggVAgAAABoBMRKABHGgpZ......",
        "expires_in": 42299,
        "token_type": "Bearer"
    }
    ```
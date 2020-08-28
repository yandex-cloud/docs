# Получение IAM-токена сервисного аккаунта с помощью функции

Если версия функции была создана с сервисным аккаунтом, вы можете получить для него IAM-токен: 
- [Из контекста при вызове функции](#context).
- [Из метаданных ВМ с помощью API](#api).

## Получить IAM-токен из контекста {#context} 

Если вы создаете функцию в среде выполнения, поддерживаемой {{ sf-name }}, то вы можете получить IAM-токен из [контекста](../concepts/function.md#model-desc) обработчика, который является вторым параметром — `context`.

Чтобы получить IAM-токен, добавьте в код функции строку `token: context.token` и вызовите ее: 
1. Сохраните следующий код в файл с названием `index.js`:
    
    ```
    exports.handler = async function (event, context) {
        return {
            token: context.token,
            event: event
        };
    };
    ```
1. [Создайте версию функции](../operations/function/version-manage.md#version-create), используя файл `index.js`.
1. [Выполните функцию](../operations/function/function-invoke.md) с указанием параметра строки запроса [integration=raw](../concepts/function-invoke).

    Ответ функции будет выглядеть следующим образом:

    ```json
    {
      "token": {
        "access_token": "CggVAgAAABoBMRKABHGgpZ......",
        "expires_in": 42299,
        "token_type": "Bearer"
      }
    }
    ```    
    
    IAM-токен будет указан в ответе в поле `access_token`. Оставшееся время жизни IAM-токена указано в поле `expires_in`.

## Получить IAM-токен с помощью API {#api}

Если вы работаете с {{ yandex-cloud }} изнутри ВМ, вы можете получить IAM-токен из сервиса метаданных в [формате Google Compute Engine](../../compute/operations/vm-info/get-info.md#gce-metadata), а также добавить эту логику в свою функцию. Подробнее об этом читайте в разделе [Работа с {{ yandex-cloud }} изнутри ВМ](../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm).

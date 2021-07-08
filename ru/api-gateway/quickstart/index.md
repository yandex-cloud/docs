---
title: "Начало работы с Yandex API Gateway (API шлюзами)"
description: "В этой инструкции вы создадите и протестируете работу разных типов расширений. Сначала вы сконфигурируете API-шлюз для получения статического ответа, а затем добавите интеграцию для вызова функции."
---

# Начало работы 

В этой инструкции вы создадите и протестируете работу разных типов расширений: сначала вы сконфигурируете API-шлюз для получения [статического ответа](../concepts/extensions/dummy.md), а затем добавите интеграцию для [вызова функции](../concepts/extensions/cloud-functions.md).

## Перед началом работы {#before-you-begin}

Чтобы начать работать в {{ yandex-cloud }}:
1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../../resource-manager/operations/folder/create.md).

## Создайте API-шлюз {#create-api-gw}

Создайте API-шлюз и обратитесь к нему.

{% list tabs %}

- Консоль управления

    Чтобы создать API-шлюз:
    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором необходимо создать API-шлюз.
    1. В списке сервисов выберите **{{ api-gw-name }}**.
    1. Нажмите кнопку **Создать API-шлюз**.
    1. В поле **Имя** введите `numbers`.
    1. (опционально) В поле **Описание** введите описание.
    1. В блок **Спецификация** добавьте спецификацию:
    
        ```
        openapi: "3.0.0"
        info:
          version: 1.0.0
          title: Test API
        paths:
          /hello:
            get:
              summary: Say hello
              operationId: hello
              parameters:
                - name: user
                  in: query
                  description: User name to appear in greetings
                  required: false
                  schema:
                    type: string
                    default: 'world'
              responses:
                '200':
                  description: Greeting
                  content:
                    'text/plain':
                       schema:
                         type: "string"
              x-yc-apigateway-integration:
                type: dummy
                http_code: 200
                http_headers:
                  'Content-Type': "text/plain"
                content:
                  'text/plain': "Hello, {user}!\n"
        ```
    1. Нажмите кнопку **Создать**.
    1. Обратитесь к API-шлюзу.
        1. В открывшемся окне нажмите на созданный API-шлюз.
        1. Скопируйте значение поля **Домен** и сформируйте ссылку вида: `https://<домен>/hello?user=API`. Должна получиться ссылка вида: 
        
            ```
            https://falrnjna8r5vj88ero6a.apigw.yandexcloud.net/hello?user=API
            ```
        1. Обратитесь к API-шлюзу, используя одну из команд: 
            
            ```
            curl https://falrnjna8r5vj88ero6a.apigw.yandexcloud.net/hello?user=API
            curl https://falrnjna8r5vj88ero6a.apigw.yandexcloud.net/hello
            ```

{% endlist %}

## Добавьте интеграцию с функцией {#functions}

### Создайте функцию {#function}

Создайте функцию для получения списка чисел. Подробнее о функциях читайте в документации [{{ sf-name }}](../../functions/).

{% list tabs %}

- Консоль управления

    Чтобы создать функцию:
    1. Создайте функцию: 
        1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана функция.
        1. Нажмите кнопку **Создать ресурс**.
        1. Выберите **Функция**.
        1. В поле **Имя** введите `list`.
        1. Нажмите кнопку **Создать**.
        1. [Сделайте](../../functions/operations/function-public.md#public) функцию публичной.
    1. Создайте версию функции: 
        1. В открывшемся окне выберите созданную функцию.
        1. В разделе **Последняя версия** нажмите кнопку **Создать в редакторе**.
        1. В открывшемся окне в поле **Среда выполнения** выберите `nodejs12`.
        1. В поле **Способ** выберите редактор кода.
        1. Ниже в редакторе нажмите кнопку **Создать файл**.
            1. В открывшемся окне введите имя файла `index.js`.
            1. Нажмите кнопку **Создать**.
        1. Вставьте следующий код в файл `index.js`:
            
            ```
            module.exports.handler = async (event) => {
                return {
                    "statusCode": 200,
                    "headers": {"content-type": "application/json"},
                    "body": "[0, 1, 2]"
                };
            };
            ```
        1. В поле **Точка входа** введите `index.handler`.
        1. Нажмите кнопку **Создать версию**.

{% endlist %}

### Расширьте спецификацию API-шлюза {#update}

Добавьте в спецификацию API-шлюза информацию о функции.

{% list tabs %}

- Консоль управления

    Чтобы обновить спецификацию API-шлюза:
    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором необходимо обновить API-шлюз.
    1. В открывшемся окне выберите API-шлюз и нажмите кнопку ![image](../../_assets/options.svg).
    1. В открывшемся меню нажмите кнопку **Редактировать**.
    1. В блок **Спецификация** добавьте расширенную версию спецификации
        
        Добавлен метод `/numbers`, который с помощью расширения `x-yc-apigateway-integration` типа `cloud_functions` вызывает функцию по идентификатору. 
        
        Чтобы API-шлюз корректно отработал, в параметре `function_id` укажите идентификатор функции, которую хотите вызывать.

        Чтобы API-шлюз смог обратиться к приватной функции, в параметре `service_account_id` укажите сервисный аккаунт с правами на вызов функции.
        
        ```
        openapi: "3.0.0"
        info:
          version: 1.0.0
          title: Test API
        paths:
          /hello:
            get:
              summary: Say hello
              operationId: hello
              parameters:
                - name: user
                  in: query
                  description: User name to appear in greetings
                  required: false
                  schema:
                    type: string
                    default: 'world'
              responses:
                '200':
                  description: Greeting
                  content:
                    'text/plain':
                       schema:
                         type: "string"
              x-yc-apigateway-integration:
                type: dummy
                http_code: 200
                http_headers:
                  'Content-Type': "text/plain"
                content:
                  'text/plain': "Hello, {user}!\n"
          /numbers:
            get:
              summary: List some numbers
              operationId: listNumbers
              responses:
                '200':
                  description: Another example
                  content:
                    'application/json':
                       schema:
                         type: "array"
                         items:
                           type: "integer"
              x-yc-apigateway-integration:
                type: cloud_functions
                function_id: <ID функции>
                service_account_id: <ID сервисного аккаунта>
        ```
   
{% endlist %}

### Обратитесь к функции через API-шлюз {#api-gw}

{% note info %}

Чтобы API-шлюз смог обратиться к функции, [сделайте](../../functions/operations/function-public.md#public) ее публичной или [укажите](../concepts/extensions/cloud-functions.md) в спецификации сервисный аккаунт, у которого есть права на вызов функции.

{% endnote %}

Обратитесь к API-шлюзу:

```
curl https://falrnjna8r5vj88ero6a.apigw.yandexcloud.net/numbers
[0, 1, 2]
```

#### См. также {#see-also}

* [Концепции работы с сервисом](../concepts/index.md).
* [Пошаговые инструкции для управления API-шлюзом](../operations/index.md).

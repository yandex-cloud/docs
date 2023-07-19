---
title: "Начало работы с {{ api-gw-full-name }} (API шлюзами)"
description: "В этой инструкции вы создадите и протестируете работу разных типов расширений. Сначала вы сконфигурируете API-шлюз для получения статического ответа, а затем добавите интеграцию для вызова функции."
---

# Начало работы с {{ api-gw-name }}

В этой инструкции вы создадите и протестируете работу разных типов расширений: сначала вы сконфигурируете API-шлюз для получения [статического ответа](../concepts/extensions/dummy.md), а затем добавите интеграцию для [вызова функции](../concepts/extensions/cloud-functions.md).

## Перед началом работы {#before-you-begin}

Чтобы начать работать в {{ yandex-cloud }}:
1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**Биллинг**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../../resource-manager/operations/folder/create.md).

## Создайте API-шлюз {#create-api-gw}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором необходимо создать API-шлюз.
  1. В списке сервисов выберите **{{ api-gw-name }}**.
  1. Нажмите кнопку **Создать API-шлюз**.
  1. В поле **Имя** введите `numbers`.
  1. (Опционально) В поле **Описание** введите описание.
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

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% include [terraform-create](../../_includes/api-gateway/terraform-create.md) %}

{% endlist %}

## Обратитесь к API-шлюзу {#api-gw-test}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится API-шлюз.
1. В списке сервисов выберите **{{ api-gw-name }}** и нажмите на созданный API-шлюз.
1. Скопируйте значение поля **Домен** и сформируйте ссылку вида: `https://<домен>/hello?user=API`. Должна получиться ссылка вида: 

    ```
    https://falrnjna8r5vj88ero6a.apigw.yandexcloud.net/hello?user=API
    ```

1. Обратитесь к API-шлюзу с помощью [curl](https://curl.haxx.se), используя одну из команд: 
    
    ```bash
    curl https://falrnjna8r5vj88ero6a.apigw.yandexcloud.net/hello?user=API
    curl https://falrnjna8r5vj88ero6a.apigw.yandexcloud.net/hello
    ```

    Результат:
    
    ```
    Hello, API!
    Hello, world!
    ```

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
        1. [Сделайте](../../functions/operations/function/function-public.md) функцию публичной.
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

- {{ TF }}

  Чтобы создать функцию:

  1. Подготовьте ZIP-архив с кодом функции:
      1. Сохраните следующий код в файл с названием index.js:
        
          ```js
          module.exports.handler = async (event) => {
              return {
                  "statusCode": 200,
                  "headers": {"content-type": "application/json"},
                  "body": "[0, 1, 2]"
              };
          };
          ```

      1. Добавьте файл `index.js` в ZIP-архив `hello-js.zip`.

  1. Опишите в конфигурационном файле параметры ресурса `yandex_function`:

     ```hcl
     resource "yandex_function" "test-function" {
       name               = "test-function"
       description        = "Test function"
       user_hash          = "first-function"
       runtime            = "nodejs12"
       entrypoint         = "index.handler"
       memory             = "128"
       execution_timeout  = "10"
       service_account_id = "<идентификатор сервисного аккаунта>"
       tags               = ["my_tag"]
       content {
         zip_filename = "<путь к ZIP-архиву>"
       }
     }
     ```

     Где:

     * `name` — имя функции.
     * `description` — текстовое описание функции.
     * `user_hash` — произвольная строка, определяющая версию функции. При изменениях функции необходимо менять и эту строку. Функция обновится при изменении этой строки.
     * `runtime` — [среда выполнения](../../functions/concepts/runtime/index.md) функции.
     * `entrypoint` — имя функции в исходном коде, которая будет служить точкой входа в приложения.
     * `memory` — объем памяти в мегабайтах, отведенный для выполнения функции.
     * `execution_timeout` — таймаут выполнения функции.
     * `service_account_id` — идентификатор сервисного аккаунта, от имени которого будет запускаться функция.
     * `tags` — теги функции.
     * `content` — исходный код функции.
     * `content.0.zip_filename` — путь к ZIP-архиву, содержащему исходный код функции.

     Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера]({{ tf-provider-resources-link }}/function).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команд [CLI](../../cli/quickstart.md):

        ```
        yc serverless function list
        ```

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

- {{ TF }}

  Чтобы добавить в спецификацию API-шлюза информацию о функции:

  1. Откройте файл конфигурации {{ TF }} и добавьте метод `/numbers`, который с помощью расширения `x-yc-apigateway-integration` типа `cloud_functions` вызывает функцию по идентификатору. В блок `spec` измените спецификацию api-шлюза, указав следующие параметры:

     * `function_id` — идентификатор функции.
     * `service_account_id` — идентификатор сервисного аккаунта с правами на вызов функции.

     Расширенная спецификация api-шлюза:

     ```hcl
     ...

       spec = <<-EOT
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
                   'text/plain': "Hello again, {user}!\n"
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
                 function_id: <идентификатор функции>
                 service_account_id: <идентификатор сервисного аккаунта>
       EOT
     }
     ```

     Более подробную информацию о параметрах ресурсов в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/api_gateway).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команд [CLI](../../cli/quickstart.md):

        ```
        yc serverless api-gateway get <имя API-шлюза>
        ```

{% endlist %}

### Обратитесь к функции через API-шлюз {#api-gw}

{% note info %}

Чтобы API-шлюз смог обратиться к функции, [сделайте](../../functions/operations/function/function-public.md) ее публичной или [укажите](../concepts/extensions/cloud-functions.md) в спецификации сервисный аккаунт, у которого есть права на вызов функции.

{% endnote %}

Обратитесь к API-шлюзу:

```bash
curl https://falrnjna8r5vj88ero6a.apigw.yandexcloud.net/numbers
```

Результат:

```
[0, 1, 2]
```

#### См. также {#see-also}

* [Концепции работы с сервисом](../concepts/index.md).
* [Пошаговые инструкции для управления API-шлюзом](../operations/index.md).

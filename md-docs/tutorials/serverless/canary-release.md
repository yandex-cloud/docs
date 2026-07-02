[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Бессерверные технологии](index.md) > Бэкенд на Serverless > Канареечный релиз функции Cloud Functions

# Канареечный релиз функции Cloud Functions


Создайте канареечный релиз функции Cloud Functions с помощью API Gateway.

Чтобы создать канареечный релиз:
1. [Подготовьте облако к работе](#before-begin).
1. [Создайте сервисный аккаунт](#create-account).
1. [Создайте функцию Cloud Functions](#create-functions).
1. [Добавьте теги](#add-tag).
1. [Создайте API-шлюз](#create-api-gw).
1. [Протестируйте приложение](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов поддержки веб-приложения входят:
* Плата за количество запросов к API-шлюзу и исходящий трафик ([тарифы Yandex API Gateway](../../api-gateway/pricing.md)).
* Плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик ([тарифы Yandex Cloud Functions](../../functions/pricing.md)).

## Создайте сервисный аккаунт {#create-account}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать сервисный аккаунт.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Введите имя сервисного аккаунта: `canary-sa`.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль `editor`.
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте сервисный аккаунт `canary-sa`:

      ```bash
      yc iam service-account create --name canary-sa
      ```

      Результат:

      ```
      id: nfersamh4sjq********
      folder_id: b1gc1t4cb638********
      created_at: "2023-09-21T10:36:29.726397755Z"
      name: canary-sa
      ```

      Сохраните идентификатор сервисного аккаунта `canary-sa` (`id`) и каталога, в котором его создали (`folder_id`).

  1. Назначьте сервисному аккаунту роль `editor` на каталог:

      ```bash
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role editor \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Результат:

      ```
      done (1s)
      ```

- Terraform {#tf}

  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../infrastructure-management/terraform-quickstart.md#install-terraform).


  1. Опишите в конфигурационном файле параметры сервисного аккаунта:

      ```hcl
      resource "yandex_iam_service_account" "canary-sa" {
        name        = "canary-sa"
        folder_id   = "<идентификатор_каталога>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "editor" {
        folder_id = "<идентификатор_каталога>"
        role      = "editor"
        member    = "serviceAccount:${yandex_iam_service_account.canary-sa id}"
      }
      ```

      Где:

      * `name` — имя сервисного аккаунта. Обязательный параметр.
      * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md). Необязательный параметр. По умолчанию будет использовано значение, указанное в настройках провайдера.
      * `role` — назначаемая роль.

      Подробнее о параметрах ресурса `yandex_iam_service_account` в Terraform смотрите в [документации провайдера](../../terraform/resources/iam_service_account.md).

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
      1. Выполните проверку с помощью команды:

         ```bash
         terraform plan
         ```

      Если конфигурация описана верно, в терминале отобразится информация о сервисном аккаунте. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Разверните облачные ресурсы.

      1. Если в конфигурации нет ошибок, выполните команду:

           ```bash
           terraform apply
           ```

      1. Подтвердите создание сервисного аккаунта: введите в терминал слово `yes` и нажмите **Enter**.

           После этого будет создан сервисный аккаунт. Проверить появление сервисного аккаунта можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

           ```bash
           yc iam service-account list
           ```

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

  Чтобы назначить сервисному аккаунту роль `editor` на каталог, воспользуйтесь методом [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

{% endlist %}

## Создайте функцию Cloud Functions {#create-functions}

[Создайте две версии функции](../../functions/operations/index.md#create-function):
* версию для текущего релиза;
* версию для канареечного релиза, которая будет тестироваться на некоторой доле запросов.

Вы можете использовать собственную функцию или создать [любую функцию из списка](../../functions/quickstart/create-function/index.md).

## Добавьте теги {#add-tag}

Первой версии функции добавьте тег `stable`, второй — `canary`.

{% list tabs group=instructions %}

- CLI {#cli}

    Чтобы добавить тег версии, выполните команду:

    ```
    yc serverless function version set-tag --id <идентификатор_версии> --tag <тег>
    ```

    Результат:

    ```
    id: b09ch6pmpohf********
    function_id: b097d9ous3ge********
    created_at: "2023-08-22T09:12:38.464Z"
    runtime: python311
    entrypoint: test.handler
    resources:
      memory: "134217728"
    execution_timeout: 5s
    image_size: "4096"
    status: ACTIVE
    tags:
      - $latest
      - stable
    ```

- Terraform {#tf}

    Чтобы добавить тег версии:

    1. В конфигурационном файле добавьте блок `tags` для ресурса `yandex_function` и укажите список тегов формате `tags = ["<имя_тега>"]`.

       Пример описания функции в конфигурации Terraform:
      
        ```
        resource "yandex_function" "test-function" {
            name               = "canary-function"
            user_hash          = "canary-function"
            runtime            = "python311"
            entrypoint         = "main"
            memory             = "128"
            execution_timeout  = "10"
            service_account_id = "<идентификатор_сервисного_аккаунта>"
            tags               = ["my_tag"]
            content {
                zip_filename = "<путь_к_ZIP-архиву>"
            }
        }
        ``` 

        Подробнее о параметрах ресурса `yandex_function` смотрите в [документации провайдера](../../terraform/resources/function.md).

    1. Проверьте конфигурацию командой:
        
       ```
       terraform validate
       ```

       Если конфигурация является корректной, появится сообщение:
        
       ```
       Success! The configuration is valid.
       ```

    1. Выполните команду:

       ```
       terraform plan
       ```
        
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет. 
         
    1. Примените изменения конфигурации:

       ```
       terraform apply
       ```
    1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.
      
    Проверить, что теги появились, можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

    ```
    yc serverless function version list --function-name <имя_функции>
    ```

- API {#api}

    Чтобы добавить тег версии функции, воспользуйтесь методом REST API [setTag](../../functions/functions/api-ref/Function/setTag.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/SetTag](../../functions/functions/api-ref/grpc/Function/setTag.md).

{% endlist %}

## Создайте API-шлюз {#create-api-gw}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать API-шлюз.
    1. Перейдите в сервис **API Gateway**.
    1. Нажмите кнопку **Создать API-шлюз**.
    1. В поле **Имя** введите `canary`.
    1. В блок **Спецификация** добавьте спецификацию:
    
        ```yaml
        openapi: 3.0.0
        info:
          title: Sample API
          version: 1.0.0

        x-yc-apigateway:
          variables:
            function.tag:
              default: "stable"
              enum:
                - "stable"
                - "canary"

        paths:
          /:
            get:
              x-yc-apigateway-integration:
                type: cloud_functions
                function_id: <идентификатор_функции>
                tag: "${var.function.tag}"
                service_account_id: <идентификатор_сервисного_аккаунта>
        ```
    1. В разделе **Управление переменными** активируйте переключатель **Канареечный релиз**.
    1. В поле **Доля запросов в канареечном релизе** укажите `50`.
    1. В поле **Переменные для канареечного релиза** укажите `function.tag`=`canary`.
    1. Нажмите кнопку **Создать**.
    
- CLI {#cli}

    1. Сохраните следующую спецификацию в файл `spec.yaml`:
        
        ```yaml
        openapi: 3.0.0
        info:
          title: Sample API
          version: 1.0.0

        x-yc-apigateway:
          variables:
            function.tag:
              default: "stable"
              enum:
                - "stable"
                - "canary"

        paths:
          /:
            get:
              x-yc-apigateway-integration:
                type: cloud_functions
                function_id: <идентификатор_функции>
                tag: "${var.function.tag}"
                service_account_id: <идентификатор_сервисного_аккаунта>
        ```
    1. Выполните команду:

        ```bash
        yc serverless api-gateway create --name canary --spec=spec.yaml --canary-weight=50 --canary-variables function.tag=canary
        ```

        Где:
       
        * `--name` — имя API-шлюза.
        * `--spec` — файл со спецификацией.
        * `--canary-weight` — доля запросов в канареечном релизе.
        * `--canary-variables` — переменные для канареечного релиза.

        Результат:

        ```text
        done (5s)
        id: d5d1ud9bli1e********
        folder_id: b1gc1t4cb638********
        created_at: "2023-09-25T16:01:48.926Z"
        name: canary
        status: ACTIVE
        domain: d5dm1lba80md********.i9******.apigw.yandexcloud.net
        log_group_id: ckgefpleo5eg********
        connectivity: {}
        log_options:
          folder_id: b1gc1t4cb638********
        canary:
          weight: "50"
          variables:
            function.tag:
              string_value: canary
        ```

- Terraform {#tf}

  Чтобы создать API-шлюз:

  1. Опишите в конфигурационном файле параметры ресурса `yandex_api_gateway`:

     ```hcl
     resource "yandex_api_gateway" "canary-api-gateway" {
       name        = "canary"
       canary {
         weight    = 50
         variables = {
           function.tag = "canary"
         }
       }
       spec = <<-EOT
         openapi: 3.0.0
          info:
            title: Sample API
            version: 1.0.0

          x-yc-apigateway:
            variables:
              function.tag:
                default: "stable"
                enum:
                  - "stable"
                  - "canary"

          paths:
            /:
              get:
                x-yc-apigateway-integration:
                  type: cloud_functions
                  function_id: <идентификатор_функции>
                  tag: "${var.function.tag}"
                  service_account_id: <идентификатор_сервисного_аккаунта>
       EOT
     }
     ```

     Где:
     * `name` — имя API-шлюза. Формат имени:

        * длина — от 3 до 63 символов;
        * может содержать строчные буквы латинского алфавита, цифры и дефисы;
        * первый символ — буква, последний — не дефис.

     * `canary.0.weight` — доля запросов в канареечном релизе.
     * `canary.0.variables` — переменные для канареечного релиза.
     * `spec` — спецификация API-шлюза.

     Подробнее о параметрах ресурсов в Terraform смотрите в [документации провайдера](../../terraform/resources/api_gateway.md).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команд [CLI](../../cli/quickstart.md):

        ```
        yc serverless api-gateway get <имя_API-шлюза>
        ```

- API {#api}

  Чтобы создать API-шлюз, воспользуйтесь методом REST API [create](../../api-gateway/apigateway/api-ref/ApiGateway/create.md) для ресурса [ApiGateway](../../api-gateway/apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Create](../../api-gateway/apigateway/api-ref/grpc/ApiGateway/create.md).

{% endlist %}

## Проверьте работу приложения {#test}

Сделайте несколько запросов к созданному API-шлюзу. Около половины запросов должны быть обработаны версией функции с тегом `canary`.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите API-шлюз](../../api-gateway/operations/api-gw-delete.md).
1. [Удалите функцию](../../functions/operations/function/function-delete.md).
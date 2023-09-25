# Канареечный релиз функции {{ sf-name }}

Создайте канареечный релиз функции {{ sf-name }} с помощью {{ api-gw-short-name }}.

Чтобы создать канареечный релиз:
1. [Подготовьте облако к работе](#before-begin).
2. [Подготовьте окружение](#preare).
3. [Создайте функцию {{ sf-full-name }}](#create-functions).
4. [Создайте API-шлюз](#create-api-gw).
5. [Протестируйте приложение](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов поддержки веб-приложения входят:
* Плата за количество запросов к API-шлюзу и исходящий трафик (см. [тарифы {{ api-gw-full-name }}](../../api-gateway/pricing.md)).
* Плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы {{ sf-name }}](../../functions/pricing.md)).


## Подготовьте окружение {#prepare}

[Создайте](../../iam/operations/sa/create.md#create-sa) сервисный аккаунт и [назначьте](../../iam/operations/roles/grant.md#access-to-sa) ему роль `editor` на ваш каталог.

## Создайте функцию {{ sf-name }} {#create-functions}

[Создайте две версии функции](../../functions/operations/index.md#create-function):
* версию для текущего релиза;
* версию для канареечного релиза, которая будет тестироваться на некоторой доли запросов.

Вы можете использовать собственную функцию или создать [любую функцию из списка](../../functions/quickstart/create-function/index.md). Для первой версии добавьте тег `stable`, для второй — `canary`.

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

{% endlist %}

## Создайте API-шлюз {#create-api-gw}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать API-шлюз.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
    1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_name }}** введите `canary`.
    1. В блок **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** добавьте спецификацию:
    
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
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
    
- CLI

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
       
        * `name` — имя API-шлюза.
        * `spec` — файл со спецификацией.
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
        domain: d5d1ud9bli1e********.apigw.yandexcloud.net
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

{% endlist %}

## Проверьте работу приложения {#test}

Сделайте несколько запросов к созданному {{ api-gw-short-name }}. Около половины запросов должны быть обработаны версией функции с тегом `canary`.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* [Удалите функции](../../functions/operations/function/function-delete.md).
* [Удалите API-шлюз](../../api-gateway/operations/api-gw-delete.md).

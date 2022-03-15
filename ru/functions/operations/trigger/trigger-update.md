# Изменение триггера

Вы можете изменить [имя](#update-name) или [описание](#update-description) триггера, а также [управлять метками триггера](#manage-label).

{% include [trigger-list-note](../../../_includes/functions/trigger-list-note.md) %}

## Изменить имя триггера {#update-name}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится триггер.
    1. Откройте сервис **{{ sf-name }}**.
    1. На панели слева выберите ![image](../../../_assets/functions/triggers.svg) **Триггеры**.
    1. Выберите триггер, который хотите изменить.
    1. В правом верхнем углу страницы нажмите **Редактировать**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы изменить имя триггера, выполните команду:

    ```
    yc serverless trigger update <имя триггера> --new-name <новое имя триггера>
    ```

    Результат:

    ```
    id: dd0gj5tsj2pq9at8ja8i
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-08-28T12:26:25.675Z"
    name: my-trigger
    rule:
      message_queue:
        queue_id: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq
        service_account_id: bfbqqeo6jkpls2tse5o6
        batch_settings:
          size: "10"
          cutoff: 10s
        invoke_function:
          function_id: b09e5lu91ta21vdrrgma
          function_tag: $latest
          service_account_id: bfbqqeo6jkpls2tse5o6
    status: ACTIVE
  ```

- API

    Изменить имя триггера можно с помощью метода API [update](../../triggers/api-ref/Trigger/update.md).

{% endlist %}


## Изменить описание триггера {#update-description}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится триггер.
    1. Откройте сервис **{{ sf-name }}**.
    1. На панели слева выберите ![image](../../../_assets/functions/triggers.svg) **Триггеры**.
    1. Выберите триггер, который хотите изменить.
    1. В правом верхнем углу страницы нажмите **Редактировать**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы изменить описание триггера, выполните команду:

    ```
    yc serverless trigger update <имя триггера> --description "<описание триггера>"
    ```

    Результат:

    ```
    id: dd0gj5tsj2pq9at8ja8i
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-08-28T12:26:25.675Z"
    name: my-trigger
    description: My YMQ trigger.
    rule:
      message_queue:
        queue_id: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq
        service_account_id: bfbqqeo6jkpls2tse5o6
        batch_settings:
          size: "10"
          cutoff: 10s
        invoke_function:
          function_id: b09e5lu91ta21vdrrgma
          function_tag: $latest
          service_account_id: bfbqqeo6jkpls2tse5o6
    status: ACTIVE
    ```

- API

    Изменить описание триггера можно с помощью метода API [update](../../triggers/api-ref/Trigger/update.md).

{% endlist %}


## Управлять метками триггера {#manage-label}

Вы можете выполнять следующие действия с метками триггера:

* [Добавить](#add-label)
* [Изменить](#update-label)
* [Удалить](#remove-label)

### Добавить метку {#add-label}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы добавить метку триггеру, выполните команду:

    ```
    yc serverless trigger add-labels <имя триггера> --labels <ключ>=<значение>
    ```

    Результат:

    ```
    id: dd0gj5tsj2pq9at8ja8i
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-08-28T12:26:25.675Z"
    name: my-trigger
    description: My YMQ trigger.
    labels:
      version: beta
    rule:
      message_queue:
        queue_id: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq
        service_account_id: bfbqqeo6jkpls2tse5o6
        batch_settings:
          size: "10"
          cutoff: 10s
        invoke_function:
          function_id: b09e5lu91ta21vdrrgma
          function_tag: $latest
          service_account_id: bfbqqeo6jkpls2tse5o6
    status: ACTIVE
    ```

- API

    Добавить метку триггера можно с помощью метода API [update](../../triggers/api-ref/Trigger/update.md).

{% endlist %}

### Изменить метку {#update-label}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы изменить метку триггера, выполните команду:

    {% note warning %}

    Существующий набор `labels` полностью перезаписывается набором, переданным в запросе.

    {% endnote %}

    ```
    yc serverless trigger update <имя триггера> --labels <ключ>=<значение>
    ```

    Результат:

    ```
    id: dd0gj5tsj2pq9at8ja8i
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-08-28T12:26:25.675Z"
    name: my-trigger
    description: My YMQ trigger.
    labels:
      new_labels: my-beta-trigger
    rule:
      message_queue:
        queue_id: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq
        service_account_id: bfbqqeo6jkpls2tse5o6
        batch_settings:
          size: "10"
          cutoff: 10s
        invoke_function:
          function_id: b09e5lu91ta21vdrrgma
          function_tag: $latest
          service_account_id: bfbqqeo6jkpls2tse5o6
    status: ACTIVE
    ```

- API

    Изменить метку триггера можно с помощью метода API [update](../../triggers/api-ref/Trigger/update.md).

{% endlist %}

### Удалить метку {#remove-label}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы удалить метку триггера, выполните команду:

    ```
    yc serverless trigger remove-labels <имя триггера> --labels <ключ>
    ```

    Результат:

    ```
    id: dd0gj5tsj2pq9at8ja8i
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-08-28T12:26:25.675Z"
    name: my-trigger
    description: My YMQ trigger.
    rule:
      message_queue:
        queue_id: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq
        service_account_id: bfbqqeo6jkpls2tse5o6
        batch_settings:
          size: "10"
          cutoff: 10s
        invoke_function:
          function_id: b09e5lu91ta21vdrrgma
          function_tag: $latest
          service_account_id: bfbqqeo6jkpls2tse5o6
    status: ACTIVE
    ```

- API

    Удалить метку триггера можно с помощью метода API [update](../../triggers/api-ref/Trigger/update.md).

{% endlist %}

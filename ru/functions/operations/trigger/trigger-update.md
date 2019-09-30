# Изменение триггера

{% include [triggers-preview](../../../_includes/functions/triggers-preview-stage.md) %}

Вы можете изменить [имя](#update-name) или [описание](#update-description) триггера, а также [управлять метками триггера](#manage-label).

{% include [yc-trigger-list](../../../_includes/functions/trigger-list.md) %}

## Изменить имя триггера {#update-name}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    Измените имя триггера:
    
    ```
    $ yc serverless trigger update test-trigger --new-name my-trigger
    id: dd0gj5tsj2pq9at8ja8i
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-08-28T12:26:25.675Z"
    name: my-trigger
    rule:
      message_queue:
        arn: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq
        service_account_id: bfbqqeo6jkpls2tse5o6
        batch_settings:
          size: "10"
          cutoff: 10s
        invoke_function:
          function_id: b09e5lu91ta21vdrrgma
          function_tag: $latest
          service_account_id: bfbqqeo6jkpls2tse5o6
  ```
  
{% endlist %}


## Изменить описание триггера {#update-description}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Измените описание триггера:
    
    ```
    $ yc serverless trigger update my-trigger --description "My YMQ trigger."
    id: dd0gj5tsj2pq9at8ja8i
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-08-28T12:26:25.675Z"
    name: my-trigger
    description: My YMQ trigger.
    rule:
      message_queue:
        arn: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq
        service_account_id: bfbqqeo6jkpls2tse5o6
        batch_settings:
          size: "10"
          cutoff: 10s
        invoke_function:
          function_id: b09e5lu91ta21vdrrgma
          function_tag: $latest
          service_account_id: bfbqqeo6jkpls2tse5o6
    ```
  
{% endlist %}

## Управлять метками триггера {#manage-label}

Вы можете выполнять следующие действия с метками триггера:

- [Добавить](#add-label)
- [Изменить](#update-label)
- [Удалить](#remove-label)

### Добавить метку {#add-label}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    Добавьте метку триггеру:
    
    ```
    $ yc serverless trigger add-labels my-trigger --labels version=beta
    id: dd0gj5tsj2pq9at8ja8i
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-08-28T12:26:25.675Z"
    name: my-trigger
    description: My YMQ trigger.
    labels:
      version: beta
    rule:
      message_queue:
        arn: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq
        service_account_id: bfbqqeo6jkpls2tse5o6
        batch_settings:
          size: "10"
          cutoff: 10s
        invoke_function:
          function_id: b09e5lu91ta21vdrrgma
          function_tag: $latest
          service_account_id: bfbqqeo6jkpls2tse5o6
    ```

{% endlist %}

### Изменить метку {#update-label}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    Измените метку триггера:
  
    {% note important %}
    
    Существующий набор `labels` полностью перезаписывается набором, переданным в запросе.
    
    {% endnote %}
  
    ```
    $ yc serverless trigger update my-trigger --labels new_labels=my-beta-trigger
    id: dd0gj5tsj2pq9at8ja8i
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-08-28T12:26:25.675Z"
    name: my-trigger
    description: My YMQ trigger.
    labels:
      new_labels: my-beta-trigger
    rule:
      message_queue:
        arn: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq
        service_account_id: bfbqqeo6jkpls2tse5o6
        batch_settings:
          size: "10"
          cutoff: 10s
        invoke_function:
          function_id: b09e5lu91ta21vdrrgma
          function_tag: $latest
          service_account_id: bfbqqeo6jkpls2tse5o6
    ```
  
{% endlist %}

### Удалить метку {#remove-label}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    Удалите метку триггера:
    
    ```
    $ yc serverless trigger remove-labels my-trigger --labels new_labels
    id: dd0gj5tsj2pq9at8ja8i
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-08-28T12:26:25.675Z"
    name: my-trigger
    description: My YMQ trigger.
    rule:
      message_queue:
        arn: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq
        service_account_id: bfbqqeo6jkpls2tse5o6
        batch_settings:
          size: "10"
          cutoff: 10s
        invoke_function:
          function_id: b09e5lu91ta21vdrrgma
          function_tag: $latest
          service_account_id: bfbqqeo6jkpls2tse5o6
    ```
  
{% endlist %}

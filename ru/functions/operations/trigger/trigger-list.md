# Получение информации о триггере

{% include [triggers-preview](../../../_includes/functions/triggers-preview-stage.md) %}

Чтобы узнать уникальный идентификатор или имя триггера, получите список триггеров в каталоге или подробную информацию о триггере.

## Получить список триггеров в каталоге {#trigger-list}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Получите список [триггеров](../../concepts/trigger.md):
    
    ```
    $ yc serverless trigger list
    +----------------------+------------+----------------------+
    |          ID          |    NAME    |      FOLDER ID       |
    +----------------------+------------+----------------------+
    | dd0gj5tsj2pq9at8ja8i | my-trigger | aoek49ghmknnpj1ll45e |
    +----------------------+------------+----------------------+
    ```
  
{% endlist %}


## Получить подробную информацию о триггере {#trigger-get}

Для обращения к триггеру используйте параметры `ID` или `NAME` из [предыдущего](#trigger-list) пункта.

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Получите подробную информацию о триггере:
    
    ```
    $ yc serverless trigger get my-trigger
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

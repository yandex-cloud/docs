# Getting information about a trigger

{% include [triggers-preview](../../../_includes/functions/triggers-preview-stage.md) %}

To find out the unique ID or name of a trigger, get a list triggers in the folder or detailed information about the trigger.

## Getting a list of triggers in a folder {#trigger-list}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Get a list of [triggers](../../concepts/index.md):

    ```
    $ yc serverless trigger list
    +----------------------+------------+----------------------+
    |          ID          |    NAME    |      FOLDER ID       |
    +----------------------+------------+----------------------+
    | dd0gj5tsj2pq9at8ja8i | my-trigger | aoek49ghmknnpj1ll45e |
    +----------------------+------------+----------------------+
    ```

{% endlist %}

## Getting detailed information about a trigger {#trigger-get}

To access a trigger, use the `ID` or `NAME` parameters from the [previous](#trigger-list) section.

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Get detailed information about a trigger:

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


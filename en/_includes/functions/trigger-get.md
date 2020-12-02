{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), go to the folder where the trigger is located.
  1. Open **{{ sf-name }}**.
  1. Go to the **Triggers** tab.
  1. Select the trigger to get detailed information about.

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Get detailed information about a trigger:

    ```
    yc serverless trigger get <trigger name>
    ```

    Result:

    ```
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
    status: ACTIVE
    ```

- API

  You can get detailed information about a trigger using the [get](../../functions/triggers/api-ref/Trigger/get.md) API method.

{% endlist %}

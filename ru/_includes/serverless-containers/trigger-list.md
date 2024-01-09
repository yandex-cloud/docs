{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите посмотреть список триггеров.
    1. Откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Получите список триггеров:

    ```bash
    yc serverless trigger list
    ```

    Результат:

    ```text
    +----------------------+------------+----------------------+
    |          ID          |    NAME    |      FOLDER ID       |
    +----------------------+------------+----------------------+
    | dd0gj5tsj2********** | my-trigger | aoek49ghmk********** |
    +----------------------+------------+----------------------+
    ```

- API {#api}

  Чтобы получить список триггеров, воспользуйтесь методом REST API [list](../../serverless-containers/triggers/api-ref/Trigger/list.md) для ресурса [Trigger](../../serverless-containers/triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/List](../../serverless-containers/triggers/api-ref/grpc/trigger_service.md#List).

{% endlist %}

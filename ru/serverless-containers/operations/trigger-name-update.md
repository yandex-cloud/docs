# Изменить имя триггера в {{ serverless-containers-name }}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится триггер.
    1. Откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. На панели слева выберите ![image](../../_assets/functions/triggers.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
    1. Выберите триггер, имя которого хотите изменить.
    1. В правом верхнем углу страницы нажмите **{{ ui-key.yacloud.common.edit }}**.
    1. Измените имя и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_update-trigger }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    {% include [trigger-list-note](../../_includes/serverless-containers/trigger-list-note.md) %}

    Чтобы изменить имя триггера, выполните команду:

    ```bash
    yc serverless trigger update <имя_триггера> --new-name <новое_имя_триггера>
    ```

    Результат:

    ```text
    id: a1sfe084v4**********
    folder_id: b1g88tflru**********
    created_at: "2022-12-04T08:45:31.131391Z"
    name: my-trigger
    rule:
      mail:
        email: a1s8h8avgl**********-cho1****@serverless.yandexcloud.net
        invoke_container:
          container_id: bba5jb38o8**********
          service_account_id: aje03adgd2**********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
    status: ACTIVE
    ```

- API

  Чтобы изменить имя триггера, воспользуйтесь методом REST API [update](../triggers/api-ref/Trigger/update.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Update](../triggers/api-ref/grpc/trigger_service.md#Update).

{% endlist %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится триггер.
  1. Откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Выберите триггер, о котором хотите получить подробную информацию.

- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Получите подробную информацию о триггере:

    ```bash
    yc serverless trigger get <имя_триггера>
    ```

    Результат:
  
    
    ```text
    id: a1sfe084v4**********
    folder_id: b1g88tflri**********
    created_at: "2022-12-04T08:45:31.131391Z"
    name: mail-trigger
    description: My trigger for mail.
    rule:
      mail:
        email: a1smdtklem**********-xivn****@serverless.yandexcloud.net
        invoke_container:
          container_id: bba5jb38o8**********
          service_account_id: aje03adgd2**********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:b1gmit33ng**********:dlq
            service-account-id: aje3lebfem**********
    status: ACTIVE
    ```
  

- API {#api}

  Чтобы получить информацию о триггере, воспользуйтесь методом REST API [get](../../serverless-containers/triggers/api-ref/Trigger/get.md) для ресурса [Trigger](../../serverless-containers/triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Get](../../serverless-containers/triggers/api-ref/grpc/trigger_service.md#Get).

{% endlist %}

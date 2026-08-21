---
title: Остановить и запустить API-шлюз
description: Следуя данной инструкции, вы сможете остановить или запустить API-шлюз.
---

# Остановить и запустить API-шлюз

После создания [API-шлюза](../concepts/index.md) вы можете остановить его и запустить заново.


# Остановить API-шлюз {#stop}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите остановить API-шлюз.
  1. [Перейдите]({{ link-console-main }}/link/api-gateway) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. В строке с API-шлюзом нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![square](../../_assets/console-icons/square.svg) **{{ ui-key.yacloud.common.stop }}**.

     API-шлюз перейдет в статус `Stopped`.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для остановки API-шлюза:

     ```bash
     {{ yc-serverless }} api-gateway stop --help
     ```

  1. Остановите API-шлюз:

     ```bash
     {{ yc-serverless }} api-gateway stop <имя_или_идентификатор_API-шлюза>
     ```

     Результат:

     ```text
     id: d5daqt0ofc4t********
     folder_id: b1g681qpemb4********
     created_at: "2026-08-20T12:56:16.354Z"
     name: my-gateway
     status: STOPPED
     domain: d5daqt0ofc4t********.********.apigw.yandexcloud.net
     connectivity: {}
     log_options:
       disabled: true
       folder_id: b1g681qpemb4********
     execution_timeout: 300s
     ```
- API {#api}

  Чтобы остановить API-шлюз, воспользуйтесь методом REST API [stop](../apigateway/api-ref/ApiGateway/stop.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Stop](../apigateway/api-ref/grpc/ApiGateway/stop.md).

{% endlist %}


# Запустить API-шлюз {#resume}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите запустить API-шлюз.
  1. [Перейдите]({{ link-console-main }}/link/api-gateway) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. В строке с API-шлюзом нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![play](../../_assets/console-icons/play.svg) **{{ ui-key.yacloud.common.start }}**.

     API-шлюз перейдет в статус `Active`.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для запуска API-шлюза:

     ```bash
     {{ yc-serverless }} api-gateway resume --help
     ```

  1. Запустите API-шлюз:

     ```bash
     {{ yc-serverless }} api-gateway resume <имя_или_идентификатор_API-шлюза>
     ```

     Результат:

     ```text
     id: d5daqt0ofc4t********
     folder_id: b1g681qpemb4********
     created_at: "2026-08-20T12:56:16.354Z"
     name: my-gateway
     status: ACTIVE
     domain: d5daqt0ofc4t********.********.apigw.yandexcloud.net
     connectivity: {}
     log_options:
       disabled: true
       folder_id: b1g681qpemb4********
     execution_timeout: 300s
      ```

- API {#api}

  Чтобы запустить API-шлюз, воспользуйтесь методом REST API [resume](../apigateway/api-ref/ApiGateway/resume.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Resume](../apigateway/api-ref/grpc/ApiGateway/resume.md).

{% endlist %}

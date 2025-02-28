---
title: Изменить метку коннектора
description: Следуя данной инструкции, вы сможете изменить метку коннектора.
---

# Изменить метку коннектора

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  Чтобы изменить метку [коннектора](../../../concepts/eventrouter/connector.md), выполните команду:

  {% include [labels-rewrite-warning](../../../../_includes/labels-rewrite-warning.md) %}

  ```bash
  yc serverless eventrouter connector update <имя_или_идентификатор_коннектора> \
    --labels <список_меток>
  ```

  Где `--labels` — список меток. Вы можете указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

  Результат:

  ```text
  id: f66g4h59ih2g********
  bus_id: f66qn4p7uk6p********
  folder_id: b1g681qpemb4********
  cloud_id: b1gia87mbaom********
  created_at: "2025-02-20T15:30:05.248052Z"
  name: renamed-ydb
  description: consumer-one
  labels:
    owner: admin
    version: beta
  ...
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  Чтобы изменить метку [коннектора](../../../concepts/eventrouter/connector.md):

  1. Откройте конфигурационный файл {{ TF }} и отредактируйте блок `labels`.

      Пример описания коннектора в конфигурационном файле {{ TF }}:

      ```hcl
      resource "yandex_serverless_eventrouter_connector" "example_connector" {
        bus_id              = "<идентификатор_шины>"
        name                = "<имя_коннектора>"
        description         = "<описание_коннектора>"
        deletion_protection = <true|false>

        labels = {
          <ключ_1> = "<значение_1>"
          <ключ_2> = "<значение_2>"
          ...
          <ключ_n> = "<значение_n>"
        }
        ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_serverless_eventrouter_connector` см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_eventrouter_connector).

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../../cli/):

      ```bash
      yc serverless eventrouter connector list
      ```

- API {#api}

  Чтобы изменить метку [коннектора](../../../concepts/eventrouter/connector.md), воспользуйтесь методом REST API [Update](../../../../serverless-integrations/eventrouter/api-ref/Connector/update.md) для ресурса [Connector](../../../../serverless-integrations/eventrouter/api-ref/Connector/index.md) или вызовом gRPC API [Connector/Update](../../../../serverless-integrations/eventrouter/api-ref/grpc/Connector/update.md).

{% endlist %}
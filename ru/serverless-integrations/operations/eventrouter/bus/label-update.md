---
title: Изменить метку шины
description: Следуя данной инструкции, вы сможете изменить метку шины.
---

# Изменить метку шины

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  Чтобы изменить метку [шины](../../../concepts/eventrouter/bus.md), выполните команду:

  {% include [labels-rewrite-warning](../../../../_includes/labels-rewrite-warning.md) %}

  ```bash
  yc serverless eventrouter bus update <имя_или_идентификатор_шины> \
    --labels <список_меток>
  ```

  Где `--labels` — список меток. Вы можете указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

  Результат:

  ```text
  id: f66aevm4ithv********
  folder_id: b1g681qpemb4********
  cloud_id: b1gia87mbaom********
  created_at: "2025-02-13T12:36:59.497985Z"
  name: my-bus-43
  description: this is my bus
  labels:
    owner: admin
    version: beta
  deletion_protection: true
  status: ACTIVE
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  Чтобы изменить метку [шины](../../../concepts/eventrouter/bus.md):

  1. Откройте конфигурационный файл {{ TF }} и отредактируйте блок `labels`.

      Пример описания шины в конфигурационном файле {{ TF }}:

      ```hcl
      resource "yandex_serverless_eventrouter_bus" "example_bus" {
        name                = "my-bus"
        description         = "this is my bus"
        deletion_protection = true

        labels = {
          key1 = "value1"
          key2 = "value2"
        }
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_serverless_eventrouter_bus` см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_eventrouter_bus).

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../../cli/):

      ```bash
      yc serverless eventrouter bus list
      ```

- API {#api}

  Чтобы изменить метку [шины](../../../concepts/eventrouter/bus.md), воспользуйтесь методом REST API [Update](../../../../serverless-integrations/eventrouter/api-ref/Bus/update.md) для ресурса [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) или вызовом gRPC API [Bus/Update](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/update.md).

{% endlist %}
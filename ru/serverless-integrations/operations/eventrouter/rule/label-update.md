---
title: Изменить метку правила
description: Следуя данной инструкции, вы сможете изменить метку правила.
---

# Изменить метку правила

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  Чтобы изменить метку [правила](../../../concepts/eventrouter/rule.md), выполните команду:

  {% include [labels-rewrite-warning](../../../../_includes/labels-rewrite-warning.md) %}

  ```bash
  yc serverless eventrouter rule update <имя_или_идентификатор_правила> \
    --labels <список_меток>
  ```

  Где `--labels` — список меток. Вы можете указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

  Результат:

  ```text
  id: f66vfpjrkc35********
  bus_id: f66epjc9llqt********
  folder_id: b1g681qpemb4********
  cloud_id: b1gia87mbaom********
  created_at: "2025-02-26T14:04:47.710918Z"
  name: new-rule
  description: created via cli
  labels:
    owner: admin
    version: beta
  ...
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  Чтобы изменить метку [правила](../../../concepts/eventrouter/rule.md):

  1. Откройте конфигурационный файл {{ TF }} и отредактируйте блок `labels`.

      Пример описания правила в конфигурационном файле {{ TF }}:

      ```hcl
      resource "yandex_serverless_eventrouter_rule" "example_rule" {
        bus_id      = "<идентификатор_правила>"
        name        = "<имя_правила>"
        description = "<описание_правила>"

        labels = {
          <ключ_1> = "<значение_1>"
          <ключ_2> = "<значение_2>"
          ...
          <ключ_n> = "<значение_n>"
        }
        ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_serverless_eventrouter_rule` см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_eventrouter_rule).

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../../cli/):

      ```bash
      yc serverless eventrouter rule list
      ```

- API {#api}

  Чтобы изменить метку [правила](../../../concepts/eventrouter/rule.md), воспользуйтесь методом REST API [Update](../../../../serverless-integrations/eventrouter/api-ref/Rule/update.md) для ресурса [Rule](../../../../serverless-integrations/eventrouter/api-ref/Rule/index.md) или вызовом gRPC API [Rule/Update](../../../../serverless-integrations/eventrouter/api-ref/grpc/Rule/update.md).

{% endlist %}
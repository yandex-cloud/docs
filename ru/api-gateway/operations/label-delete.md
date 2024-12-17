---
title: Удалить метку API-шлюза
description: Следуя данной инструкции, вы сможете удалить метку API-шлюза.
---

# Удалить метку API-шлюза

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится API-шлюз.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. В строке с API-шлюзом нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
    1. В поле **{{ ui-key.yacloud.component.label-set.label_labels }}** выберите нужную метку и нажмите ![cross](../../_assets/console-icons/xmark.svg) справа от ее имени.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить метку API-шлюза, обновите набор его меток, удалив ненужные. Выполните команду:

  {% include [labels-rewrite-warning](../../_includes/labels-rewrite-warning.md) %}

  {% include [labels-cli](../../_includes/api-gateway/labels-cli.md) %}

  Чтобы удалить все метки API-шлюза, задайте пустое значение:

  ```bash
  yc serverless api-gateway update <имя_API-шлюза> --labels ""
  ```

  {% include [check-labels](../../_includes/api-gateway/check-labels.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы удалить метку API-шлюза:

  1. Откройте файл конфигурации {{ TF }} и в блоке `labels` удалите ненужную метку.

      {% include [labels-terraform](../../_includes/api-gateway/labels-terraform.md) %}

  1. Обновите ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  {% include [check-labels](../../_includes/api-gateway/check-labels.md) %}

- API {#api}

  Чтобы удалить метку API-шлюза, воспользуйтесь методом REST API [update](../apigateway/api-ref/ApiGateway/update.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Update](../apigateway/api-ref/grpc/ApiGateway/update.md).

{% endlist %}

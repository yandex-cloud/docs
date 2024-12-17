---
title: Добавить метку API-шлюзу
description: Следуя данной инструкции, вы сможете добавить метку API-шлюзу.
---

# Добавить метку API-шлюзу

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится API-шлюз.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. В строке с API-шлюзом нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В поле **{{ ui-key.yacloud.component.label-set.label_labels }}** нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
  1. Введите ключ и значение и нажмите **Enter**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы добавить метку API-шлюзу, выполните команду:

  {% include [labels-rewrite-warning](../../_includes/labels-rewrite-warning.md) %}

  {% include [labels-cli](../../_includes/api-gateway/labels-cli.md) %}

  Вы можете указать несколько пар `<ключ>=<значение>` через запятую.

  {% include [check-labels](../../_includes/api-gateway/check-labels.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы добавить метку API-шлюзу:

  1. В конфигурационном файле {{ TF }} добавьте блок `labels` и перечислите в нем список меток в формате `<ключ>:"<значение>"`.

      {% include [labels-terraform](../../_includes/api-gateway/labels-terraform.md) %}

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  {% include [check-labels](../../_includes/api-gateway/check-labels.md) %}

- API {#api}

  Чтобы добавить метку API-шлюзу, воспользуйтесь методом REST API [update](../apigateway/api-ref/ApiGateway/update.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Update](../apigateway/api-ref/grpc/ApiGateway/update.md).

{% endlist %}

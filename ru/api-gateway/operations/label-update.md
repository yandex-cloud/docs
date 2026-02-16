---
title: Изменить метку API-шлюза
description: Следуя данной инструкции, вы сможете изменить метку API-шлюза.
---

# Изменить метку API-шлюза

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить метку API-шлюза, выполните команду:

  {% include [labels-rewrite-warning](../../_includes/labels-rewrite-warning.md) %}

  {% include [labels-cli](../../_includes/api-gateway/labels-cli.md) %}

  Вы можете указать несколько пар `<ключ>=<значение>` через запятую.

  {% include [check-labels](../../_includes/api-gateway/check-labels.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы изменить метку API-шлюза:

  1. Откройте файл конфигурации {{ TF }} и отредактируйте блок `labels`.

      {% include [labels-terraform](../../_includes/api-gateway/labels-terraform.md) %}

  1. Обновите ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  {% include [check-labels](../../_includes/api-gateway/check-labels.md) %}

- API {#api}

  Чтобы изменить метку API-шлюза, воспользуйтесь методом REST API [update](../apigateway/api-ref/ApiGateway/update.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Update](../apigateway/api-ref/grpc/ApiGateway/update.md).

{% endlist %}
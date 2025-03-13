---
title: Как получить список трейлов
description: Следуя данной инструкции, вы сможете посмотреть список доступных трейлов {{ at-full-name }}.
---

# Получить список трейлов

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите посмотреть список [трейлов](../concepts/trail.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. На странице **{{ ui-key.yacloud.audit-trails.label_trails }}** отобразится список трейлов.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/) для просмотра списка [трейлов](../concepts/trail.md):

      ```bash
      yc audit-trails trail list --help
      ```

  1. {% include [get-list](../../_includes/audit-trails/get-list.md) %}

- API {#api}

  Чтобы посмотреть список [трейлов](../concepts/trail.md), воспользуйтесь методом REST API [list](../api-ref/Trail/list.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызовом gRPC API [TrailService/List](../api-ref/grpc/Trail/list.md).

{% endlist %}
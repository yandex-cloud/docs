---
title: Как получить список групп виртуальных машин в {{ compute-full-name }}
description: Следуя данной инструкции, вы сможете получить список групп виртуальных машин.
---

# Получить список групп виртуальных машин

Чтобы получить список групп виртуальных машин:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится нужная группа ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для работы с группой виртуальных машин:

      ```bash
      {{ yc-compute-ig }} --help
      ```

  1. Получите список групп виртуальных машин в каталоге по умолчанию:

      {% include [instance-group-list](../../../_includes/instance-groups/instance-group-list.md) %}

- API {#api}

  Воспользуйтесь методом REST API [list](../../instancegroup/api-ref/InstanceGroup/list.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/List](../../instancegroup/api-ref/grpc/InstanceGroup/list.md).

  Список доступных групп запрашивайте методом REST API [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md).

{% endlist %}

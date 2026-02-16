---
title: Как создать группу виртуальных машин в {{ compute-full-name }} по спецификации в формате YAML
description: Следуя данной инструкции, вы сможете создать группу виртуальных машин по спецификации в формате YAML.
---

# Создать группу виртуальных машин по спецификации в формате YAML

{% include [sa.md](../../../_includes/instance-groups/sa.md) %}

Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль [compute.editor](../../security/index.md#compute-editor).

Если вы хотите интегрировать группу ВМ с сетевым балансировщиком [{{ network-load-balancer-full-name }}](../../../network-load-balancer/), дополнительно назначьте сервисному аккаунту роль [load-balancer.editor](../../../network-load-balancer/security/index.md#load-balancer-editor).

Чтобы интегрировать группу ВМ с L7-балансировщиком [{{ alb-full-name }}](../../../application-load-balancer/), назначьте сервисному аккаунту роль [alb.editor](../../../application-load-balancer/security/index.md#alb-editor).

Чтобы создать [группу виртуальных машин](../../concepts/instance-groups/index.md) по [спецификации](../../concepts/instance-groups/specification.md) в формате YAML:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  Выполните следующую команду:

  ```bash
  {{ yc-compute-ig }} create --file specification.yaml
  ```

  Подробнее о команде `{{ yc-compute-ig}} create` см. в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance-group/create.md).

- API {#api}

  Используйте вызов [InstanceGroupService/CreateFromYaml](../../instancegroup/api-ref/grpc/InstanceGroup/createFromYaml.md) gRPC API или метод [createFromYaml](../../instancegroup/api-ref/InstanceGroup/createFromYaml.md) ресурса `InstanceGroup` REST API.

{% endlist %}
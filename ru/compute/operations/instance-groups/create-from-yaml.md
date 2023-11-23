---
title: "Как создать группу виртуальных машин в {{ compute-full-name }} по спецификации в формате YAML"
description: "Следуя данной инструкции, вы сможете создать группу виртуальных машин по спецификации в формате YAML." 
---

# Создать группу виртуальных машин по спецификации в формате YAML

Чтобы создать [группу виртуальных машин](../../concepts/instance-groups/index.md) по [спецификации](../../concepts/instance-groups/specification.md) в формате YAML:

{% list tabs %}

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  Выполните следующую команду:
  
  ```
  {{ yc-compute-ig }} create --file specification.yaml
  ```
  
  Подробнее о команде `{{ yc-compute-ig}} create` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/instance-group/create.md).

- API

  Используйте вызов [InstanceGroupService/CreateFromYaml](../../api-ref/grpc/instance_group_service.md#CreateFromYaml) gRPC API или метод [createFromYaml](../../api-ref/InstanceGroup/createFromYaml.md) ресурса `InstanceGroup` REST API.

{% endlist %} 
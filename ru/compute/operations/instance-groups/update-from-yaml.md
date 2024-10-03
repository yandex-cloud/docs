---
title: Как изменить группу виртуальных машин в {{ compute-full-name }} по спецификации в формате YAML
description: Следуя данной инструкции, вы сможете изменить группу виртуальных машин по спецификации в формате YAML.
---

# Изменить группу виртуальных машин по спецификации в формате YAML

Чтобы изменить [группу виртуальных машин](../../concepts/instance-groups/index.md) по [спецификации](../../concepts/instance-groups/specification.md) в формате YAML:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  Выполните следующую команду, указав имя или идентификатор группы ВМ и путь к файлу YAML-спецификации:
  
  ```bash
  {{ yc-compute-ig }} update <имя_или_идентификатор_группы_ВМ> --file specification.yaml
  ```

  Подробнее о команде `{{ yc-compute-ig }} update` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/instance-group/update.md).

- API {#api}

  Воспользуйтесь методом REST API [updateFromYaml](../../api-ref/InstanceGroup/updateFromYaml.md) для ресурса [InstanceGroup](../../api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/UpdateFromYaml](../../api-ref/grpc/instance_group_service.md#UpdateFromYaml).

  Список доступных групп запрашивайте методом REST API [listInstances](../../api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../api-ref/grpc/instance_group_service.md#ListInstances).

{% endlist %}
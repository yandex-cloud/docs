# Изменить группу виртуальных машин по спецификации в формате YAML

Чтобы изменить [группу виртуальных машин](../../concepts/instance-groups/index.md) по [спецификации](../../concepts/instance-groups/specification.md) в формате YAML:

{% list tabs %}

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  Выполните следующую команду:
  
  ```
  {{ yc-compute-ig }} update --file specification.yaml
  ```
  
  Подробнее о команде `{{ yc-compute-ig}} update` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/instance-group/update.md).

- API

  Используйте вызов [InstanceGroupService/UpdateFromYaml](../../api-ref/grpc/instance_group_service.md#UpdateFromYaml) gRPC API или метод [updateFromYaml](../../api-ref/InstanceGroup/updateFromYaml.md) ресурса `InstanceGroup` REST API.

{% endlist %} 
{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Выберите группу `vm-scale-scheduled-ig`.
  1. Убедитесь, что в блоке **{{ ui-key.yacloud.compute.group.overview.section_instances-state }}** каждые две минуты изменяется количество ВМ: увеличивается с 2 до 3, затем уменьшается с 3 до 2 и т. д. Также вы можете проверить обновление группы на вкладке ![image](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}**.

- CLI {#cli}

  Несколько раз выполните следующую команду:

  ```bash
  yc compute instance-group get vm-scale-scheduled-ig \
    --folder-name example-folder
  ```

  Результат:

  ```yaml
  id: cl1l0ljqbmkp********
  folder_id: b1g9hv2loamq********
  created_at: "2022-03-28T13:24:20.693Z"
  ...
  managed_instances_state:
    target_size: "2"
    running_actual_count: "2"
  ...
  ```

  Значение в поле `target_size` (целевой размер группы) должно меняться с `2` на `3` и обратно.

- API {#api}

  Несколько раз получите информацию о группе ВМ `vm-scale-scheduled-ig` с помощью метода REST API [get](../../../compute/instancegroup/api-ref/InstanceGroup/get.md) для ресурса [InstanceGroup](../../../compute/instancegroup/api-ref/InstanceGroup/index.md) или вызова gRPC API [InstanceGroupService/Get](../../../compute/instancegroup/api-ref/grpc/InstanceGroup/get.md). Значение в поле `target_size` (целевой размер группы) должно меняться с `2` на `3` и обратно.

{% endlist %}
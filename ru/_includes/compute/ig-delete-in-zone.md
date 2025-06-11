{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная [группа виртуальных машин](../../compute/concepts/instance-groups/index.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. Выберите группу ВМ, которую хотите изменить.
  1. В правом верхнем углу нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_allocation }}** отключите старую [зону доступности](../../overview/concepts/geo-scope.md).
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  1. Откройте файл со [спецификацией](../../compute/concepts/instance-groups/specification.md) [группы виртуальных машин](../../compute/concepts/instance-groups/index.md) и измените [шаблон ВМ](../../compute/concepts/instance-groups/instance-template.md):
     * В секции `allocation_policy` удалите старую зону доступности.
     * В секции `network_interface_specs` удалите идентификатор [подсети](../../vpc/concepts/network.md#subnet) в старой зоне доступности.
  1. Измените группу ВМ:

     ```bash
     yc compute instance-group update \
       --id <идентификатор_группы_ВМ> \
       --file <файл_со_спецификацией_ВМ>
     ```

     Где:
     * `--id` — идентификатор группы ВМ.
     * `--file` — путь к файлу со спецификацией группы ВМ.

     Результат:

     ```text
     id: cl15sjqilrei********
     ...
     allocation_policy:
     zones:
     - zone_id: <новая_зона_доступности>
     ...
     ```

- {{ TF }} {#tf}

  1. Откройте файл конфигурации {{ TF }} для [группы виртуальных машин](../../compute/concepts/instance-groups/index.md) и удалите в блоке `allocation_policy` старую [зону доступности](../../overview/concepts/geo-scope.md), а в блоке `network_interface` идентификатор [подсети](../../vpc/concepts/network.md#subnet) в старой зоне:

     ```hcl
     ...
     network_interface {
       subnet_ids = ["<идентификатор_подсети_в_новой_зоне_доступности>"]
     }
     ...
     allocation_policy {
       zones = ["<новая_зона_доступности>"]
     }
     ...
     ```

     Где:
     * `zones` — зона доступности, в которую вы хотите переместить группу ВМ. Можно указать несколько зон.
     * `subnet_ids` — идентификатор подсети в той зоне доступности, в которую вы хотите перенести группу ВМ.

     Более подробную информацию о параметрах ресурсов в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_instance_group).
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     ВМ группы будут удалены в старой зоне доступности. Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc compute instance-group get <имя_группы_ВМ>
     ```

- API {#api}

  Воспользуйтесь методом REST API [update](../../compute/instancegroup/api-ref/InstanceGroup/update.md) для ресурса [InstanceGroup](../../compute/instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Update](../../compute/instancegroup/api-ref/grpc/InstanceGroup/update.md).

{% endlist %}
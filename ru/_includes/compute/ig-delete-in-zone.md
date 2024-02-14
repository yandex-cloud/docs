{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится нужная группа ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Выберите группу, которую хотите изменить.
  1. В правом верхнем углу нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.compute.groups.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_allocation }}** отключите старую зону доступности.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  1. Откройте файл со [спецификацией](../../compute/concepts/instance-groups/specification.md) группы ВМ и измените шаблон ВМ:

      * В секции `allocation_policy` удалите старую зону доступности.
      * В секции `network_interface_specs` удалите идентификатор подсети в старой зоне доступности.

  1. Измените группу ВМ:

      ```bash
      yc compute instance-group update \
        --id <идентификатор_группы_ВМ> \
        --file <файл_со_спецификацией_ВМ>
      ```

      Где: 

      * `--id` — идентификатор группы ВМ.
      * `--file` — путь к файлу со спецификацией группы ВМ.

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

  1. Откройте файл конфигурации {{ TF }} для группы ВМ и удалите в блоке `allocation_policy` старую зону доступности, а в блоке `network_interface` идентификатор подсети в старой зоне: 

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

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      ВМ группы будут удалены в старой зоне доступности. Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc compute instance-group get <имя_группы_ВМ>
      ```

- API {#api}

  Воспользуйтесь методом REST API [update](../../compute/api-ref/InstanceGroup/update.md) для ресурса [InstanceGroup](../../compute/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Update](../../compute/api-ref/grpc/instance_group_service.md#Update).

{% endlist %}

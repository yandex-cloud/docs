# Удалить группу размещения

Удалите [группу размещения](../../concepts/placement-groups.md).

{% include [placement-groups-info.md](../../../_includes/compute/placement-groups-info.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит группа размещения.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/group-placement-pic.svg) **{{ ui-key.yacloud.compute.switch_placement-groups }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.compute.placement-groups.label_tab-instances }}**.
  1. В строке с нужной группой размещения нажмите значок ![image](../../../_assets/options.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите список [виртуальных машин](../../concepts/vm.md) в группе размещения:

     ```bash
     yc compute placement-group list-instances --name my-group
     ```

     Результат:

     ```text
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     |          ID          |        NAME         |      ZONE ID      | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     | epdep2kq6dt5******** | instance-in-group-1 | {{ region-id }}-b | RUNNING |             | 10.129.0.5  |
     | epdlv1pp5401******** | instance-in-group-2 | {{ region-id }}-b | RUNNING |             | 10.129.0.30 |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     ```

  1. Удалите ВМ в группе размещения:

     ```bash
     yc compute instance delete --name instance-in-group-1
     yc compute instance delete --name instance-in-group-2
     ```

  1. Удалите группу размещения:

     ```bash
     yc compute placement-group delete --name my-group
     ```

  1. Проверьте, что группа размещения удалена:

     ```bash
     yc compute placement-group list
     ```

     Результат:

     ```text
     +----+------+----------+
     | ID | NAME | STRATEGY |
     +----+------+----------+
     +----+------+----------+
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы удалить группу размещения, созданную с помощью {{ TF }}:
  1. Откройте файл конфигураций {{ TF }} и удалите фрагмент с описанием группы размещения.

     Пример описания группы размещения в конфигурации {{ TF }}:

     ```hcl
     ...
     resource "yandex_compute_placement_group" "group1" {
       name        = "test-pg"
       folder_id   = "b1gia87mbaom********"
       description = "my description"
     }
     ...
     ```

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.
  1. Проверьте конфигурацию командой:

     ```bash
     terraform validate
     ```

     Если конфигурация является корректной, появится сообщение:

     ```text
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```bash
     terraform plan
     ```

     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:

     ```bash
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     yc compute placement-group list
     ```

- API {#api}

  Воспользуйтесь методом REST API [delete](../../api-ref/PlacementGroup/delete.md) для ресурса [PlacementGroup](../../api-ref/PlacementGroup/index.md) или вызовом gRPC API [PlacementGroupService/Delete](../../api-ref/grpc/placement_group_service.md#Delete).

{% endlist %}
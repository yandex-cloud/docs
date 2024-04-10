# Добавить виртуальную машину в группу размещения

Добавьте существующую [ВМ](../../concepts/vm.md) в [группу размещения](../../concepts/placement-groups.md).

{% include [placement-groups-info.md](../../../_includes/compute/placement-groups-info.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит группа размещения.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/group-placement-pic.svg) **{{ ui-key.yacloud.compute.switch_placement-groups }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.compute.placement-groups.label_tab-instances }}**.
  1. Выберите группу размещения, в которую хотите добавить ВМ.
  1. Перейдите на панель **{{ ui-key.yacloud.compute.placement-group.switch_instances }}**.
  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/plus-sign.svg) **{{ ui-key.yacloud.compute.placement-group.instances.button_add-instance }}**.
  1. В открывшемся окне выберите ВМ и нажмите кнопку **{{ ui-key.yacloud.compute.placement-group.instances.popup-add_button_add }}**.

  {% note info %}

  В группу размещения можно добавить только [остановленную ВМ](../../concepts/vm-statuses.md) (`stopped`).

  {% endnote %}

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Создайте ВМ:

     ```bash
     yc compute instance create \
       --zone {{ region-id }}-a \
       --name instance-in-group-2
     ```

     Где:
     * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет размещена ВМ.
     * `--name` — имя ВМ.

     Результат:

     ```yaml
     id: epdlv1pp5401********
     ...
     ```

  1. Посмотрите список ВМ в группе размещения:

     ```bash
     yc compute placement-group list-instances \
       --name my-group
     ```

     Где `--name` — имя группы размещения.

     Результат:

     ```text
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     |          ID          |        NAME         |      ZONE ID      | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     | epdep2kq6dt5******** | instance-in-group-1 |   {{ region-id }}-a   | RUNNING |             | 10.129.0.5  |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     ```

  1. Остановите ВМ, указав в команде ее имя:

     ```bash
     yc compute instance stop instance-in-group-2
     ```

     Результат:

     ```yaml
     id: epdlv1pp5401********
     ...
     status: STOPPED
     ```

  1. Добавьте ВМ в группу размещения:

     ```bash
     yc compute instance update \
       --name instance-in-group-2 \
       --placement-group-name my-group \
       --placement-group-partition <номер_раздела>
     ```

     Где:
     * `--name` — имя ВМ.
     * `--placement-group-name` — имя группы размещения.
     * `--placement-group-partition` — номер раздела в группе размещения со стратегией [размещения разделами](../../concepts/placement-groups.md#partition).

       {% note info %}

       Если не указать номер раздела при добавлении ВМ в группу с размещением разделами, ВМ добавится в случайный раздел.

       {% endnote %}

     Результат:

     ```yaml
     id: epdlv1pp5401********
     ...
     placement_policy:
       placement_group_id: fd83bv4rnsna********
     ```

  1. Проверьте, что ВМ добавлена в группу размещения:

     ```bash
     yc compute placement-group list-instances \
       --name my-group
     ```

     Где `--name` — имя группы размещения.

     Результат:

     ```text
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     |          ID          |        NAME         |      ZONE ID      | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     | epdep2kq6dt5******** | instance-in-group-1 |   {{ region-id }}-a   | RUNNING |             | 10.129.0.5  |
     | epdlv1pp5401******** | instance-in-group-2 |   {{ region-id }}-a   | STOPPED |             | 10.129.0.30 |
     +----------------------+---------------------+-------------------+---------+-------------+-------------+
     ```

  1. Запустите ВМ, указав в команде ее имя:

     ```bash
     yc compute instance start instance-in-group-2
     ```

     Результат:

     ```text
     id: epdlv1pp5401********
     ...
     status: RUNNING
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы добавить существующую ВМ в группу размещения:
  1. Добавьте в конфигурационный файл существующей ВМ поле `placement_group_id` с указанием на ресурс группы размещения `yandex_compute_placement_group`.

     Пример структуры конфигурационного файла:

     ```hcl
     ...
     resource "yandex_compute_instance" "vm-1" {
       name        = "my-vm"
       platform_id = "standard-v3"
       placement_policy {
         placement_group_id = "${yandex_compute_placement_group.group1.id}"
       }
     }

     resource "yandex_compute_placement_group" "group1" {
       name = "test-pg"
     }
     ...
     ```

     Где `placement_group_id` — идентификатор группы размещения.

     {% note info %}

     Если не указать номер раздела при добавлении ВМ в группу с [размещением разделами](../../concepts/placement-groups.md#partition), ВМ добавится в случайный раздел.

     {% endnote %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_instance).
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

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить, что ВМ добавлена в группу размещения, можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/instance_service.md#Update).

{% endlist %}

## Смотрите также {#see-also}

* [Как создать ВМ в группе размещения](create-vm-in-pg.md).
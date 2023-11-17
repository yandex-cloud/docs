# Создать виртуальную машину в группе размещения

Создайте виртуальную машину в [группе размещения](../../concepts/placement-groups.md).

{% include [placement-groups-info.md](../../../_includes/compute/placement-groups-info.md) %}

{% list tabs %}

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания группы размещения:

     ```bash
     yc compute placement-group create --help
     ```

  1. Создайте группу размещения в каталоге по умолчанию с одной из стратегий размещения:

     {% include [pg-create](../../../_includes/compute/placement-groups-create.md) %}

  1. Посмотрите описание команды CLI для создания виртуальной машины:

     ```bash
     yc compute instance create --help
     ```

  1. Создайте виртуальную машину:

     ```bash
     yc compute instance create \
       --zone {{ region-id }}-a \
       --name instance-in-group-1 \
       --placement-group-name my-group \
       --placement-group-partition <номер_раздела>
     ```

     Где: 
     * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет размещена виртуальная машина.
     * `--name` — имя виртуальной машины.
     * `--placement-group-name` — имя группы размещения.
     * `--placement-group-partition` — номер раздела в группе размещения со стратегией [размещения разделами](../../concepts/placement-groups.md#partition).

       {% note info %}
       
       Если не указать номер раздела при создании ВМ в группе с размещением разделами, то ВМ добавится в случайный раздел.

       {% endnote %}

     Результат:

     ```yaml
     id: epdep2kq6dt5********
     ...
     placement_policy:
       placement_group_id: fd83bv4rnsna********
     ```

  1. Проверьте, что виртуальная машина создана и добавлена в группу размещения:

     ```bash
     yc compute placement-group list-instances --name my-group
     ```

     Где `--name` — имя группы размещения.

     Результат:

     ```text
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     |          ID          |        NAME         |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     | epdep2kq6dt5******** | instance-in-group-1 | {{ region-id }}-a | RUNNING |             | 10.129.0.5  |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     ```

- API

  Воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/instance_service.md#Create).

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы создать виртуальную машину в группе размещения:

  1. Опишите в конфигурационном файле [параметры виртуальной машины](../../operations/vm-create/create-linux-vm.md) с указанием на ресурс `yandex_compute_placement_group` в поле `placement_group_id`. Параметры виртуальной машины описывает ресурс `yandex_compute_instance`.

     Пример структуры конфигурационного файла:

     ```hcl
     ...
     resource "yandex_compute_instance" "vm-1" {
       name        = "linux-vm"
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

     Более подробную информацию о параметрах ресурсов `yandex_compute_instance` и `yandex_compute_placement_group` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_instance).

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.

  1. Проверьте конфигурацию командой:

     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить, что виртуальная машина создана и добавлена в группу размещения, можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

## Смотрите также {see-also}

* [Как добавить виртуальную машину в группу размещения](add-vm.md).
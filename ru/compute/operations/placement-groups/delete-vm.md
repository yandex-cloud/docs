# Исключить виртуальную машину из группы размещения

Исключите виртуальную машину из [группы размещения](../../concepts/placement-groups.md). 

Исключенную виртуальную машину можно [удалить насовсем](../vm-control/vm-delete.md), или [добавить обратно](add-vm.md) в группу размещения.

{% list tabs %}

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите список виртуальных машин в группе размещения:
  
     ```bash
     yc compute placement-group list-instances --name my-group
     ```

     Результат:

     ```bash
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     |          ID          |        NAME         |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     | epdep2kq6dt5uekuhcrd | instance-in-group-1 | {{ region-id }}-b | RUNNING |             | 10.129.0.5  |
     | epdlv1pp54019j09fhue | instance-in-group-2 | {{ region-id }}-b | RUNNING |             | 10.129.0.30 |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     ```
     
  1. Остановите виртуальную машину, которую необходимо исключить:
  
     ```bash
     yc compute instance stop instance-in-group-2
     ```

     Результат:

     ```bash
     id: epdlv1pp54019j09fhue
     ...
     status: STOPPED
     ```
  
  1. Исключите виртуальную машину из группы размещения. Для этого, обновите виртуальную машину, оставив имя группы размещения (`placement-group-name`) пустым:
     
     ```bash
     yc compute instance update --name instance-in-group-2 --placement-group-name=""
     ```  
  
  1. Проверьте, что виртуальная машина исключена из группы:
  
     ```bash
     yc compute placement-group list-instances --name my-group
     ```

     Результат:

     ```bash
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     |          ID          |        NAME         |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     | epdep2kq6dt5uekuhcrd | instance-in-group-1 | {{ region-id }}-b | RUNNING |             | 10.129.0.5  |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     ```  
     
- API

  Воспользуйтесь методом REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/instance_service.md#Update).

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы исключить виртуальную машину, созданную с помощью {{ TF }}, из группы размещения:

  1. Откройте конфигурационный файл виртуальной машины и удалите параметр `placement_group_id`.

     Пример структуры конфигурационного файла виртуальной машины:

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

     Проверить изменения можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

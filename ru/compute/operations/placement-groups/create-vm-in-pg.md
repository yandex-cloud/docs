# Создать виртуальную машину в группе размещения

Создайте виртуальную машину в [группе размещения](../../concepts/placement-groups.md).

{% list tabs %}

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания группы размещения:

     ```bash
     yc compute placement-group create --help
     ```

  1. Создайте группу размещения:

     ```bash
     yc compute placement-group create --spread-strategy --name my-group
     ```

     Результат:

     ```bash
     id: fdvte50kv3nclagfknoc
     folder_id: aoeieef3k7ppari05ajo
     created_at: "2019-12-20T08:59:44Z"
     name: my-group
     spread_placement_strategy: {}
     ```

     Данная команда создаст группу размещения со следующими характеристиками:

     - С именем `my-group`.
     - Стратегией размещения `spread`.

  1. Посмотрите описание команды CLI для создания виртуальной машины:

     ```bash
     yc compute instance create --help
     ```

  1. Создайте виртуальную машину:

     ```bash
     yc compute instance create --zone {{ region-id }}-a --name instance-in-group-1 --placement-group-name my-group
     ```

     Результат:

     ```bash
     id: epdep2kq6dt5uekuhcrd
     ...
     placement_policy:
       placement_group_id: fd83bv4rnsna2sjkiq4s
     ```

     Данная команда создаст виртуальную машину со следующими характеристиками:

     - С именем `instance-in-group-1`.
     - В зоне доступности `{{ region-id }}-a`.
     - В группе размещения `my-group`.

  1. Проверьте, что виртуальная машина создана и добавлена в группу размещения:

     ```bash
     yc compute placement-group list-instances --name my-group
     ```

     Результат:

     ```bash
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     |          ID          |        NAME         |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     | epdep2kq6dt5uekuhcrd | instance-in-group-1 | {{ region-id }}-a | RUNNING |             | 10.129.0.5  |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     ```

- API

  Воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/instance_service.md#Create).

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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
# Добавить виртуальную машину в группу размещения

Добавьте существующую виртуальную машину в [группу размещения](../../concepts/placement-groups.md).

{% list tabs %}

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Создайте виртуальную машину:

     ```bash
     yc compute instance create --zone {{ region-id }}-a --name instance-in-group-2
     ```

     Результат:

     ```bash
     id: epdlv1pp54019j09fhue
     ...
     ```

     Данная команда создаст виртуальную машину со следующими характеристиками:

     - С именем `instance-in-group-2`.
     - В зоне доступности `{{ region-id }}-a`.

  1. Посмотрите список виртуальных машин в группе размещения:

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

  1. Остановите виртуальную машину:

     ```bash
     yc compute instance stop instance-in-group-2
     ```

     Результат:

     ```bash
     id: epdlv1pp54019j09fhue
     ...
     status: STOPPED
     ```

  1. Добавьте виртуальную машину в группу размещения:

     ```bash
     yc compute instance update --name instance-in-group-2 --placement-group-name my-group
     ```

     Результат:

     ```bash
     id: epdlv1pp54019j09fhue
     ...
     placement_policy:
       placement_group_id: fd83bv4rnsna2sjkiq4s
     ```

     Данная команда добавит виртуальную машину `instance-in-group-2` в группу размещения `my-group`.

  1. Проверьте, что виртуальная машина добавлена в группу размещения:

     ```bash
     yc compute placement-group list-instances --name my-group
     ```

     Результат:

     ```bash
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     |          ID          |        NAME         |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     | epdep2kq6dt5uekuhcrd | instance-in-group-1 | {{ region-id }}-b | RUNNING |             | 10.129.0.5  |
     | epdlv1pp54019j09fhue | instance-in-group-2 | {{ region-id }}-b | STOPPED |             | 10.129.0.30 |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     ```

  1. Запустите виртуальную машину:

     ```bash
     yc compute instance start instance-in-group-2
     ```

     Результат:

     ```bash
     id: epdlv1pp54019j09fhue
     ...
     status: RUNNING
     ```

- API

  Воспользуйтесь методом API [update](../../api-ref/Instance/update.md).

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы добавить существующую виртуальную машину в группу размещения:

  1. Добавьте в конфигурационный файл существующей [виртуальной машины](../../operations/vm-create/create-linux-vm.md) поле `placement_group_id` с указанием на ресурс группы размещения `yandex_compute_placement_group`.

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

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/compute_instance).

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

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить, что виртуальная машина добавлена в группу размещения, можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

## Смотрите также {#see-also}

* [Как создать виртуальную машину в группе размещения](create-vm-in-pg.md).

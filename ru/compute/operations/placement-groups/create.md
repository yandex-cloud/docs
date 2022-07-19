# Создать группу размещения

Создайте [группу размещения](../../concepts/placement-groups.md).

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
     id: fd83bv4rnsna2sjkiq4s
     folder_id: b1g5kkhshgs9s0l4609d
     created_at: "2019-12-30T10:07:34Z"
     name: my-group
     spread_placement_strategy: {}
     ```

     Данная команда создаст группу размещения со следующими характеристиками:

     - С именем `my-group`.
     - Стратегией распределенного размещения (`spread`).

   1. Проверьте, что группа размещения добавлена:

      ```bash
      yc compute placement-group list
      ```

      Результат:

      ```bash
      +----------------------+----------+----------+
      |          ID          |   NAME   | STRATEGY |
      +----------------------+----------+----------+
      | fd83bv4rnsna2sjkiq4s | my-group | SPREAD   |
      +----------------------+----------+----------+
      ```

- API

  Воспользуйтесь методом API [create](../../api-ref/PlacementGroup/create.md).

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры группы размещения:

     * `name` — имя группы размещения. Формат имени:

        {% include [name-format](../../../_includes/name-format.md) %}

     * `folder_id` — идентификатор каталога, в котором создается группа размещения.
     * `description` — описание группы размещения.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_compute_placement_group" "group1" {
       name        = "<имя группы размещения>"
       folder_id   = "<идентификатор каталога>"
       description = "<описание группы размещения>"
     }
     ```

     Более подробную информацию о параметрах ресурса `yandex_compute_placement_group` в {{ TF }} см. в [документации провайдера]({{ tf-provider-link }}/compute_placement_group).

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

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
     yc compute placement-group list
     ```

{% endlist %}

## Смотрите также {see-also}

* [Как добавить виртуальную машину в группу размещения](add-vm.md).
* [Как создать виртуальную машину в группе размещения](create-vm-in-pg.md).
# Создать группу размещения

Создайте [группу размещения](../../concepts/placement-groups.md).

{% include [placement-groups-info.md](../../../_includes/compute/placement-groups-info.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана группа размещения.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/group-placement-pic.svg) **{{ ui-key.yacloud.compute.switch_placement-groups }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.compute.placement-groups.label_tab-instances }}**.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.compute.placement-groups.button_create }}** и выберите **{{ ui-key.yacloud.compute.placement-groups.button_menu-create-instance-placement-group }}**.
  1. Введите имя группы размещения. Требования к имени:

     {% include [name-format](../../../_includes/name-format.md) %}

  1. (Опционально) Добавьте описание группы размещения.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/) для создания группы размещения:

     ```bash
     yc compute placement-group create --help
     ```

  1. Создайте группу размещения в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию с одной из стратегий размещения:

     {% include [pg-create](../../../_includes/compute/placement-groups-create.md) %}

  1. Проверьте, что группа размещения добавлена:

     ```bash
     yc compute placement-group list
     ```

     Результат:

     ```text
     +----------------------+----------+----------+
     |          ID          |   NAME   | STRATEGY |
     +----------------------+----------+----------+
     | fd83bv4rnsna******** | my-group | SPREAD   |
     +----------------------+----------+----------+
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры группы размещения:
     * `name` — имя группы размещения. Формат имени:

       {% include [name-format](../../../_includes/name-format.md) %}

     * `folder_id` — идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается группа размещения.
     * `description` — описание группы размещения.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_compute_placement_group" "group1" {
       name        = "<имя_группы_размещения>"
       folder_id   = "<идентификатор_каталога>"
       description = "<описание_группы_размещения>"
     }
     ```

     Более подробную информацию о параметрах ресурса `yandex_compute_placement_group` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_placement_group).
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

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     yc compute placement-group list
     ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/PlacementGroup/create.md) для ресурса [PlacementGroup](../../api-ref/PlacementGroup/index.md) или вызовом gRPC API [PlacementGroupService/Create](../../api-ref/grpc/placement_group_service.md#Create).

{% endlist %}

## Смотрите также {see-also}

* [Как добавить виртуальную машину в группу размещения](add-vm.md).
* [Как создать ВМ в группе размещения](create-vm-in-pg.md).
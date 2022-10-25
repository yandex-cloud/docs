# Создать группу размещения дисков

Создайте [группу размещения](../../concepts/disk-placement-group.md) для нереплицируемых дисков.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать группу размещения дисков.
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/group-placement-pic.svg) **Группы размещений**.
  1. Перейдите на вкладку **Группы размещения нереплицируемых дисков**.
  1. Нажмите кнопку **Создать группу размещения нереплицируемых дисков**.
  1. Введите имя группы.

      {% include [name-format](../../../_includes/name-format.md) %}

  1. Если требуется, добавьте произвольное описание группы.
  1. Укажите [зону доступности](../../../overview/concepts/geo-scope.md).
     
          
     {% include [nrd-az](../../../_includes/compute/nrd-az.md) %}
     
     
  1. Нажмите кнопку **Создать**.

- CLI

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команд CLI для создания группы размещения дисков:
  
      ```bash
      yc compute disk-placement-group create --help
      ```
  
  1. Создайте группу в каталоге по умолчанию:
  
      ```bash
      yc compute disk-placement-group create \
        --name first-group \
        --description "first disk placement group"
      ```
  
      Будет создана группа размещения дисков с именем `first-group` и описанием `first disk placement group`.
  
  1. Получите список групп размещения дисков в каталоге по умолчанию:
  
      ```bash
      yc compute disk-placement-group list
      ```

      Результат:

      ```text
      +----------------------+-------------+---------------+--------+
      |          ID          |    NAME     |     ZONE      | STATUS |
      +----------------------+-------------+---------------+--------+
      | epd4sug6keskb72ub9m7 | first-group | {{ region-id }}-b | READY  |
      +----------------------+-------------+---------------+--------+
      ```

  1. Получите информацию о созданной группе:

      ```bash
      yc compute disk-placement-group get \
        --name first-group
      ```

      Результат:

      ```text
      id: epd4sug6keskb72ub9m7
      folder_id: w3qrbj9swotyns6oiyny
      created_at: "2021-03-23T12:49:59Z"
      name: first-group
      description: first disk placement group
      zone_id: {{ region-id }}-b
      status: READY
      spread_placement_strategy: {}
      ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры группы размещения дисков:

     ```hcl
     resource "yandex_compute_disk_placement_group" "group1" {
       name        = "<имя_группы_размещения_дисков>"
       folder_id   = "<идентификатор_каталога>"
       description = "<описание_группы_размещения_дисков>"
       zone        = "<зона_доступности>"
     }
     ```

     Где:
     * `name` — имя группы размещения дисков. Формат имени:

          {% include [name-format](../../../_includes/name-format.md) %}

     * `folder_id` — идентификатор каталога, в котором создается группа размещения дисков.
     * `description` — описание группы размещения дисков.
     * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md). Рекомендуется создавать группы размещения дисков в зонах доступности `{{ region-id }}-a` или `{{ region-id }}-b`.

     Более подробную информацию о параметрах ресурса `yandex_compute_disk_placement_group` в {{ TF }} см. в [документации провайдера]({{ tf-provider-link }}/compute_disk_placement_group).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

        ```bash
        yc compute disk-placement-group list
        ```

{% endlist %}

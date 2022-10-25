# Создать нереплицируемый диск

Вы можете создать отдельный [нереплицируемый](../../concepts/disk.md#nr-disks) диск, либо добавить его в группу размещения дисков.

Размер диска должен быть кратен 93 ГБ.

## Создать отдельный нереплицируемый диск {#nr-disk}

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать диск.
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/disks-pic.svg) **Диски**.
  1. Нажмите кнопку **Создать диск**.
  1. Введите имя диска.
  
      {% include [name-format](../../../_includes/name-format.md) %}
  
  1. Если требуется, добавьте произвольное описание диска.
  1. Выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться диск.
     
          
     {% include [nrd-az](../../../_includes/compute/nrd-az.md) %}
     
     
  1. Укажите тип диска **Нереплицируемый SSD**.
  1. Выберите нужный размер блока.
  1. Задайте нужный размер диска.
  1. Если требуется, выберите [расписание](../../concepts/snapshot-schedule.md), по которому для диска будут автоматически создаваться [снимки](../../concepts/snapshot.md), или создайте его. Подробнее о настройках расписания см. в [инструкции](../snapshot-control/create-schedule.md).

     При создании диска для него можно выбрать только одно расписание снимков. Если требуется, после создания диска вы можете добавить к нему еще несколько расписаний по [инструкции](../disk-control/configure-schedule.md#add-schedule).
  
  1. Нажмите кнопку **Создать диск**.

- CLI
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для создания дисков:
  
      ```bash
      yc compute disk create --help
      ```
  
  1. Чтобы создать нереплицируемый диск с именем `nr-disk`, выполните команду:

      ```bash
      yc compute disk create \
        --name nr-disk \
        --type network-ssd-nonreplicated \
        --size 93 
      ```

      Результат:

      ```text
      done (1s)
      id: epdb2517b9709hkifodg
      folder_id: b1g7gvsi89m34qmcm3ke
      created_at: "2021-03-10T10:03:31Z"
      name: nr-disk
      type_id: network-ssd-nonreplicated
      zone_id: {{ region-id }}-b
      size: "99857989632"
      block_size: "4096"
      status: READY
      disk_placement_policy: {}
      ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры нереплицируемого диска:

     ```hcl
     resource "yandex_compute_disk" "nr" {
       name       = "<имя_нереплицируемого_диска>"
       size       = <размер_нереплицируемого_диска>
       block_size = <размер_блока>
       type       = "network-ssd-nonreplicated"
       zone       = "<зона_доступности>"
     }
     ```

     Где:
     * `name` — имя нереплицируемого диска. Формат имени:

          {% include [name-format](../../../_includes/name-format.md) %}

     * `size` — размер нереплицируемого диска, должен быть кратен 93 ГБ.
     * `block_size` — размер блока в байтах (минимальный объем хранения информации на диске). Максимальный размер диска зависит от заданного размера блока. По умолчанию размер блоков всех создаваемых дисков равен 4 КБ, однако для дисков больше 8 ТБ этого недостаточно. Подробнее см. в разделе [{#T}](../../../compute/operations/disk-create/empty-disk-blocksize.md).
     * `type` — тип создаваемого диска. Укажите `network-ssd-nonreplicated` для создания нереплицируемого диска.
     * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md). 
        
         {% include [nrd-az](../../../_includes/compute/nrd-az.md) %}  

     Более подробную информацию о параметрах ресурса `yandex_compute_disk` в {{ TF }} см. в [документации провайдера]({{ tf-provider-link }}/compute_disk#example-usage---non-replicated-disk).

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
        yc compute disk list
        ```

{% endlist %}

## Создать нереплицируемый диск в группе размещения {#nr-disk-in-group}

Диск можно создать только в существующей группе размещения дисков.

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать диск.
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/disks-pic.svg) **Диски**.
  1. Нажмите кнопку **Создать диск**.
  1. Введите имя диска.
  
      {% include [name-format](../../../_includes/name-format.md) %}
  
  1. Если требуется, добавьте произвольное описание диска.
  1. Выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться диск.

     Зона доступности для диска должна соответствовать зоне группы размещения, в которой вы хотите создать диск.
  1. Укажите тип диска **Нереплицируемый SSD**.
  1. Выберите группу размещения дисков.
  1. Задайте нужный размер диска.
  1. Если требуется, выберите [расписание](../../concepts/snapshot-schedule.md), по которому для диска будут автоматически создаваться [снимки](../../concepts/snapshot.md), или создайте его. Подробнее о настройках расписания см. в [инструкции](../snapshot-control/create-schedule.md).
  
     Если вы хотите указать еще одно расписание, вы сможете [добавить](../disk-control/configure-schedule.md#add-schedule) его после создания диска.
  
  1. Нажмите кнопку **Создать диск**.

- CLI
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для создания дисков:
  
      ```bash
      yc compute disk create --help
      ```

  1. Чтобы создать нереплицируемый диск в группе размещения дисков с именем `my-group`, выполните команду:

      ```bash
      yc compute disk create \
        --name nr-disk \
        --type network-ssd-nonreplicated \
        --size 93 \
        --disk-placement-group-name my-group
      ```

      Результат:

      ```text
      done (1s)
      id: epdtncic35rug5570q1p
      folder_id: b1g7gvsi89m34qmcm3ke
      created_at: "2021-03-10T11:17:57Z"
      name: nr-disk
      type_id: network-ssd-nonreplicated
      zone_id: {{ region-id }}-b
      size: "99857989632"
      block_size: "4096"
      status: READY
      disk_placement_policy:
        placement_group_id: epdn946ilslhiug1vh7v
      ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры нереплицируемого диска с указанием на группу размещения дисков в поле `disk_placement_group_id`:

     ```hcl
     resource "yandex_compute_disk" "nr" {
       name       = "non-replicated-disk-name"
       size       = 93
       block_size = 4096
       type       = "network-ssd-nonreplicated"
       zone       = "{{ region-id }}-b"
	   disk_placement_policy {
         disk_placement_group_id = yandex_compute_disk_placement_group.this.id
       }
     }

	 resource "yandex_compute_disk_placement_group" "this" {
       zone = "{{ region-id }}-b"
     }
     ```

     Где:
     * `name` — имя нереплицируемого диска. Формат имени:

          {% include [name-format](../../../_includes/name-format.md) %}

     * `size` — размер нереплицируемого диска, должен быть кратен 93 ГБ.
     * `block_size` — размер блока в байтах (минимальный объем хранения информации на диске). Максимальный размер диска зависит от заданного размера блока. По умолчанию размер блоков всех создаваемых дисков равен 4 КБ, однако для дисков больше 8 ТБ этого недостаточно. Подробнее см. в разделе [{#T}](../../../compute/operations/disk-create/empty-disk-blocksize.md).
     * `type` — тип создаваемого диска. Укажите `network-ssd-nonreplicated` для создания нереплицируемого диска.
     * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md). Зона доступности для диска должна соответствовать зоне группы размещения, в которой вы хотите создать диск.

         {% include [nrd-az](../../../_includes/compute/nrd-az.md) %}  

     * `disk_placement_group_id` — идентификатор группы размещения дисков.

     Более подробную информацию о параметрах ресурса `yandex_compute_disk` в {{ TF }} см. в [документации провайдера]({{ tf-provider-link }}/compute_disk#example-usage---non-replicated-disk).

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
        yc compute disk list
        ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](../snapshot-control/create-schedule.md)

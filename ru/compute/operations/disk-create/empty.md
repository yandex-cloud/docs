# Создать пустой диск

Вы можете создать пустой диск заданного размера.

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
  1. Выберите нужный тип диска: `HDD`, `SSD` или `Нереплицируемый SSD`.
  1. Выберите нужный размер блока.
  1. Укажите нужный размер диска.
  1. Если требуется, выберите [расписание](../../concepts/snapshot-schedule.md), по которому для диска будут автоматически создаваться [снимки](../../concepts/snapshot.md), или создайте его. Подробнее о настройках расписания см. в [инструкции](../snapshot-control/create-schedule.md).
  
     {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

     При создании диска для него можно выбрать только одно расписание снимков. Если требуется, после создания диска вы можете добавить к нему еще несколько расписаний по [инструкции](../disk-control/configure-schedule.md#add-schedule).
 
  1. Нажмите кнопку **Создать диск**.
  
- CLI
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команд CLI для создания дисков:
  
      ```
      yc compute disk create --help
      ```
  
  1. Создайте диск в каталоге по умолчанию:
  
      ```
      yc compute disk create \
        --name first-disk \
        --size 10 \
        --description "my first disk via yc"
      ```
  
      Данная команда создаст диск размером 10 ГБ с именем `first-disk` и описанием `my first disk via yc`.
  
      {% include [name-format](../../../_includes/name-format.md) %}
  
  1. Получите список дисков в каталоге по умолчанию:
  
      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}
  
      Получите тот же список c большим количеством деталей в формате YAML:
  
      ```
      yc compute disk list --format yaml
      ```

      Результат:
      ```yaml
      - id: fhm4aq4hvq5g3nepvt9b
          folder_id: b1gm3og7ei7aegv8i73m
          created_at: "2018-10-29T07:43:06Z"
          name: first-disk
          description: my first disk via yc
          type_id: network-hdd
          zone_id: {{ region-id }}-a
          size: "10737418240"
          status: READY
      - id: fhmo6rdqg5folrc3lsaf
          folder_id: b1gm3og7ei7aegv8i73m
          created_at: "2018-10-29T07:33:04Z"
          name: second-disk
          description: my second disk via yc
          type_id: network-hdd
          zone_id: {{ region-id }}-a
          size: "8589934592"
          product_ids:
          - f2en2dtd08b5la74mlde
          status: READY
          source_image_id: fdvk34al8k5nltb58shr
          instance_ids:
          - fhm5b617fjnj44ovhcun
      ```

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).  

  Чтобы создать пустой диск:

  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_disk`.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_compute_disk" "disk-1" {
       name       = "empty-disk"
       type       = "network-hdd"
       zone       = "<зона_доступности>"
       size       = <размер_диска>
       block_size = <размер_блока>
     }
     ```

     Где:
     * `name` — имя диска. Формат имени:

          {% include [name-format](../../../_includes/name-format.md) %}

     * `type` — тип создаваемого диска.
     * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md). Зона доступности для диска должна соответствовать зоне группы размещения, в которой вы хотите создать диск. {% if product == "yandex-cloud" %}Рекомендуется создавать диски в зонах доступности `{{ region-id }}-a` или `{{ region-id }}-b`.{% endif %}
     * `size` — размер диска в ГБ.
     * `block_size` — размер блока в байтах (минимальный объем хранения информации на диске). Максимальный размер диска зависит от заданного размера блока. По умолчанию размер блоков всех создаваемых дисков равен 4 КБ, однако для дисков больше 8 ТБ этого недостаточно. Подробнее см. в разделе [{#T}](../../../compute/operations/disk-create/empty-disk-blocksize.md).

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

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

     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

        ```bash
        yc compute disk list
        ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](../snapshot-control/create-schedule.md)

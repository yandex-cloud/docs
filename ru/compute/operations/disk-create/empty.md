# Создать пустой диск

Вы можете создать пустой диск заданного размера.

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать диск.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/disks-pic.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.disks.button_create }}**.
  1. Введите имя диска. Требования к имени:
  
      {% include [name-format](../../../_includes/name-format.md) %}
  
  1. Если требуется, добавьте произвольное описание диска.
  1. Выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться диск.
  1. Выберите нужный тип диска: `{{ ui-key.yacloud.compute.instances.create-disk.value_network-hdd }}`, `{{ ui-key.yacloud.compute.instances.create-disk.value_network-ssd }}`, `{{ ui-key.yacloud.compute.instances.create-disk.value_network-ssd-io-m3 }}` или `{{ ui-key.yacloud.compute.instances.create-disk.value_network-ssd-nonreplicated }}`.
  1. Выберите нужный размер блока (минимальный объем хранения информации на диске). По умолчанию размер блоков всех создаваемых дисков равен 4 КБ, однако для дисков больше 8 ТБ этого недостаточно.
  1. Укажите нужный размер диска. Максимальный размер диска зависит от заданного размера блока.

  
  1. {% include [encryption-section-without-sa](../../../_includes/compute/encryption-section-without-sa.md) %}


  1. Если требуется, выберите [расписание](../../concepts/snapshot-schedule.md), по которому для диска будут автоматически создаваться [снимки](../../concepts/snapshot.md), или создайте его. Подробнее о настройках расписания см. в [инструкции](../snapshot-control/create-schedule.md).
  
     {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

     При создании диска для него можно выбрать только одно расписание снимков. Если требуется, после создания диска вы можете добавить к нему еще несколько расписаний по [инструкции](../disk-control/configure-schedule.md#add-schedule).
 
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.disks.create.button_create }}**.
  
- CLI
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команд CLI для создания дисков:
  
      ```bash
      yc compute disk create --help
      ```
  
  1. Создайте диск в каталоге по умолчанию:
  
      ```bash
      yc compute disk create \
        --name first-disk \
        --size 10 \
        --description "my first disk via yc"
      ```
  
      Данная команда создаст диск размером 10 ГБ с именем `first-disk` и описанием `my first disk via yc`.

      Требования к имени диска:
  
      {% include [name-format](../../../_includes/name-format.md) %}
  
  1. Получите список дисков в каталоге по умолчанию:
  
      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}
  
      Получите тот же список с большим количеством деталей в формате YAML:
  
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

- API

  Воспользуйтесь методом REST API [create](../../api-ref/Disk/create.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/Create](../../api-ref/grpc/disk_service.md#Create).

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% include [terraform-empty-disk-create](../../../_includes/compute/terraform-empty-disk-create.md) %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](../snapshot-control/create-schedule.md)

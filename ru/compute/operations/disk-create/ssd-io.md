# Создать высокопроизводительный SSD-диск

Вы можете создать отдельный [высокопроизводительный](../../concepts/disk.md#nr-disks) SSD-диск, который сочетает скорость нереплицируемого диска с избыточностью.

Размер диска должен быть кратен 93 ГБ.

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
     
          
     {% include [nrd-az](../../../_includes/compute/nrd-az.md) %}
     
     
  1. Укажите тип диска `{{ ui-key.yacloud.compute.instances.create-disk.value_network-ssd-io-m3 }}`.
  1. Выберите нужный размер блока.
  1. Задайте нужный размер диска.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.disks.button_create }}**.

- CLI
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для создания дисков:
  
      ```bash
      yc compute disk create --help
      ```
  
  1. Чтобы создать высокопроизводительный диск с именем `ssd-io-disk`, выполните команду:

      ```bash
      yc compute disk create \
        --name ssd-io-disk \
        --zone ru-central1-a \
        --type network-ssd-io-m3 \
        --size 93G
      ```

      Результат:

      ```text
      id: a7li08c1************
      folder_id: aoerb349************
      created_at: "2023-07-18T14:42:21Z"
      name: ssd-io-disk
      type_id: network-ssd-io-m3
      zone_id: ru-central1-a
      size: "99857989632"
      block_size: "4096"
      status: READY
      disk_placement_policy: {}
      ```

- API

  Воспользуйтесь методом REST API [create](../../api-ref/Disk/create.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/Create](../../api-ref/grpc/disk_service.md#Create).

{% endlist %}
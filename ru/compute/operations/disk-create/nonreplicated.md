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

{% endlist %}

#### См. также {#see-also}

* [{#T}](../snapshot-control/create-schedule.md)

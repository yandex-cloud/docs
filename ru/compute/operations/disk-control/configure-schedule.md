# Настроить создание снимков диска по расписаниям

Вы можете настроить для диска [расписания](../../concepts/snapshot-schedule.md), по которым будут создаваться [снимки](../../concepts/snapshot.md):

* [{#T}](#add-schedule).
* [{#T}](#remove-schedule).

## Добавить расписание к диску {#add-schedule}

{% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится диск.
  1. Выберите сервис **{{ compute-name }}**.
  1. Откройте вкладку ![image](../../../_assets/compute/disks-pic.svg) **Диски** и выберите диск.
  1. В разделе **Расписания снимков** нажмите ![image](../../../_assets/plus.svg) **Добавить расписание**.
  1. Выберите расписание или создайте новое. Подробнее о настройках расписания см. в [инструкции](../snapshot-control/create-schedule.md).
  1. Нажмите **Сохранить**.

{% endlist %}

## Отвязать расписание от диска {#remove-schedule}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится диск.
  1. Выберите сервис **{{ compute-name }}**.
  1. Откройте вкладку ![image](../../../_assets/compute/disks-pic.svg) **Диски** и выберите диск.
  1. В разделе **Расписания снимков** в строке с расписанием нажмите кнопку ![image](../../../_assets/horizontal-ellipsis.svg) и выберите **Отвязать от диска**.

{% endlist %}


#### См. также {#see-also}

* [{#T}](../snapshot-control/create-schedule.md)
* [Изменить список дисков в расписании снимков](../snapshot-control/update-schedule.md#update-disk-list)
* [Создать снимок диска вручную](../disk-control/create-snapshot.md)

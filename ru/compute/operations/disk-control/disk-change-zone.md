---
title: "Как перенести диск в другую зону доступности в {{ compute-full-name }}"
description: "Следуя данной инструкции, вы сможете перенести диск в другую зону доступности." 
---

# Перенести диск в другую зону доступности

Диск создается в одной [зоне доступности](../../../overview/concepts/geo-scope.md). Вы можете перенести его в другую зону с помощью [снимка](../../concepts/snapshot.md), а также с помощью специальной команды в [консоли управления]({{ link-console-main }}) или [CLI](../../../cli/cli-ref/managed-services/compute/disk/relocate.md)

Если диск подключен к ВМ, он будет перенесен при [миграции ВМ](../vm-control/vm-change-zone.md). Мигрировать подключенные диски отдельно от ВМ нельзя. 


{% include [relocate-note](../../../_includes/compute/relocate-note.md) %}


## Перенести диск с помощью создания снимка {#relocate-via-snapshot}

### Подготовьте диски {#prepare-disks}

{% include [prepare-snapshots](../../../_includes/compute/prepare-snapshots.md) %}

### Создайте снимки {#create}

Чтобы [создать](../disk-control/create-snapshot.md) снимок диска:

{% include [create-snapshot](../../../_includes/compute/create-snapshot.md) %}

Аналогичным образом создайте снимки всех дисков.

### Создайте виртуальную машину в другой зоне доступности с дисками из снимков {#create-vm}

Чтобы [создать](../vm-create/create-from-snapshots.md) виртуальную машину в другой зоне доступности с дисками из снимков:

{% include [create-from-snapshot](../../../_includes/compute/create-from-snapshot.md) %}

## Перенести диск с помощью специальной команды {#relocate-command}

{% note info %}

Если на диск активно ведется запись, его перенос может завершиться ошибкой. В таком случае остановите запись на диск или выключите виртуальную машину и запустите перенос еще раз.

{% endnote %}

Чтобы присоединить диск к виртуальной машине из другой зоны, перенесите его:

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% note warning %}

  В настоящий момент консоль управления позволяет переносить диски только из зоны доступности `{{ region-id }}-c`. Для того чтобы перенести диски из других зон доступности, используйте CLI или снимки.

  {% endnote %}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
  1. В строке с нужным диском нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.compute.button_relocate-to-another-zone }}**. В открывшемся окне:
      1. В поле **{{ ui-key.yacloud.compute.field_new-availability-zone }}** выберите зону доступности, в которую необходимо перенести диск, например `{{ region-id }}-d`.
      1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_start-instance-relocation }}**, чтобы запустить процесс переноса диска в другую зону доступности.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для переноса диска:

     ```bash
     {{ yc-compute }} disk relocate --help
     ```

  1. Запросите список доступных дисков:

     {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

  1. Выберите идентификатор (`ID`) нужного диска.

  1. Перенесите диск в другую зону доступности:

      ```bash
      {{ yc-compute }} disk relocate --id <идентификатор_диска> \
        --destination-zone-id <зона_доступности>
      ```

      Где:

      * `--id` — идентификатор диска, который нужно перенести.
      * `--destination-zone-id` — идентификатор зоны, в которую нужно перенести диск. Например `{{ region-id }}-a`.

      Если вы переносите [диск в группе размещения](../../concepts/disk-placement-group.md), передайте ее идентификатор в параметре `--disk-placement-group-id`.

{% endlist %}

{% note info %}

Продолжительность операции переноса в другую зону доступности зависит от размера диска. Перенос диска размером 100 ГБ занимает приблизительно 10 минут.

В некоторых случаях при переносе в зону доступности `{{ region-id }}-d` процесс может занять больше времени.

{% endnote %}
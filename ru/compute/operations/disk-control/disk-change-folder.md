# Перенести диск в другой каталог

При создании диска он размещается в текущем каталоге.

В {{ yandex-cloud }} есть возможность переместить диск в другой каталог внутри одного облака.

[Подробнее об иерархии ресурсов в {{ yandex-cloud }}](../../../resource-manager/concepts/resources-hierarchy.md).

## Ограничения {#limits}

Ограничения при переносе диска:  

* Метрики в [{{ monitoring-full-name }}](../../../monitoring/) не переносятся. То, что было в предыдущем каталоге, останется в нем, новые метрики будут создаваться уже в новом каталоге.
* Перенос возможен только внутри одного облака.

## Перенести диск {#change-folder}

Чтобы изменить каталог диска:

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Получите список всех дисков в каталоге по умолчанию:

      ```bash
      yc compute disk list
      ```

      Результат:

      ```bash
      +----------------------+--------------+-------------+---------------+--------+----------------------+-------------------------+
      |          ID          |     NAME     |    SIZE     |     ZONE      | STATUS |     INSTANCE IDS     |       DESCRIPTION       |
      +----------------------+--------------+-------------+---------------+--------+----------------------+-------------------------+
      | a7lqgbt0bb9s40tifuhc | first-disk   | 20401094656 | {{ region-id }}-a | READY  | a7lcvu28njbhnkcteb5n |                         |
      | a7lv5j5hm1p1hppprga7 | second-disk  | 21474836480 | {{ region-id }}-a | READY  |                      |                         |
      +----------------------+--------------+-------------+---------------+--------+----------------------+-------------------------+
      ```      

  1. Получите список всех каталогов в облаке по умолчанию:

      ```bash
      yc resource-manager folder list
      ```

      Результат:

      ```bash
      +----------------------+--------------------+------------------+--------+
      |          ID          |        NAME        |      LABELS      | STATUS |
      +----------------------+--------------------+------------------+--------+
      | b1gd129pp9ha0vnvf5g7 | my-folder          |                  | ACTIVE |
      | b1g66mft1vopnevbn57j | default            |                  | ACTIVE |
      +----------------------+--------------------+------------------+--------+
      ```

  1. Посмотрите описание команды CLI для переноса диска:

      ```bash
      yc compute disk move --help
      ```

  1. Перенесите диск в другой каталог со следующими параметрами:

      ```bash
      yc compute disk move \
        --id a7lqgbt0bb9s40tifuhc \
        --destination-folder-id b1gd129pp9ha0vnvf5g7
      ```

      Где:

      * `id` – идентификатор диска, например `a7lqgbt0bb9s40tifuhc`.
      * `destination-folder-id` – идентификатор целевого каталога, например `b1gd129pp9ha0vnvf5g7`.

      Подробнее о команде `yc compute disk move` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/disk/move.md).

- API

  Воспользуйтесь методом REST API [move](../../api-ref/Disk/move.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/Move](../../api-ref/grpc/disk_service.md#Move).

{% endlist %}

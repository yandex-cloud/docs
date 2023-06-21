# Перенести виртуальную машину в другой каталог

При создании виртуальной машины она размещается в текущем каталоге.

В {{ yandex-cloud }} есть возможность переместить виртуальную машину в другой каталог внутри одного облака. Останавливать виртуальную машину при переносе не обязательно.

[Подробнее об иерархии ресурсов в {{ yandex-cloud }}](../../../resource-manager/concepts/resources-hierarchy.md).

## Ограничения {#limits}

Ограничения при переносе виртуальной машины:

* Метрики в [{{ monitoring-full-name }}](../../../monitoring/) не переносятся. То, что было в предыдущем каталоге, останется в нем, новые метрики будут создаваться уже в новом каталоге.
* Перенос возможен только внутри одного облака.

## Перенести виртуальную машину {#change-folder}

Чтобы изменить каталог виртуальной машины:

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Получите список всех виртуальных машин в каталоге по умолчанию:

      ```bash
      yc compute instance list
      ```

      Результат:

      ```bash
      +----------------------+-----------------+---------------+---------+----------------------+
      |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
      +----------------------+-----------------+---------------+---------+----------------------+
      | fhm0b28lgfp4tkoa3jl6 | first-instance  | {{ region-id }}-a | RUNNING | my first vm via CLI  |
      | fhm9gk85nj7gcoji2f8s | second-instance | {{ region-id }}-a | RUNNING | my second vm via CLI |
      +----------------------+-----------------+---------------+---------+----------------------+
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

  1. Посмотрите описание команды CLI для переноса виртуальной машины:

      ```bash
      yc compute instance move --help
      ```

  1. Перенесите виртуальную машину в другой каталог со следующими параметрами: 
      
      * в параметре `id` укажите идентификатор виртуальной машины, например `fhm0b28lgfp4tkoa3jl6`;
      * в параметре `destination-folder-id` укажите идентификатор целевого каталога, например `b1gd129pp9ha0vnvf5g7`.

      ```bash
      yc compute instance move \
        --id fhm0b28lgfp4tkoa3jl6 \
        --destination-folder-id b1gd129pp9ha0vnvf5g7
      ```

      Подробнее о команде `yc compute instance move` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/instance/move.md).

- API

  Воспользуйтесь методом REST API [move](../../api-ref/Instance/move.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Move](../../api-ref/grpc/instance_service.md#Move).

{% endlist %}

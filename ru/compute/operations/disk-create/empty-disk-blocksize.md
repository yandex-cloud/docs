# Создать пустой диcк с блоком большого размера
 
По умолчанию размер блоков всех создаваемых дисков равен 4 КБ, однако для дисков больше 8 ТБ этого недостаточно. Вы можете задать размеры блока при создании пустого диска. Изменить размеры блока после создания диска нельзя.

Максимальный размер диска зависит от заданного размера блока. 

Размер блока | Максимальный размер диска
---- | ----
4 КБ | 8 ТБ
8 КБ | 16 ТБ
16 КБ | 32 ТБ
32 КБ | 64 ТБ
64 КБ | 128 ТБ
128 КБ | 256 ТБ

{% list tabs %}

- CLI

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команд CLI для создания дисков:

        ```bash
        yc compute disk create --help
        ```

    1. Создайте диск в каталоге по умолчанию:

        ```bash
        yc compute disk create \
            --name big-disk \
            --block-size 8K \
            --size 40G \
            --description "my 8k blocksize disk via yc"
        ```

       Данная команда создаст диск размером 40 ГБ и размером блока 8 КБ, с именем `big-disk` и описанием `my 8k blocksize disk via yc`.

       {% include [name-format](../../../_includes/name-format.md) %}

    1. Получите список дисков в каталоге по умолчанию:

       {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

       Получите тот же список c большим количеством деталей в формате YAML:

        ```bash
        yc compute disk list --format yaml
        ```

        Результат выполнения:
        ```yaml
        - id: fhmm0br99mig46rc0em0
           folder_id: b1gb9jeqoiordtmv1lbo
           created_at: "2021-01-11T09:35:05Z"
           name: big-disk
           description: 8k blocksize disk
           type_id: network-hdd
           zone_id: ru-central1-a
           size: "42949672960"
           block_size: "8192"
           status: READY
           disk_placement_policy: {}
        ```

{% endlist %}

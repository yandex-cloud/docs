---
title: Как создать пустой диск с блоком большого размера
description: Следуя данной инструкции, вы сможете создать пустой диск с блоком большого размера.
---

# Создать пустой диск с блоком большого размера


{% include [default-catalogue](../../../_includes/compute/disk-blocksize.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  См. раздел [{#T}](../../../compute/operations/disk-create/empty.md).

- CLI {#cli}

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

       Требования к имени диска:

       {% include [name-format](../../../_includes/name-format.md) %}

    1. Получите список дисков в каталоге по умолчанию:

       {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

       Получите тот же список с большим количеством деталей в формате YAML:

        ```bash
        yc compute disk list --format yaml
        ```

        Результат:
        ```text
        - id: fhmm0br99mig********
           folder_id: b1gb9jeqoior********
           created_at: "2021-01-11T09:35:05Z"
           name: big-disk
           description: 8k blocksize disk
           type_id: network-hdd
           zone_id: {{ region-id }}-a
           size: "42949672960"
           block_size: "8192"
           status: READY
           disk_placement_policy: {}
        ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  {% include [terraform-empty-disk-create](../../../_includes/compute/terraform-empty-disk-create.md) %}

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Disk/create.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/Create](../../api-ref/grpc/disk_service.md#Create).

{% endlist %}

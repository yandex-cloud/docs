# Управление шардами

Вы можете включить шардирование для кластера, а также добавлять и настраивать отдельные шарды.

{% note warning %}

Если кластер использует [гибридное хранилище](../concepts/storage.md#hybrid-storage-features) на стадии [Preview](https://cloud.yandex.ru/docs/overview/concepts/launch-stages), то в него можно добавлять шарды, состоящие только из одного хоста. На стадии General Availability это ограничение будет снято.

{% endnote %}

## Включить шардирование {#enable}

Кластеры {{ mch-name }} создаются с одним шардом. Чтобы начать непосредственно шардирование данных, [добавьте](#add-shard) еще один или несколько шардов и [создайте](../tutorials/sharding.md#example) распределенную таблицу.

## Добавить шард {#add-shard}

Количество шардов в кластерах {{ mch-short-name }} ограничено квотами на количество CPU и объем памяти, которые доступны кластерам БД в вашем облаке. Чтобы проверить используемые ресурсы, откройте страницу [Квоты]({{ link-console-quotas }}) и найдите блок **{{ mch-full-name }}**.

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Хосты**.
  1. Нажмите кнопку **Добавить шард**.
  1. Укажите имя шарда и добавьте нужное количество хостов.
  1. Нажмите кнопку **Создать шард**.

- Terraform

    {% note info %}

    {{ TF }} не позволяет указывать вес шардов.

    {% endnote %}

    Чтобы добавить шард в кластер:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Добавьте к описанию кластера {{ mch-name }} блок `host` типа `CLICKHOUSE` с заполненным полем `shard_name` или измените существующие хосты:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          host {
            type       = "CLICKHOUSE"
            zone       = "<зона доступности>"
            subnet_id  = yandex_vpc_subnet.<подсеть в зоне доступности>.id
            shard_name = "<имя шарда>"
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера Terraform](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

  Добавить шард в кластер можно с помощью метода [addShard](../api-ref/Cluster/addShard.md).

{% endlist %}

## Получить список шардов в кластере {#list-shards}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.

  1. Нажмите на имя нужного кластера, затем выберите вкладку **Шарды**.

- API

  Получить список шардов кластера можно с помощью метода [listShards](../api-ref/Cluster/listShards.md).

{% endlist %}

## Изменить шард {#shard-update}

Вы можете изменить вес шарда, а также [класс хоста](../concepts/instance-types.md) и объем хранилища.

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Шарды**.
  1. Нажмите ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Изменить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить шард в кластере:

  1. Посмотрите описание команды CLI для изменения шарда:

     ```bash
     {{ yc-mdb-ch }} shards update --help
     ```

  1. Запустите операцию, например, изменения веса для шарда:

     ```bash
     {{ yc-mdb-ch }} shards update --cluster-name clickhouse12 \
                                   --name shard1 \
                                   --weight 80
     ```

   После успешного завершения операции CLI выведет информацию об измененном шарде:

   ```
   name: shard1
   cluster_id: c9fmo2rf013t4q0ab8m1
   config:
     clickhouse:
       config:
         effective_config:
           log_level: INFORMATION
     ...

     weight: "80"
   ```

- API

  Изменить настройки шарда можно с помощью метода [updateShard](../api-ref/Cluster/updateShard.md).

{% endlist %}

## Удалить шард {#delete-shard}

Вы можете удалить шард из {{ CH }}-кластера, если он не является:
- Единственным шардом.
- Единственным шардом в [группе шардов](shard-groups.md).

Удаление шарда приведет к удалению всех таблиц и данных, которые находятся на этом шарде.

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.

  1. Нажмите на имя нужного кластера и выберите вкладку **Шарды**.

  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) в строке нужного хоста и выберите пункт **Удалить**.

- Terraform

    Чтобы удалить шард из кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Удалите из описания кластера {{ mch-name }} блок `host` с описанием шарда.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите удаление ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера Terraform](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- API

  Удалить шард можно с помощью метода [deleteShard](../api-ref/Cluster/deleteShard.md).

{% endlist %}

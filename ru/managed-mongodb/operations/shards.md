# Управление шардами

Вы можете включить [шардирование](../concepts/sharding.md) для кластера, а также добавлять и настраивать отдельные шарды.

Для повышения доступности шарды должны состоять как минимум из трех хостов `MONGOD`. Небольшие коллекции обычно нет смысла шардировать: скорость обработки запросов будет выше в обычном кластере реплик.

{% note alert %}

После того, как [шардирование кластера](../concepts/sharding.md) включено:

- Выключить шардирование невозможно, в кластере всегда будет поддерживаться минимальное количество хостов `MONGOS`, `MONGOCFG` или `MONGOINFRA` в зависимости от [типа шардирования](../concepts/sharding.md#shard-management).
- Обращаться к базам данных следует только через хосты `MONGOS` или `MONGOINFRA`, которые маршрутизируют запросы к шардам. Измените адреса хостов в коде ваших приложений соответствующим образом.

{% endnote %}

## Включить шардирование {#enable}

Через интерфейс {{ mmg-name }} вы можете быстро создать [инфраструктуру шардирования {{ MG }}](../concepts/sharding.md#shard-management).

О том, как непосредственно шардировать базу и коллекции {{ MG }}, читайте в разделе [{#T}](../tutorials/sharding.md).

Для включения шардирования необходимо:

* не менее трех хостов `MONGOINFRA` при стандартном шардировании;
* не менее двух хостов `MONGOS` и не менее трех хостов `MONGOCFG` при расширенном шардировании.

{% note info %}

Шардирование [не поддерживается](../concepts/sharding.md#shard-management) для хостов с классами **b1.nano**, **b1.micro**, **b1.medium**, **b2.nano**, **b2.micro** и **b2.medium**. Если у вас нет вкладки **Шарды**, [повысьте класс хостов кластера](update.md#change-resource-preset) до поддерживаемого.

{% endnote %}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmg-name }}**.

    1. Нажмите на имя нужного кластера и выберите вкладку **Шарды**.

    1. Нажмите кнопку **Включить**.

    1. Выберите один из типов шардирования:
       - **Стандартный** — с использованием хостов `MONGOINFRA`.

       - **Расширенный** — с использованием хостов `MONGOS` и `MONGOCFG`.

          Подробнее см. в разделе [{#T}](../concepts/sharding.md).

       {% note warning %}

       После включения шардирования будет невозможно поменять его тип.

       {% endnote %}

    1. Задайте параметры хостов, которые будут обеспечивать доступ к шардированным данным.

    1. Нажмите кнопку **Включить шардирование**.

    Кластер начнет обновляться, при этом будут созданы запрошенные хосты, а также первый шард кластера.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    * Чтобы включить стандартное шардирование кластера с использованием хостов `MONGOINFRA`, выполните команду (в примере приведены не все доступные параметры):

        ```bash
        {{ yc-mdb-mg }} cluster enable-sharding \
           --cluster-name=<имя кластера> \
           --host type=mongoinfra,`
                 `zone-id=<зона доступности>,`
                 `subnet-name=<имя подсети> \
           --host type=mongoinfra,`
                 `zone-id=<зона доступности>,`
                 `subnet-name=<имя подсети> \
           --host type=mongoinfra,`
                 `zone-id=<зона доступности>,`
                 `subnet-name=<имя подсети> \
           --mongoinfra resource-preset=<класс хоста>,`
                       `disk-size=<размер хранилища в гигабайтах>,`
                       `disk-type=<тип хранилища>
        ```

        Где:

        * `--cluster-name` — имя кластера, которое можно получить со [списком кластеров в каталоге](cluster-list.md#list).
        * `--host` — параметры хоста:
            * `type` — тип (`MONGOINFRA`);
            * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md);
            * `subnet-name` — [имя подсети](../../vpc/concepts/network.md#subnet).
        * `--mongoinfra` — параметры хостов `MONGOINFRA`:
            * `resource-preset` — [класс хоста](../concepts/instance-types.md);
            * `disk-size` — объем хранилища в гигабайтах;
            * `disk-type` — [тип хранилища](../concepts/storage.md).

    * Чтобы включить расширенное шардирование кластера с использованием хостов `MONGOS` и `MONGOCFG`, выполните команду (в примере приведены не все доступные параметры):

        ```bash
        {{ yc-mdb-mg }} cluster enable-sharding \
           --cluster-name=<имя кластера> \
           --host type=mongos,`
                 `zone-id=<зона доступности>,`
                 `subnet-name=<имя подсети> \
           --host type=mongos,`
                 `zone-id=<зона доступности>,`
                 `subnet-name=<имя подсети> \
           --mongos resource-preset=<класс хоста>,`
                   `disk-size=<размер хранилища в гигабайтах>,`
                   `disk-type=<тип хранилища> \
           --host type=mongocfg,`
                 `zone-id=<зона доступности>,`
                 `subnet-name=<имя подсети> \
           --host type=mongocfg,`
                 `zone-id=<зона доступности>,`
                 `subnet-name=<имя подсети> \
           --host type=mongocfg,`
                 `zone-id=<зона доступности>,`
                 `subnet-name=<имя подсети> \
           --mongocfg resource-preset=<класс хоста>,`
                     `disk-size=<размер хранилища в гигабайтах>,`
                     `disk-type=<тип хранилища>
        ```

        Где:

        * `--cluster-name` — имя кластера, которое можно получить со [списком кластеров в каталоге](cluster-list.md#list).
        * `--host` — параметры хоста:
            * `type` — тип (`MONGOS` или `MONGOCFG`);
            * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md);
            * `subnet-name` — [имя подсети](../../vpc/concepts/network.md#subnet).
        * `--mongos` — параметры хостов `MONGOS`:
            * `resource-preset` — [класс хоста](../concepts/instance-types.md);
            * `disk-size` — объем хранилища в гигабайтах;
            * `disk-type` — [тип хранилища](../concepts/storage.md).
        * `--mongocfg` — параметры хостов `MONGOCFG`:
            * `resource-preset` — [класс хоста](../concepts/instance-types.md);
            * `disk-size` — объем хранилища в гигабайтах;
            * `disk-type` — [тип хранилища](../concepts/storage.md).

- API

    Включить шардирование кластера можно с помощью метода [enableSharding](../api-ref/Cluster/enableSharding.md).

{% endlist %}


## Получить список шардов в кластере {#list-shards}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmg-name }}**.

  1. Нажмите на имя нужного кластера и выберите вкладку **Шарды**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список шардов в кластере, выполните команду:

    ```bash
    {{ yc-mdb-mg }} shards list --cluster-name <имя кластера>
    ```

    ```text
    +------+
    | NAME |
    +------+
    | rs01 |
    | rs02 |
    +------+
    ```

    Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

  Получить список шардов кластера можно с помощью метода [listShards](../api-ref/Cluster/listShards.md).

{% endlist %}

## Добавить шард {#add-shard}

Количество шардов в кластерах {{ mmg-short-name }} ограничено квотами на количество CPU и объем памяти, которые доступны кластерам БД в вашем облаке. Чтобы проверить используемые ресурсы, откройте страницу [Квоты]({{ link-console-quotas }}) и найдите блок **{{ mmg-full-name }}**.

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmg-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Шарды**.
  1. Нажмите кнопку **Добавить шард**.
  1. Укажите имя шарда и добавьте нужное количество хостов.
  1. Нажмите кнопку **Создать шард**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы добавить шард в кластер, выполните команду (в примере приведены не все доступные параметры):

    ```bash
    {{ yc-mdb-mg }} shards add <имя нового шарда> \
       --cluster-name=<имя кластера> \
       --host zone-id=<зона доступности>,`
             `subnet-name=<имя подсети>
    ```

    Где:

    * `--cluster-name` — имя кластера, которое можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
    * `--host` — параметры хоста:
        * `zone-id` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `subnet-name` — [имя подсети](../../vpc/concepts/network.md#subnet).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

    1. Добавьте к описанию кластера {{ mmg-name }} нужное количество блоков `host` с указанием имени шарда в параметре `shard_name`:

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<имя кластера>" {
          ...
          host {
            zone       = "<зона доступности>"
            subnet_id  = "<идентификатор подсети>"
            shard_name = "<имя шарда>"
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmg }}).

- API

    Добавить шард в кластер можно с помощью метода [addShard](../api-ref/Cluster/addShard.md).

{% endlist %}


## Удалить шард {#delete-shard}

Вы можете удалить шард из {{ MG }}-кластера, если он не является единственным шардом. Чтобы заменить единственный шард, сначала создайте новый шард, а затем удалите старый.

{% note info %}

Для удаляемого шарда будет вызвана операция [removeShard](https://docs.mongodb.com/manual/reference/command/removeShard/), которая безопасно переносит данные на оставшиеся шарды.

{% endnote %}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmg-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Шарды**.
    1. Нажмите на значок ![image](../../_assets/horizontal-ellipsis.svg) в строке нужного шарда и выберите пункт **Удалить**.
    1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы удалить шард из кластера, выполните команду:

    ```bash
    {{ yc-mdb-mg }} shards delete <имя шарда> \
       --cluster-name=<имя кластера>
    ```

    Имя шарда можно запросить со [списком шардов в кластере](#list-shards), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Удалите из описания кластера {{ mmg-name }} все блоки `host`, которые относятся к шарду.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите удаление ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmg }}).

- API

  Удалить шард можно с помощью метода [deleteShard](../api-ref/Cluster/deleteShard.md).

{% endlist %}

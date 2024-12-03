# Миграция кластера {{ mmg-full-name }} с версии 4.4 на 6.0 c помощью {{ data-transfer-full-name }}


Вы можете перенести продуктивную нагруженную шардированную базу данных, развернутую в кластере {{ mmg-name }} версии 4.4, на версию 6.0.

Чтобы перенести данные:

1. [Подготовьте кластер-источник](#prepare-source).
1. [Подготовьте кластер-приемник](#prepare-target).
1. [Подготовьте трансферы](#prepare-transfer).
1. [Активируйте трансферы](#activate-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Создайте кластер-приемник {{ mmg-name }} версии 6.0, идентичный кластеру версии 4.4.

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер-приемник {{ mmg-name }}](../../../managed-mongodb/operations/cluster-create.md) с конфигурацией, идентичной кластеру-источнику, и со следующими настройками:

        * Версия кластера — `6.0`.
        * Имя базы данных — `db1`.
        * Имя пользователя — `user1`.

        Для подключения к кластеру из интернета включите публичный доступ к хостам кластера.


    1. Если вы используете группы безопасности в кластере, убедитесь, что они [настроены правильно](../../../managed-mongodb/operations/connect/index.md#configuring-security-groups) и допускают подключение к нему.


    1. [Выдайте роль](../../../managed-mongodb/operations/cluster-users.md#updateuser) `readWrite` на базу `db1` пользователю `user1`.

    1. [Включите шардирование кластера](../../../managed-mongodb/operations/shards.md#enable) и [добавьте](../../../managed-mongodb/operations/shards.md#add-shard) нужное количество шардов.

- С помощью {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. В той же рабочей директории разместите файл с расширением `.tf` и содержимым:

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "old" { }
        ```

    1. Запишите идентификатор кластера {{ MG }} версии 4.4 в переменную окружения:

        ```bash
        export MONGODB_CLUSTER_ID=<идентификатор_кластера>
        ```

        Идентификатор можно запросить вместе со [списком кластеров в каталоге](../../../managed-mongodb/operations/cluster-list.md#list-clusters).

    1. Импортируйте настройки кластера {{ MG }} версии 4.4 в конфигурацию {{ TF }}:

        ```bash
        terraform import yandex_mdb_mongodb_cluster.old ${MONGODB_CLUSTER_ID}
        ```

    1. Получите импортированную конфигурацию:

        ```bash
        terraform show
        ```

    1. Скопируйте ее из терминала и вставьте в файл с расширением `.tf`.
    1. Расположите файл в новой директории `imported-cluster`.
    1. Измените скопированную конфигурацию так, чтобы из нее можно было создать новый кластер:

        * Укажите новое имя кластера в строке `resource` и параметре `name`.
        * Укажите в параметре `version` версию `6.0`.
        * Удалите параметры `created_at`, `health`, `id`, `sharded` и `status`.
        * В блоках `host` удалите параметры `health` и `name`.
        * Если в блоке `maintenance_window` указано значение параметра `type = "ANYTIME"`, удалите параметр `hour`.
        * Если есть блоки `user`, удалите их. Пользователи БД добавляются с помощью отдельного ресурса `yandex_mdb_mongodb_user`.
        * Если есть блоки `database`, удалите их. Базы данных добавляются с помощью отдельного ресурса `yandex_mdb_mongodb_database`.
        * (Опционально) Внесите дополнительные изменения, если вам нужна не идентичная, а кастомизированная копия кластера.

    1. Добавьте в файл ресурс для создания базы данных:

        ```hcl
        resource "yandex_mdb_mongodb_database" "db1" {
          cluster_id = yandex_mdb_mongodb_cluster.<имя_кластера>.id
          name       = "db1"
        }
        ```

        Где `<имя_кластера>` — новое имя кластера, указанное в ресурсе `yandex_mdb_mongodb_cluster`.

    1. Добавьте в файл ресурс для создания пользователя `user1`:

        ```hcl
        resource "yandex_mdb_mongodb_user" "user1" {
          cluster_id = yandex_mdb_mongodb_cluster.<имя_кластера>.id
          name       = "user1"
          password   = "<пароль_пользователя>"
          permission {
            database_name = "db1"
            roles         = ["readWrite"]
          }
          depends_on = [
            yandex_mdb_mongodb_database.db1
          ]
        }
        ```

        Где `<имя_кластера>` — новое имя кластера, указанное в ресурсе `yandex_mdb_mongodb_cluster`.

    1. В директории `imported-cluster` [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).

    1. В этой же директории [настройте и инициализируйте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf).

    1. Поместите конфигурационный файл в директорию `imported-cluster` и [укажите значения параметров](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Проверьте корректность файлов конфигурации {{ TF }}:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

    {% include [Terraform timeouts](../../../_includes/mdb/mmg/terraform/timeouts.md) %}

{% endlist %}

## Подготовьте кластер-источник {#prepare-source}

1. [Создайте пользователя](../../../managed-mongodb/operations/cluster-users.md#adduser) с ролью `readWrite` на базу данных в источнике, которая будет реплицироваться.

1. Удалите из базы неиспользуемые коллекции.

1. Отключите в коллекциях признак уникальности индексов. Он будет включен после переноса данных.

1. Оцените нагрузку на базу данных. Если она превышает 10 000 операций на запись в секунду, запланируйте несколько трансферов:

    1. Определите список особо нагруженных коллекций.
    1. Распределите коллекции между несколькими трансферами.

1. Задайте размер хранения oplog с запасом 15–20 % от размера диска кластера. Это позволит {{ data-transfer-name }} считывать изменения из кластера-источника на протяжении всего процесса копирования данных.

    Подробнее об oplog читайте в [документации {{ MG }}](https://www.mongodb.com/docs/manual/tutorial/change-oplog-size).

## Подготовьте кластер-приемник {#prepare-target}

Если в базе-источнике есть шардированные коллекции, [подготовьте базу-приемник](../../../data-transfer/operations/prepare.md#target-mg). Для индексов не указывайте уникальность.

## Подготовьте трансферы {#prepare-transfer}

1. [Создайте эндпоинт-источник](../../../data-transfer/operations/endpoint/index.md#create) для каждого запланированного трансфера и укажите параметры эндпоинта:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `MongoDB`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.mdb_cluster_id.title }}`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.mdb_cluster_id.title }}** — `<имя_кластера-источника_{{ MG }}>` из выпадающего списка.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.auth_source.title }}** — `<имя_базы_данных_кластера-источника>`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}** — `<имя_пользователя>`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}** — `<пароль>`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoCollectionFilter.collections.title }}** — для каждого эндпоинта укажите список включенных коллекций в соответствии с планом распределения по трансферам.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoCollectionFilter.excluded_collections.title }}** — укажите [коллекции Time Series]({{ mg.docs.comd }}/core/timeseries-collections/), если они существуют в базе данных. {{ data-transfer-name }} не поддерживает перенос таких коллекций.

1. [Создайте эндпоинт-приемник](../../../data-transfer/operations/endpoint/index.md#create) для каждого запланированного трансфера и укажите параметры эндпоинта:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `MongoDB`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.connection_type.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.mdb_cluster_id.title }}`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.mdb_cluster_id.title }}** — `<имя_кластера-приемника_{{ MG }}>` из выпадающего списка.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.auth_source.title }}** — `db1`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}** — `user1`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}** — `<пароль>`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.database.title }}** — `db1`.

    Если в базе-приемнике созданы шардированные коллекции, выберите политику очистки `Не очищать` или `TRUNCATE`.

    {% include [MongoDB endpoint DROP clean policy warning](../../../_includes/data-transfer/note-mongodb-clean-policy.md) %}

1. [Создайте трансферы](../../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_**, использующие созданные эндпоинты.

    Чтобы ускорить копирование больших коллекций (более 1 ГБ), включите [параллельное копирование](../../../data-transfer/concepts/sharded.md) в настройках трансфера:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.ParallelSnapshotSettings.workers_count.title }}** — `5` или более.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.ParallelSnapshotSettings.threads_count.title }}** — `8` или более.

    Коллекция разделится на указанное количество частей, которые будут копироваться параллельно.

    Чтобы параллельное копирование работало, [тип данных](https://www.mongodb.com/docs/manual/reference/bson-types) поля `_id` у всех документов коллекции должен быть одинаковым. Если трансфер обнаруживает неоднородность типов, то коллекция не разбивается на части и переносится в одном потоке. При необходимости перед началом трансфера удалите из коллекции документы с отличающимися типами данных.

    {% note info %}

    Если после активации трансфера в коллекцию добавится документ с отличающимся типом данных, трансфер перенесет его на стадии репликации, после параллельного копирования. Но при повторной активации трансфер не сможет разбить коллекцию на части, так как требование к типу поля `_id` во всех документах коллекции не будет выполнено.

    {% endnote %}

## Активируйте трансферы {#activate-transfer}

1. [Активируйте трансферы](../../../data-transfer/operations/transfer.md#activate).
1. Дождитесь перехода трансферов в статус {{ dt-status-repl }}.
1. Переведите кластер-источник в режим «только чтение».
1. Если в базе-источнике вы отключали уникальные индексы, включите их в базе-приемнике.
1. Переключите нагрузку на кластер-приемник.
1. На странице [мониторинга трансфера](../../../data-transfer/operations/monitoring.md) дождитесь снижения до нуля характеристики **Maximum data transfer delay** для каждого трансфера. Это значит, что в кластер-приемник перенесены все изменения, произошедшие в кластере-источнике после завершения копирования данных.
1. [Деактивируйте](../../../data-transfer/operations/transfer.md#deactivate) трансферы и дождитесь их перехода в статус {{ dt-status-stopped }}.

## Проверьте работоспособность трансфера {#verify-transfer}

1. [Подключитесь к базе данных](../../../managed-mongodb/operations/connect/index.md) `db1` в кластере-приемнике {{ mmg-name }}.

1. Убедитесь, что в базе данных `db1` появились коллекции с данными:

    ```javascript
    show collections
    db.<имя_коллекции>.find()
    ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

* [Трансфер](../../../data-transfer/operations/transfer.md#delete).
* [Эндпоинты](../../../data-transfer/operations/endpoint/index.md#delete).

Кластер {{ mmg-name }} версии `6.0` удалите в зависимости от способа его создания:

{% list tabs group=instructions %}

- Вручную {#manual}

    Удалите [кластер {{ mmg-name }}](../../../managed-mongodb/operations/cluster-delete.md).

- С помощью {{ TF }} {#tf}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}

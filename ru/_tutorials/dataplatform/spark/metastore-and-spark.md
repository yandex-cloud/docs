# Интеграция {{ msp-full-name }} и {{ metastore-full-name }}


В PySpark-задании можно использовать глобальный каталог Hive. Для этого к кластеру {{ msp-full-name }} нужно подключить кластер {{ metastore-name }}.

{{ metastore-name }} обеспечивает:
* Централизованное хранение метаданных о базах, таблицах и партициях.
* Упрощенный доступ к данным без указания путей и схем вручную.
* Хранение статистики таблиц и колонок для оптимизации запросов.

В этом руководстве показан пример работы с таблицей в бакете {{ objstorage-full-name }} из PySpark-задания с использованием глобального каталога Hive. Метаданные о БД сохраняются в кластере {{ metastore-name }}, а затем экспортируются в бакет для выходных данных.

Чтобы реализовать описанный пример:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте и запустите PySpark-задание](#prepare-job).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

{% note info %}

Интеграция кластера {{ msp-full-name }} с {{ metastore-name }} позволяет использовать в задании Spark формат таблиц {{ IBRG }}. Подробнее см. в руководстве [{#T}](../../../managed-spark/tutorials/spark-simple-rw-job.md).

{% endnote %}


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за бакеты {{ objstorage-name }}: использование хранилища и выполнение операций с данными (см. [тарифы {{ objstorage-name }}](../../../storage/pricing.md)).
* Плата за сервис {{ cloud-logging-full-name }}: объем записываемых данных и время их хранения (см. [тарифы {{ cloud-logging-name }}](../../../logging/pricing.md)).
* Плата за вычислительные ресурсы компонентов кластера {{ msp-full-name }} (см. [тарифы {{ msp-full-name }}](../../../managed-spark/pricing.md)).
* Плата за вычислительные ресурсы компонентов кластера {{ metastore-name }} (см. [тарифы {{ metadata-hub-full-name }}](../../../metadata-hub/pricing.md)).


## Подготовьте инфраструктуру {#infra}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) `spark-agent` для кластера {{ msp-full-name }} с ролью [managed-spark.integrationProvider](../../../iam/roles-reference.md#managed-spark-integrationProvider) — чтобы кластер {{ msp-full-name }} мог взаимодействовать с другими ресурсами.

    1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) `metastore-agent` с ролями [{{ roles.metastore.integrationProvider }}](../../../iam/roles-reference.md#managed-metastore-integrationProvider) и [storage.uploader](../../../iam/roles-reference.md#storage-uploader) — чтобы кластер {{ metastore-name }} мог [взаимодействовать с другими ресурсами](../../../metadata-hub/concepts/metastore-impersonation.md) и экспортировать метаданные в бакет {{ objstorage-name }}.

    1. [Создайте бакеты](../../../storage/operations/buckets/create.md):

        * бакет для исходного кода PySpark-задания;
        * бакет для выходных данных.

    1. [Предоставьте разрешения](../../../storage/operations/buckets/edit-acl.md) для сервисного аккаунта `spark-agent` на созданные бакеты:

        * бакет для исходного кода PySpark-задания — разрешение `READ`;
        * бакет для выходных данных — разрешение `READ и WRITE`.

    1. [Предоставьте разрешение](../../../storage/operations/buckets/edit-acl.md) `READ и WRITE` для сервисного аккаунта `metastore-agent` на бакет для выходных данных.

    1. [Создайте облачную сеть](../../../vpc/operations/network-create.md) с именем `integration-network`.

        Вместе с ней будут автоматически созданы три подсети в разных зонах доступности.

    1. Для кластера {{ msp-full-name }} [создайте группу безопасности](../../../vpc/operations/security-group-create.md) `spark-sg` в сети `integration-network`. Добавьте в группу следующее правило:

        * Для исходящего трафика, чтобы разрешить подключение кластера {{ msp-full-name }} к {{ metastore-name }}:

            * Диапазон портов — `{{ port-metastore }}`.
            * Протокол — `Любой` (`Any`).
            * Назначение — `CIDR`.
            * CIDR блоки — `0.0.0.0/0`.

    1. Для кластера {{ metastore-name }} [создайте группу безопасности](../../../vpc/operations/security-group-create.md) `metastore-sg` в сети `integration-network`. Добавьте в группу следующие правила:

        * Для входящего трафика от клиентов:

            * Диапазон портов — `30000-32767`.
            * Протокол — `Любой` (`Any`).
            * Источник — `CIDR`.
            * CIDR блоки — `0.0.0.0/0`.

        * Для входящего трафика от балансировщика:

            * Диапазон портов — `10256`.
            * Протокол — `Любой` (`Any`).
            * Источник — `Проверки состояния балансировщика`.

    1. [Создайте кластер {{ metastore-name }}](../../../metadata-hub/operations/metastore/cluster-create.md) с параметрами:

        * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** — `metastore-agent`.
        * **{{ ui-key.yacloud.mdb.forms.base_field_version }}** — `{{ metastore.integration-version }}`.
        * **{{ ui-key.yacloud.mdb.forms.label_network }}** — `integration-network`.
        * **{{ ui-key.yacloud.mdb.forms.network_field_subnetwork }}** — `integration-network-{{ region-id }}-a`.
        * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — `metastore-sg`.


    1. [Создайте кластер {{ msp-full-name }}](../../../managed-spark/operations/cluster-create.md) с параметрами:

        * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** — `spark-agent`.
        * **{{ ui-key.yacloud.mdb.forms.label_network }}** — `integration-network`.
        * **{{ ui-key.yacloud.mdb.forms.network_field_subnetwork }}** — `integration-network-{{ region-id }}-a`.
        * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — `spark-sg`.
        * **{{ ui-key.yacloud.spark.label_metastore }}** — созданный ранее кластер {{ metastore-name }}.

{% endlist %}

## Подготовьте PySpark-задание {#prepare-job}

Для PySpark-задания будет использован Python-скрипт, который создает БД `database_1` и таблицу `table_1`. Чтобы кластер {{ msp-full-name }} получил доступ к глобальному каталогу {{ metastore-name }}, в скрипте вызывается метод `enableHiveSupport()`. Скрипт будет храниться в бакете {{ objstorage-name }}.

Подготовьте файл скрипта:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Создайте локально файл с именем `job-create-table.py` и скопируйте в него скрипт:

        {% cut "job-create-table.py" %}

        {% include [PySpark job](../../_tutorials_includes/spark/job-create-table.md) %}

        {% endcut %}

    1. В бакете для исходного кода создайте папку `scripts` и [загрузите](../../../storage/operations/objects/upload.md#simple) в нее файл `job-create-table.py`.
    1. В бакете для выходных данных создайте папку `warehouse`, в которую будут загружены данные из БД `database_1`.
    1. [Создайте задание](../../../managed-spark/operations/jobs-pyspark.md) с параметрами:
        * **Тип задания** — **PySpark**.
        * **Main python файл** — `s3a://<бакет_для_исходного_кода>/scripts/job-create-table.py`.
        * **Аргументы** — `s3a://<бакет_для_выходных_данных>/warehouse`.

{% endlist %}

## Проверьте результат {#check-result}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}**.
    1. Дождитесь, когда созданное PySpark-задание перейдет в статус **Done**.
    1. Убедитесь, что в бакете для выходных данных, в папке `warehouse`, появился файл с данными из БД `database_1`.
    1. Проверьте, что в кластере {{ metastore-name }} появились метаданные о БД `database_1`:

        1. [Экспортируйте метаданные](../../../metadata-hub/operations/metastore/export-and-import.md#export) из кластера {{ metastore-name }} в бакет для выходных данных.
        1. [Скачайте файл](../../../storage/operations/objects/download.md) с метаданными и убедитесь, что в нем упоминается БД `database_1`.

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Кластер {{ metastore-name }}](../../../metadata-hub/operations/metastore/cluster-delete.md).
    1. [Кластер {{ msp-full-name }}](../../../managed-spark/operations/cluster-delete.md).
    1. [Бакеты {{ objstorage-name }}](../../../storage/operations/buckets/delete.md). Перед удалением бакетов [удалите](../../../storage/operations/objects/delete.md) из них все объекты.

{% endlist %}



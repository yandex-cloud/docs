# Использование {{ objstorage-full-name }} в сервисе {{ msp-full-name }}


В бакетах {{ objstorage-full-name }} можно хранить как файлы, необходимые для выполнения заданий в кластере {{ msp-full-name }}, так и результаты выполнения заданий.

Кластеры {{ msp-full-name }} уже сконфигурированы для работы с S3-хранилищами. Чтобы использовать бакет {{ objstorage-name }} в PySpark-задании:
* Предоставьте сервисному аккаунту кластера {{ msp-full-name }} разрешение на доступ к бакету {{ objstorage-name }}.
* Укажите путь к каталогу в бакете {{ objstorage-name }} в аргументах задания.

В этом руководстве показан пример работы с таблицей в бакете {{ objstorage-name }} из PySpark-задания с использованием встроенного локального каталога Hive.

Чтобы реализовать описанный пример:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте PySpark-задание](#prepare-a-job).
1. [Проверьте результат](#check-out).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

{% note info %}

Локальный каталог Hive позволяет обращаться к таблицам по имени без указания пути и использовать базовые возможности Hive, не подключая кластер {{ metastore-name }}. Хранящиеся в локальном каталоге метаданные остаются недоступными другим кластерам. Пример использования глобального каталога см. в руководстве [{#T}](../../managed-spark/tutorials/metastore-and-spark.md).

{% endnote %}


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за бакеты {{ objstorage-name }}: использование хранилища и выполнение операций с данными (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md)).
* Плата за сервис {{ cloud-logging-name }}: объем записываемых данных и время их хранения (см. [тарифы {{ cloud-logging-name }}](../../logging/pricing.md)).


## Подготовьте инфраструктуру {#infra}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `spark-agent` для кластера {{ msp-full-name }} с ролью [managed-spark.integrationProvider](../../iam/roles-reference.md#managed-spark-integrationProvider) — чтобы кластер {{ msp-full-name }} мог взаимодействовать с другими ресурсами.

    1. [Создайте бакеты](../../storage/operations/buckets/create.md):

        * `<бакет_для_исходного_кода_PySpark_задания>`.
        * `<бакет_для_выходных_данных_PySpark_задания>`.

    1. [Предоставьте разрешения](../../storage/operations/buckets/edit-acl.md) для сервисного аккаунта `spark-agent` на созданные бакеты:

        * `<бакет_для_исходного_кода_PySpark_задания>` — разрешение `READ`.
        * `<бакет_для_выходных_данных_PySpark_задания>` — разрешение `READ и WRITE`.

    1. [Создайте облачную сеть](../../vpc/operations/network-create.md) с именем `spark-network`.

        Вместе с ней автоматически будут созданы три подсети в разных зонах доступности.

    1. [Создайте кластер {{ msp-full-name }}](../../managed-spark/operations/cluster-create.md) с параметрами:

        * **Сервисный аккаунт** — `spark-agent`.
        * **Сеть** — `spark-network`.
        * **Подсеть** — `spark-network-{{ region-id }}-a`.

{% endlist %}

## Подготовьте PySpark-задание {#prepare-a-job}

Для PySpark-задания используется Python-скрипт, который создает таблицу `table_1` в БД `database_1`. В аргументах PySpark-задания указан путь к каталогу, в котором будет создана БД. Для подключения встроенного каталога Hive в скрипте указывается параметр конфигурации Spark-сессии `spark.sql.catalogImplementation=hive`. Скрипт будет храниться в бакете {{ objstorage-name }}.

Подготовьте файл скрипта:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Создайте локально файл с именем `job_save_table.py` и скопируйте в него скрипт:

       {% cut "job_save_table.py" %}

       {% include [pyspark](../_tutorials_includes/spark/job-save-table-pyspark.md) %}

       {% endcut %}

    1. Создайте в бакете `<бакет_для_исходного_кода_PySpark_задания>` папку `scripts` и [загрузите](../../storage/operations/objects/upload.md#simple) в нее файл `job_save_table.py`.
    1. [Создайте задание](../../managed-spark/operations/jobs-pyspark.md) с параметрами:
        * **Тип задания** — **PySpark**.
        * **Main python файл** – `s3a://<бакет_для_исходного_кода_PySpark_задания>/scripts/job_save_table.py`.
        * **Аргументы** — `s3a://<бакет_для_выходных_данных_PySpark_задания>/warehouse`.

{% endlist %}

## Проверьте результат {#check-out}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}**.
    1. Дождитесь, когда созданное PySpark-задание перейдет в статус **Done**.
    1. Убедитесь, что в бакете `<бакет_для_выходных_данных_PySpark_задания>` в папке `warehouse` появилась БД `database_1`. Теперь данные из созданной БД хранятся в бакете {{ objstorage-name }} в формате JSON.

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Бакеты {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
    1. [Кластер {{ msp-full-name }}](../../managed-spark/operations/cluster-delete.md).

{% endlist %}

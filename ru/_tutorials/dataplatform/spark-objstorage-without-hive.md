# Работа с {{ objstorage-full-name }} из PySpark-задания без использования Hive


В бакетах {{ objstorage-full-name }} можно хранить как файлы, необходимые для выполнения заданий в кластере {{ msp-full-name }}, так и результаты выполнения заданий.

Кластеры {{ msp-full-name }} уже сконфигурированы для работы с S3-хранилищами. Чтобы использовать бакет {{ objstorage-name }} в PySpark-задании:
* Предоставьте сервисному аккаунту кластера {{ msp-full-name }} разрешение на доступ к бакету {{ objstorage-name }}.
* Укажите путь к каталогу в бакете {{ objstorage-name }} в аргументах задания.

В этом руководстве показан пример прямой работы с данными в бакете {{ objstorage-name }} из PySpark-задания без использования Hive. Этот подход имеет следующие ограничения:
* доступ к данным возможен только по путям в {{ objstorage-name }}, но не по именам таблиц;
* метаданные о таблицах не создаются и не сохраняются.


{% note info %}

Для того чтобы обращаться к данным по имени таблицы и хранить метаданные таблиц, используйте локальный или глобальный каталог Hive:
* [Локальный каталог](../../managed-spark/tutorials/spark-objstorage-integration.md) — для работы с данными и метаданными в пределах одного кластера.
* [Глобальный каталог](../../managed-spark/tutorials/metastore-and-spark.md) (кластер {{ metastore-full-name }}) — для работы с общими метаданными таблиц из нескольких кластеров {{ msp-full-name }}.

{% endnote %}


Чтобы реализовать описанный пример:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте файл с данными](#prepare-data).
1. [Подготовьте PySpark-задание](#prepare-a-job).
1. [Проверьте результат](#check-out).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер {{ msp-name }}: выделенные хостам вычислительные ресурсы ([тарифы {{ msp-name }}](../../managed-spark/pricing.md)).
* Бакеты {{ objstorage-name }}: использование хранилища и выполнение операций с данными ([тарифы {{ objstorage-name }}](../../storage/pricing.md)).
* Сервис {{ cloud-logging-full-name }}: объем записываемых данных и время их хранения ([тарифы {{ cloud-logging-name }}](../../logging/pricing.md)).


## Подготовьте инфраструктуру {#infra}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `spark-agent` для кластера {{ msp-full-name }} с ролью [managed-spark.integrationProvider](../../iam/roles-reference.md#managed-spark-integrationProvider) — чтобы кластер {{ msp-full-name }} мог взаимодействовать с другими ресурсами.

    1. [Создайте бакеты](../../storage/operations/buckets/create.md):

        * `<бакет_для_исходного_кода_PySpark_задания>`.
        * `<бакет_для_данных_PySpark_задания>`.

    1. [Предоставьте разрешения](../../storage/operations/buckets/edit-acl.md) для сервисного аккаунта `spark-agent` на созданные бакеты:

        * `<бакет_для_исходного_кода_PySpark_задания>` — разрешение `READ`.
        * `<бакет_для_данных_PySpark_задания>` — разрешение `READ и WRITE`.

    1. [Создайте облачную сеть](../../vpc/operations/network-create.md) с именем `spark-network`.

        Вместе с ней автоматически будут созданы три подсети в разных зонах доступности.

    1. [Создайте кластер {{ msp-full-name }}](../../managed-spark/operations/cluster-create.md) с параметрами:

        * **Сервисный аккаунт** — `spark-agent`.
        * **Сеть** — `spark-network`.
        * **Подсеть** — `spark-network-{{ region-id }}-a`.

{% endlist %}

## Подготовьте файл с данными {#prepare-data}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Создайте локально файл с именем `input.csv` и скопируйте в него скрипт:

       ```csv
       id,value
       1,10
       2,20
       3,30
       4,40
       5,50
       ```

    1. Создайте в бакете `<бакет_для_данных_PySpark_задания>` папку `input` и [загрузите](../../storage/operations/objects/upload.md#simple) в нее файл `input.csv`.

{% endlist %}

## Подготовьте PySpark-задание {#prepare-a-job}

Для PySpark-задания используется Python-скрипт, который:
* считывает CSV-файл из бакета {{ objstorage-name }};
* регистрирует DataFrame как временное представление Spark SQL;
* выполняет SQL-запрос;
* сохраняет результат в бакете {{ objstorage-name }} в формате Parquet.

Подготовьте файл скрипта:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Создайте локально файл с именем `job_process_data.py` и скопируйте в него скрипт:

       {% cut "job_process_data.py" %}

       {% include [pyspark](../_tutorials_includes/spark/job-process-data.md) %}

       {% endcut %}

    1. Создайте в бакете `<бакет_для_исходного_кода_PySpark_задания>` папку `scripts` и [загрузите](../../storage/operations/objects/upload.md#simple) в нее файл `job_process_data.py`.
    1. [Создайте задание](../../managed-spark/operations/jobs-pyspark.md) с параметрами:
        * **Тип задания** — **PySpark**.
        * **Main python файл** – `s3a://<бакет_для_исходного_кода_PySpark_задания>/scripts/job_process_data.py`.
        * **Аргументы**:
          1. `s3a://<бакет_для_данных_PySpark_задания>/input/input.csv`.
          1. `s3a://<бакет_для_данных_PySpark_задания>/output`.

{% endlist %}

## Проверьте результат {#check-out}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}**.
    1. Дождитесь, когда созданное PySpark-задание перейдет в статус **Done**.
    1. Убедитесь, что в бакете `<бакет_для_данных_PySpark_задания>` в папке `output` появились файлы `*.parquet`. Результат обработки данных доступен другим Spark-заданиям по пути `s3a://<бакет_для_данных_PySpark_задания>/output`.

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Бакеты {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
    1. [Кластер {{ msp-full-name }}](../../managed-spark/operations/cluster-delete.md).

{% endlist %}

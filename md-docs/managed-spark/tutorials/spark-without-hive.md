[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Apache Spark™](../index.md) > [Практические руководства](index.md) > Работа с данными в Object Storage > Работа с Yandex Object Storage без использования Hive

# Работа с Yandex Object Storage из PySpark-задания без использования Hive

# Работа с Yandex Object Storage из PySpark-задания без использования Hive


В бакетах Yandex Object Storage можно хранить как файлы, необходимые для выполнения заданий в кластере Yandex Managed Service for Apache Spark™, так и результаты выполнения заданий.

Кластеры Yandex Managed Service for Apache Spark™ уже сконфигурированы для работы с S3-хранилищами. Чтобы использовать бакет Object Storage в PySpark-задании:
* Предоставьте сервисному аккаунту кластера Yandex Managed Service for Apache Spark™ разрешение на доступ к бакету Object Storage.
* Укажите путь к каталогу в бакете Object Storage в аргументах задания.

В этом руководстве показан пример прямой работы с данными в бакете Object Storage из PySpark-задания без использования Hive. Этот подход имеет следующие ограничения:
* доступ к данным возможен только по путям в Object Storage, но не по именам таблиц;
* метаданные о таблицах не создаются и не сохраняются.


{% note info %}

Для того чтобы обращаться к данным по имени таблицы и хранить метаданные таблиц, используйте локальный или глобальный каталог Hive:
* [Локальный каталог](spark-objstorage-integration.md) — для работы с данными и метаданными в пределах одного кластера.
* [Глобальный каталог](metastore-and-spark.md) (кластер Apache Hive™ Metastore) — для работы с общими метаданными таблиц из нескольких кластеров Yandex Managed Service for Apache Spark™.

{% endnote %}


Чтобы реализовать описанный пример:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте файл с данными](#prepare-data).
1. [Подготовьте PySpark-задание](#prepare-a-job).
1. [Проверьте результат](#check-out).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for Apache Spark™: выделенные хостам вычислительные ресурсы ([тарифы Managed Service for Apache Spark™](../pricing.md)).
* Бакеты Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../storage/pricing.md)).
* Сервис Yandex Cloud Logging: объем записываемых данных и время их хранения ([тарифы Cloud Logging](../../logging/pricing.md)).


## Подготовьте инфраструктуру {#infra}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `spark-agent` для кластера Yandex Managed Service for Apache Spark™ с ролью [managed-spark.integrationProvider](../../iam/roles-reference.md#managed-spark-integrationProvider) — чтобы кластер Yandex Managed Service for Apache Spark™ мог взаимодействовать с другими ресурсами.

    1. [Создайте бакеты](../../storage/operations/buckets/create.md):

        * `<бакет_для_исходного_кода_PySpark_задания>`.
        * `<бакет_для_данных_PySpark_задания>`.

    1. [Предоставьте разрешения](../../storage/operations/buckets/edit-acl.md) для сервисного аккаунта `spark-agent` на созданные бакеты:

        * `<бакет_для_исходного_кода_PySpark_задания>` — разрешение `READ`.
        * `<бакет_для_данных_PySpark_задания>` — разрешение `READ и WRITE`.

    1. [Создайте облачную сеть](../../vpc/operations/network-create.md) с именем `spark-network`.

        Вместе с ней автоматически будут созданы три подсети в разных зонах доступности.

    1. [Создайте кластер Yandex Managed Service for Apache Spark™](../operations/cluster-create.md) с параметрами:

        * **Сервисный аккаунт** — `spark-agent`.
        * **Сеть** — `spark-network`.
        * **Подсеть** — `spark-network-ru-central1-a`.

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
* считывает CSV-файл из бакета Object Storage;
* регистрирует DataFrame как временное представление Spark SQL;
* выполняет SQL-запрос;
* сохраняет результат в бакете Object Storage в формате Parquet.

Подготовьте файл скрипта:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Создайте локально файл с именем `job_process_data.py` и скопируйте в него скрипт:

       {% cut "job_process_data.py" %}

       ```python
       import sys
       from pyspark.sql import SparkSession
       
       
       def main():
           if len(sys.argv) != 3:
               print(
                   "Usage: job_process_data <input_path> <output_path>",
                   file=sys.stderr
               )
               sys.exit(-1)
       
           input_path = sys.argv[1]
           output_path = sys.argv[2]
       
           spark = (
               SparkSession.builder
               .appName("object-storage-example")
               .config("spark.executor.instances", 1)
               .getOrCreate()
           )
       
           df = spark.read.load(
               input_path,
               format="csv",
               header=True,
               inferSchema=True
           )
       
           df.createOrReplaceTempView("source_data")
       
           result_df = spark.sql("""
               SELECT
                   id,
                   value
               FROM source_data
               WHERE value >= 30
           """)
       
           result_df.write.mode("overwrite").save(
               output_path,
               format="parquet"
           )
       
           spark.stop()
       
       
       if __name__ == "__main__":
           main()
       ```

       {% endcut %}

    1. Создайте в бакете `<бакет_для_исходного_кода_PySpark_задания>` папку `scripts` и [загрузите](../../storage/operations/objects/upload.md#simple) в нее файл `job_process_data.py`.
    1. [Создайте задание](../operations/jobs-pyspark.md) с параметрами:
        * **Тип задания** — **PySpark**.
        * **Main python файл** – `s3a://<бакет_для_исходного_кода_PySpark_задания>/scripts/job_process_data.py`.
        * **Аргументы**:
          1. `s3a://<бакет_для_данных_PySpark_задания>/input/input.csv`.
          1. `s3a://<бакет_для_данных_PySpark_задания>/output`.

{% endlist %}

## Проверьте результат {#check-out}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. Перейдите в сервис **Managed Service for Apache Spark**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Задания**.
    1. Дождитесь, когда созданное PySpark-задание перейдет в статус **Done**.
    1. Убедитесь, что в бакете `<бакет_для_данных_PySpark_задания>` в папке `output` появились файлы `*.parquet`. Результат обработки данных доступен другим Spark-заданиям по пути `s3a://<бакет_для_данных_PySpark_задания>/output`.

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Бакеты Object Storage](../../storage/operations/buckets/delete.md).
    1. [Кластер Yandex Managed Service for Apache Spark™](../operations/cluster-delete.md).

{% endlist %}
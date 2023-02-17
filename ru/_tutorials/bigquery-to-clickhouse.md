# Миграция базы данных из Google BigQuery в {{ mch-name }}

Вы можете перенести базу данных из Google BigQuery в {{ mch-full-name }} и затем проанализировать ее с помощью {{ datalens-full-name }}.

Таблица переносится в сжатом виде в бакет Google Storage, а из него в бакет {{ objstorage-full-name }}. Затем данные импортируются в кластер {{ mch-name }}, где их можно проанализировать с помощью {{ datalens-full-name }}.

Такой способ миграции обладает следующими преимуществами:

* возможность задать формат выгрузки данных и степень сжатия;
* значительное сокращение объема данных и времени на их миграцию, а значит и снижение стоимости миграции.

Однако при таком способе данные переносятся <q>как есть</q>, без трансформации или копирования обновившихся инкрементов.

Чтобы перенести базу данных из Google BigQuery в {{ mch-name }}:

1. [Перенесите данные из Google BigQuery в {{ objstorage-full-name }}](#migrate-data).
1. [Настройте отображение данных из {{ objstorage-full-name }} в кластере {{ mch-name }}](#create-view).
1. [Проанализируйте данные с помощью {{ datalens-full-name }}](#datalens).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы

Для миграции базы данных необходимо создать ресурсы Google Cloud и ресурсы {{ yandex-cloud }}.

### Создайте ресурсы Google Cloud {#create-google-res}

1. [Создайте бакет Google Storage](https://cloud.google.com/storage/docs/creating-buckets).

1. [Создайте сервисный аккаунт Google Cloud](https://cloud.google.com/iam/docs/creating-managing-service-accounts#creating) с ролями `BigQuery Data Editor` и `Storage Object Admin`.
1. [Создайте ключ доступа для сервисного аккаунта](https://cloud.google.com/iam/docs/creating-managing-service-account-keys#creating) и сохраните его в виде файла `.json`.

1. [Скачайте и установите утилиты CLI `google-cloud-sdk`](https://cloud.google.com/sdk/docs/install).
1. [Выполните аутентификацию в gcloud CLI](https://cloud.google.com/sdk/docs/authorizing#authorizing_with_a_service_account).
1. [Установите Google BigQuery Python SDK](https://github.com/googleapis/python-bigquery). Для работы этого пакета потребуется Python версии 3.7 или выше.
1. Подготовьте набор данных (датасет) для Google BigQuery. В качестве примера использован [публичный датасет](https://cloud.google.com/bigquery/public-data) `google_trends` для Google BigQuery, содержащий таблицу `international_top_terms` со столбцами:

    * `rank`
    * `country_name`
    * `country_code`
    * `region_name`
    * `week`
    * `score`
    * `region_code`
    * `term`
    * `refresh_date`

### Создайте ресурсы {{ yandex-cloud }} {#create-yandex-res}

1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md) с ролью `storage.uploader` для доступа к бакету {{ objstorage-name }}.

1. [Создайте статический ключ доступа](../iam/operations/sa/create-access-key.md) для сервисного аккаунта. Сохраните идентификатор ключа и секретный ключ, они понадобятся далее.

1. [Создайте кластер {{ mch-name }}](../managed-clickhouse/operations/cluster-create.md) любой подходящей конфигурации. При создании кластера:

      * укажите созданный ранее сервисный аккаунт.
      * включите параметр **Доступ из DataLens**.

1. [Включите отказоустойчивость с помощью хостов Zookeeper](../managed-clickhouse/operations/zk-hosts.md).

1. [Создайте бакет {{ objstorage-name }}](../storage/operations/buckets/create.md). При создании [включите публичный доступ](../storage/operations/buckets/bucket-availability.md) на чтение объектов и к списку объектов в бакете.

## Перенесите данные из Google BigQuery в {{ objstorage-full-name }} {#migrate-data}

1. Создайте файл `credentials.boto` с параметрами доступа к ресурсам Google Cloud и {{ yandex-cloud }}:

    ```boto
    [Credentials]
    gs_service_client_id  =<сервисный аккаунт Google Cloud>
    gs_service_key_file   =<абсолютный путь к JSON-файлу ключа доступа сервисного аккаунта Google Cloud>
    aws_access_key_id     =<идентификатор ключа сервисного аккаунта {{ yandex-cloud }}>
    aws_secret_access_key =<секретный ключ сервисного аккаунта {{ yandex-cloud }}>

    [GSUtil]
      default_project_id    =<идентификатор проекта Google Cloud>

    [s3]
      calling_format=boto.s3.connection.OrdinaryCallingFormat
      host=storage.yandexcloud.net
    ```

    Где:

    * `<сервисный аккаунт Google Cloud>` — [имя сервисного аккаунта Google Cloud](service-account-name@project-id.iam.gserviceaccount.com) вида `service-account-name@project-id.iam.gserviceaccount.com`;
    * `<идентификатор проекта Google Cloud>` — [идентификатор проекта Google Cloud](https://cloud.google.com/resource-manager/docs/creating-managing-projects#identifying_projects).

1. Создайте файл скрипта `main.py`, который выполняет сжатие и миграцию данных:

    {% cut "main.py" %}

    ```python
    from google.cloud import bigquery
    import sys
    import argparse
    import time
    import subprocess
    import os
    os.environ["GOOGLE_APPLICATION_CREDENTIALS"]="<абсолютный путь к JSON-файлу ключа доступа сервисного аккаунта Google Cloud>"
    os.environ["BOTO_CONFIG"]="<абсолютный путь к файлу credentials.boto>"

    def parse_args():
        parser = argparse.ArgumentParser(description='Export data from Google Big Query to Yandex Cloud object storage')
        parser.add_argument('--bq_project', type=str, help='GBQ project ID')
        parser.add_argument('--bq_location', type=str, help='GBQ table AND GS location')
        parser.add_argument('--gs_bucket', type=str, help='GS export destination bucket')
        parser.add_argument('--yc_bucket', type=str, help='YC copy destination bucket')
        parser.add_argument('--gsutil_path', type=str, help='GSutil exec path', default='gsutil')
        return parser.parse_args()

    def select_from_list(message, elements):
        print(message)
        print("\t{}. {}".format(0, "Export all"))
        for ind in range(len(elements)):
            if isinstance(elements[ind].reference, bigquery.DatasetReference):
                print("\t{}. {}".format(ind+1, elements[ind].reference.dataset_id))
            elif isinstance(elements[ind].reference, bigquery.TableReference):
                print("\t{}. {}".format(ind+1, elements[ind].reference.table_id))
        try:
            return int(input("(any letter for cancel) >> "))
        except ValueError:
            print("Exiting")
            sys.exit()

    if __name__ == '__main__':
        args = parse_args()
        client = bigquery.Client()

        datasets = list(client.list_datasets(args.bq_project))
        dataset_selector = select_from_list("Datasets in project {}".format(args.bq_project), datasets)
        export_list = []
        for i in range(len(datasets)):
            dataset_ref = datasets[i].reference
            if dataset_selector == 0:
                export_list += list(client.list_tables(dataset_ref))
            else:
                if i == dataset_selector - 1:
                    tables = list(client.list_tables(dataset_ref))
                    table_selector = select_from_list("Tables in dataset {}".format(dataset_ref.dataset_id),
                                                      tables)
                    for j in range(len(tables)):
                        if table_selector == 0 or j == table_selector - 1:
                            export_list.append(tables[j])

        print("Starting tables export")
        for n in range(len(export_list)):
            table_ref = export_list[n].reference

            # Creating Extract Job config. Selecting compression level and data format.
            job_config = bigquery.job.ExtractJobConfig()
            job_config.compression = bigquery.Compression.GZIP
            job_config.destination_format = bigquery.DestinationFormat.PARQUET

            print("Exporting {} table".format(table_ref.table_id))
            extract_job = client.extract_table(
                source=table_ref,
                destination_uris="gs://{}/{}".format(args.gs_bucket, "{}-*".format(table_ref.table_id)),
                job_id="export-job-{}-{}".format(table_ref.table_id, round(time.time() * 1000)),
                location=args.bq_location,
                job_config=job_config)
            extract_job.result()
        print("Tables export done")

        # Calling gsutil rsync to synchronize source and destination buckets.
        source_uri = "gs://{}/".format(args.gs_bucket)
        destination_uri = "s3://{}/".format(args.yc_bucket)
        print("Synchronizing {} with {}...".format(source_uri, destination_uri))
        proc = subprocess.Popen([args.gsutil_path, "-m", "rsync", source_uri, destination_uri],
                                stdout=sys.stdout,
                                stderr=sys.stderr)
        proc.communicate()
        print("Buckets synchronization done")
    ```

    {% endcut %}

1. Выполните скрипт `main.py`, чтобы запустить миграцию данных из Google BigQuery в бакет Google Storage, а затем в бакет {{ objstorage-full-name }}:

    ```bash
    python main.py \
        --bq_project=<идентификатор проекта Google Cloud> \
        --bq_location=US \
        --gs_bucket=<имя бакета Google Cloud Storage> \
        --yc_bucket=<имя бакета {{ objstorage-name }}>
    ```

    Дождитесь окончания миграции данных.

## Настройте отображение данных из {{ objstorage-full-name }} в кластере {{ mch-name }} {#create-view}

1. Чтобы создать представление импортированных данных, [подключитесь к базе данных кластера {{ mch-name }}](../managed-clickhouse/operations/connect.md) и выполните SQL-запрос:

    ```sql
    CREATE view db1.v$google_top_rising_terms on cluster on cluster '{cluster}' AS
    (SELECT
    term,
    score,
    rank,
    country_name,
    country_code,
    region_name,
    region_code,
    week,
    refresh_date
    FROM s3Cluster(
      '<идентификатор кластера>',
      'https://storage.yandexcloud.net/<имя бакета {{ objstorage-name }}>/top_terms-*',
      'Parquet',
      'rank Int32,
      country_name String,
      country_code String,
      region_name String,
      week Timestamp,
      score Nullable(Int32),
      region_code String,
      term String,
      refresh_date Timestamp')
    )
    ```

    Где:

    * `db1` — название базы данных в кластере {{ mch-name }}, в которой требуется создать представление.
    * `v$google_top_rising_terms` — название представления для отображения импортированных данных.
    * `<идентификатор кластера>` — идентификатор кластера {{ mch-name }}. Его можно получить вместе со [списком кластеров в каталоге](../managed-clickhouse/operations/cluster-list.md).
    * `top_terms-*` — ключевая часть имени объектов бакета {{ objstorage-name }}. Например, если из Google Cloud вы перенесли таблицу, в которой есть строки с именем `top_terms`, то в бакете {{ objstorage-name }} они будут выглядеть как набор объектов с именами `top_terms-000000000001`, `top_terms-000000000002` и т. д. Тогда в SQL-запросе нужно указать `top_terms-*`, чтобы в представление попали все записи с таким именем из этой таблицы.

1. Чтобы вывести первые 100 записей из созданного представления, выполните SQL-запрос (для примера используется представление `v$google_top_rising_terms` и базе данных `db1`):

    ```sql
    SELECT * FROM db1.v$google_top_rising_terms limit 100
    ```

## Проанализируйте данные с помощью {{ datalens-full-name }} {#datalens}

1. [Подключите кластер {{ mch-name }} к {{ datalens-name }}](../datalens/operations/connection/create-clickhouse.md).
1. [Создайте датасет](../datalens/operations/dataset/create.md) из таблицы `db1.v$google_top_rising_terms`. Для поля `score` выберите агрегацию по среднему значению.
1. [Создайте столбчатую диаграмму](../datalens/visualization-ref/column-chart.md#create-diagram):

    1. В секцию **X** перетащите поле `country_name`.
    1. В секцию **Y** перетащите поле `score`.
    1. В секцию **Фильтры** перетащите поле `term`. В открывшейся форме задайте параметры:
        * **Операция** — **Принадлежит множеству**.
        * **Доступны** — введите термин из списка доступных и нажмите кнопку **Применить фильтр**.
    1. В секцию **Сортировка** перетащите поле `term`.

Использование заданного запроса в поисковой системе будет проанализировано, результат будет выведен в виде столбчатой диаграммы по странам.

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, во избежание списания средств за них:

1. [Удалите кластер {{ mch-name }}](../managed-clickhouse/operations/cluster-delete.md).
1. [Удалите все объекты бакета {{ objstorage-name }}](../storage/operations/objects/delete-all.md) и затем [удалите сам бакет](../storage/operations/buckets/delete.md).
1. [Удалите бакет Google Storage](https://cloud.google.com/storage/docs/deleting-buckets).

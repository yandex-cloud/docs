# Migrating databases from Google BigQuery to {{ mch-name }}

You can migrate a database from Google BigQuery to {{ mch-full-name }} and then use {{ datalens-full-name }} to analyze it.

The table is compressed, then moved to a Google Storage bucket and then to an {{ objstorage-full-name }} bucket. After that, the data is imported to a {{ mch-name }} cluster where you can analyze it using {{ datalens-full-name }}.

This method of migration has the following benefits:

* You can specify the export format and the compression ratio.
* Lower data amounts are involved, which accelerates migration and reduces its cost.

However, in this case, the data is migrated <q>as is</q>, without transforming or copying the updated increments.

To migrate the database from Google BigQuery to {{ mch-name }}:

1. [Migrate data from Google BigQuery to {{ objstorage-full-name }}](#migrate-data).
1. [Set up the mapping of data from {{ objstorage-full-name }} to the {{ mch-name }} cluster](#create-view).
1. [Analyze the data with {{ datalens-full-name }}](#datalens).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin

To migrate your database, create Google Cloud and {{ yandex-cloud }} resources.

### Create Google Cloud resources {#create-google-res}

1. [Create a Google Storage bucket](https://cloud.google.com/storage/docs/creating-buckets).

1. [Create a Google Cloud service account](https://cloud.google.com/iam/docs/creating-managing-service-accounts#creating) with the roles `BigQuery Data Editor` and `Storage Object Admin`.
1. [Create an access key for the service account](https://cloud.google.com/iam/docs/creating-managing-service-account-keys#creating) and save it as a `.json` file.

1. [Download and install the `google-cloud-sdk` CLI utilities](https://cloud.google.com/sdk/docs/install).
1. [Authenticate in gcloud CLI](https://cloud.google.com/sdk/docs/authorizing#authorizing_with_a_service_account).
1. [Install the Google BigQuery Python SDK utility](https://github.com/googleapis/python-bigquery). This package requires Python 3.7 or higher.
1. Prepare a dataset for Google BigQuery. As an example, here we use a [public dataset](https://cloud.google.com/bigquery/public-data) called `google_trends` for Google BigQuery that includes the `international_top_terms` table with the columns:

   * `rank`
   * `country_name`
   * `country_code`
   * `region_name`
   * `week`
   * `score`
   * `region_code`
   * `term`
   * `refresh_date`

### Create {{ yandex-cloud }} resources {#create-yandex-res}

1. [Create a service account](../iam/operations/sa/create.md) with the role `storage.uploader` to access the {{ objstorage-name }} bucket.

1. [Create a static access key](../iam/operations/sa/create-access-key.md) for the service account. Save the key ID and secret key, you will need them later.

1. [Create a {{ mch-name }} cluster](../managed-clickhouse/operations/cluster-create.md) with any suitable configuration. When creating a cluster:

   * Use the service account you created earlier.
   * Enable **DataLens access**.

1. [Use Zookeeper to enable fault-tolerance](../managed-clickhouse/operations/zk-hosts.md).

1. [Create a {{ objstorage-name }} bucket](../storage/operations/buckets/create.md). When creating the bucket, [enable public access](../storage/operations/buckets/bucket-availability.md) to read objects and list objects in the bucket.

## Migrate data from Google BigQuery to {{ objstorage-full-name }} {#migrate-data}

1. Create a file named `credentials.boto` with access credentials for Google Cloud and {{ yandex-cloud }} resources:

   ```boto
   [Credentials]
   gs_service_client_id  =<Google Cloud service account>
   gs_service_key_file   =<absolute path to the JSON file with the access key for the Google Cloud service account>
   aws_access_key_id     =<{{ yandex-cloud }} service account key ID>
   aws_secret_access_key =<{{ yandex-cloud }} service account secret key>

   [GSUtil]
     default_project_id    =<Google Cloud project ID>

   [s3]
     calling_format=boto.s3.connection.OrdinaryCallingFormat
     host={{ s3-storage-host }}
   ```

   Where:

   * `<Google Cloud service account>`:[Name of the Google Cloud service account](service-account-name@project-id.iam.gserviceaccount.com) in the format: `service-account-name@project-id.iam.gserviceaccount.com`.
   * `<ID of the Google Cloud project>`: [Project ID in Google Cloud](https://cloud.google.com/resource-manager/docs/creating-managing-projects#identifying_projects).

1. Create a `main.py` script file for data compression and migration:

   {% cut "main.py" %}

   ```python
   from google.cloud import bigquery
   import sys
   import argparse
   import time
   import subprocess
   import os
   os.environ["GOOGLE_APPLICATION_CREDENTIALS"]="<absolute path to JSON file with the access key for the Google Cloud service account>"
   os.environ["BOTO_CONFIG"]="<absolute path to the credentials.boto file>"

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

1. Run the `main.py` script to start migrating data from Google BigQuery to the Google Storage bucket and then to the {{ objstorage-full-name }} bucket:

   ```bash
   python main.py \
       --bq_project=<ID of the Google Cloud project> \
       --bq_location=US \
       --gs_bucket=<name of the Google Cloud Storage bucket> \
       --yc_bucket=<{{ objstorage-name }} bucket name>
   ```

   Wait until the data migrates completely.

## Set up the mapping of data from {{ objstorage-full-name }} to the {{ mch-name }} cluster {#create-view}

1. To create a view based on the imported data, [connect to the {{ mch-name }} cluster database](../managed-clickhouse/operations/connect.md) and run the SQL query:

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
     '<cluster ID>',
     'https://{{ s3-storage-host }}/<{{ objstorage-name }} bucket name>/top_terms-*',
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

   Where:

   * `db1`: Name of the database in the {{ mch-name }} cluster where you want to create a view.
   * `v$google_top_rising_terms`: Name of the view created for the imported data.
   * `<cluster ID>`: ID of the {{ mch-name }} cluster. You can retrieve it with a [list of clusters in the folder](../managed-clickhouse/operations/cluster-list.md).
   * `top_terms-*`: The key part in the names of objects in the {{ objstorage-name }} bucket. For example, if you moved a table from Google Cloud that includes rows with the `top_terms` name, then in the {{ objstorage-name }} bucket they will look as a set of objects with the names `top_terms-000000000001`, `top_terms-000000000002`, and so on. In this case, in the SQL query, you should specify `top_terms-*` so that the view includes all the entries from this table having such a name.

1. To output the first 100 entries from the selected view, run the SQL query (in the example, we use the `v$google_top_rising_terms` view and the `db1` database):

   ```sql
   SELECT * FROM db1.v$google_top_rising_terms limit 100
   ```

## Use {{ datalens-full-name }} to analyze the data {#datalens}

1. [Connect the {{ mch-name }} cluster to {{ datalens-name }}](../datalens/operations/connection/create-clickhouse.md).
1. [Create a dataset](../datalens/operations/dataset/create.md) based on the `db1.v$google_top_rising_terms` view. For the `score` field, select the average aggregation.
1. [Create a bar chart](../datalens/visualization-ref/column-chart.md#create-diagram):

   1. Drag the `country_name` field to the **X** section.
   1. Drag the `score` field to the **Y** section.
   1. Drag the `term` field to the **Filters** section. In the resulting form, enter the settings:
      * **Operation**: **Belongs to a set**.
      * **Available**: Enter a term from a list of available terms, then click **Apply filter**.
   1. Drag the `term` field to the **Sorting** section.

The system will analyze the usage of this query in the search system, and the result will be output as a bar chart by countries.

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

1. [Delete the {{ mch-name }} cluster](../managed-clickhouse/operations/cluster-delete.md).
1. [Delete all objects from the {{ objstorage-name }} bucket](../storage/operations/objects/delete-all.md), then [delete the bucket](../storage/operations/buckets/delete.md).
1. [Delete the Google Storage bucket](https://cloud.google.com/storage/docs/deleting-buckets).

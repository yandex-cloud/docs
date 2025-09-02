```python
import random
import sys
from pyspark.sql import SparkSession


def prepare_table(spark, database, table):
    create_database_sql = "create database if not exists {database}"
    create_table_sql = """
    create table if not exists {database}.{table} (
        id int,
        value double
    )
    """
    truncate_table_sql = "truncate table {database}.{table}"

    spark.sql(create_database_sql.format(database=database))
    spark.sql(create_table_sql.format(database=database, table=table))
    spark.sql(truncate_table_sql.format(database=database, table=table))


def write_data(spark, database, table):
    data = [(i, random.random()) for i in range(100_000)]
    # Создание датафрейма
    df = spark.createDataFrame(data, schema=['id', 'value'])
    table_full_name = "{database}.{table}".format(database=database, table=table)
    df.write.mode('overwrite').format('json').saveAsTable(table_full_name)


def main():
    # Создание Spark-сессии
    spark = (
        SparkSession
        .builder
        .appName('job_save_table')
        .config('spark.executor.instances', 1)
        .config('spark.sql.warehouse.dir', sys.argv[1])
        .config('spark.sql.catalogImplementation', 'hive')
        .getOrCreate()
    )
    database, table = 'database_1', 'table_1'
    prepare_table(spark, database, table)
    write_data(spark, database, table)


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Usage: job-save-table s3a://<bucket>/<folder>", file=sys.stderr)
        sys.exit(-1)
    main()

```
```python
import random
from pyspark.sql import SparkSession


def prepare_table(spark, database, table):
    create_database_sql = "create database if not exists {database}"
    create_table_sql = """
    create table if not exists {database}.{table} (
        id int,
        value double
    )
    using iceberg
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
    df.writeTo(table_full_name).append()


def main():
    # Создание Spark-сессии
    spark = (
        SparkSession
        .builder
        .appName('job_with_table')
        .enableHiveSupport()
        .getOrCreate()
    )
    database, table = 'database_1', 'table_1'
    prepare_table(spark, database, table)
    write_data(spark, database, table)


if __name__ == '__main__':
    main()

```
# Загрузка/выгрузка данных между MDB Clickhouse и Data Proc

Spark SQL: **JDBC** To Other Databases [Spark docs 3.1.2](https://spark.apache.org/docs/latest/sql-data-sources-jdbc.html)

подключение к Managed Service for ClickHouse [docs](https://cloud.yandex.ru/docs/managed-clickhouse/operations/connect)

## Чтение из бд

1) Формирование jdbc строки

для подключения к публичному хосту надо использовать порт 8443, и добавить параметр ssl=true

```
jdbcPort = 8443
jdbcHostname = "c-<cluster ID>.rw.mdb.yandexcloud.net"
jdbcDatabase = "myschema"

jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}?ssl=true"
```

без ssl: порт 8123
```
jdbcPort = 8123
jdbcHostname = "c-<cluster ID>.rw.mdb.yandexcloud.net"
jdbcDatabase = "myschema"

jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}"
```

### import subset from existing table to spark df

пример ячейки кода в тетрадке Zeppelin: 
загрузка в датафрейм колонок col1, col2 из таблицы myschema.my_table

```
%spark.pyspark
df = spark.read.format("jdbc") \
    .option("url", jdbcUrl) \
    .option("user","admin") \
    .option("password","password") \
    .option("query","SELECT col1, col2 FROM myschema.my_table") \
    .load()

```

### импорт таблицы в df

```
%spark.pyspark

df = spark.read.format("jdbc") \
    .option("url", jdbcUrl) \
    .option("user","admin") \
    .option("password","password") \
    .option("dbtable","myschema.my_table") \
    .load()
```

выгрузка df в s3 хранилище в формате parquet:

```
%spark.pyspark

df.write.parquet('s3a://mybucket/dir/')
```

в новую таблицу Hive: 

```
%spark.pyspark

df.createOrReplaceTempView("mytempTable") 
spark.sql("CREATE TABLE IF NOT EXISTS mytable AS SELECT * FROM mytempTable");
spark.sql("SELECT COUNT(*) FROM mytable").show()
```


## запись в бд

### запись в существующую таблицу из spark df

загрузка файлов из hdfs в df на примере csv

путь HDFS можно узнать с помощью команды:
```
hdfs getconf -confKey fs.defaultFS
```
```
df_from_hdfs = spark.read.csv("hdfs://rc1a-dataproc-m-kwftevsp14b1fpla.mdb.yandexcloud.net/user/root/myfiles/")
```

загрузка файлов из s3 в df:
```
df_from_s3 = spark.read.csv("s3a://mybucket/dir/file.csv")
```

запись данных в существующую таблицу в CH:
```
%spark.pyspark
df.write.mode("append") \
    .jdbc(jdbcUrl, "myschema.oldtable", properties={"user": "admin", "password": "password"})
```

либо можно передавать все properties через параметр option:
```
%spark.pyspark

df.write.format("jdbc") \
.mode("append") \
.option("url", jdbcUrl) \
.option("dbtable", "myschema.oldtable") \
.option("user","admin") \
.option("password","password") \
.save()
```

### создание новой таблицы и запись данных в нее из spark df

допустим, у нас есть датафрейм с информацией о пользователях, состоящий из 2х колонок: имя пользователя и возраст

```
+-------+---+
|   name|age|
+-------+---+
|   Anna| 19|
|Michael| 65|
|   Fred| 28|
|  Alsou| 50|
+-------+---+
```

для записи датафрейма в новую таблицу нужно в параметре dbtable указать существующую схему, в которой будет создана новая таблица, имя новой таблицы и в createTableOptions задать движок таблицы:

```
%spark.pyspark

df.write.format("jdbc") \
.mode("error") \
.option("url", jdbcUrl) \
.option("dbtable", "myschema.users") \
.option("createTableOptions", "ENGINE = MergeTree() ORDER BY age") \
.option("user","admin") \
.option("password","password") \
.save()
```

Также при создании новой таблицы можно указать параметр createTableColumnTypes, чтобы переопределить дефолтные типы данных. Например, переопределим тип данных у числовой колонки age на CHAR(2):

```
%spark.pyspark
df.write.format("jdbc") \
.mode("ignore") \
.option("url", jdbcUrl) \
.option("dbtable", "myschema.newtable") \
.option("createTableOptions", "ENGINE = MergeTree() ORDER BY age") \
.option("createTableColumnTypes", "age CHAR(2)") \
.option("user","admin") \
.option("password","12345678") \
.save()
```
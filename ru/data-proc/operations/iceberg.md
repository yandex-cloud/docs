# **Пример работы {{ dataproc-name }} с Apache Iceberg**

Подробную информацию о Apache Iceberg см. в разделе [Apache Iceberg в Data Proc](../concepts/iceberg.md)  и [документации Apache Iceberg](https://iceberg.apache.org/docs/nightly/).

{% include [deltalake-disclaimer](../../../_includes/data-proc/deltalake-disclaimer.md) %}

## **Подготовьте инфраструктуру** {#prereq}

1. Если у вас нет кластера {{ dataproc-name }}, [создайте его](../cluster-create.md).

## **Настройте свойства компонентов для работы с Apache Iceberg** {#settings}

1. Установите следующие [свойства](../concepts/settings-list.md#change-properties) на уровне кластера или на уровне отдельного задания:

   * `spark.sql.extensions` в значение `org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions`;

2. Добавьте библиотеки Apache Iceberg в зависимости кластера или отдельного задания (нужные версии библиотек [зависят от версии {{ dataproc-name }}](../concepts/iceberg.md#compatibility)). Воспользуйтесь одним из способов:

{% list tabs %}

- {{ dataproc-name }} 2.0.x

  * Скачайте файл библиотеки [iceberg-spark-runtime-3.0_2.12-1.0.0.jar](https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-3.0_2.12/1.0.0/iceberg-spark-runtime-3.0_2.12-1.0.0.jar), сохраните его в бакет {{ objstorage-name }} и передайте URL файла в свойстве `spark.jars`:

    `spark.jars=s3a://<имя_бакета>/<путь_к_файлу>`

    Сервисный аккаунт кластера должен иметь доступ на чтение из бакета.

  * Настройте доступ кластера к репозиторию [Maven](https://maven.apache.org/index.html) и установите свойство `spark.jars.packages` в значение `org.apache.iceberg:iceberg-spark-runtime-3.0_2.12:1.0.0`.

    {% include [maven-setup](../../_includes/data-proc/maven-setup.md) %}

  * Скачайте файл библиотеки [iceberg-spark-runtime-3.0_2.12-1.0.0.jar](https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-3.0_2.12/1.0.0/iceberg-spark-runtime-3.0_2.12-1.0.0.jar), скопируйте его на все узлы кластера вручную или с помощью [скриптов инициализации](../concepts/init-action.md) и передайте полный путь к файлу в свойствах `spark.driver.extraClassPath` и `spark.executor.extraClassPath`.

- {{ dataproc-name }} 2.1.x

  * Скачайте файл библиотеки [iceberg-spark-runtime-3.3_2.12-1.5.2.jar](https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-3.3_2.12/1.5.2/iceberg-spark-runtime-3.3_2.12-1.5.2.jar), сохраните его в бакет {{ objstorage-name }} и передайте URL файла в свойстве `spark.jars`:

    `spark.jars=s3a://<имя_бакета>/<путь_к_файлу>`

    Сервисный аккаунт кластера должен иметь доступ на чтение из бакета.

  * Настройте доступ кластера к репозиторию [Maven](https://maven.apache.org/index.html) и установите свойство `spark.jars.packages` в значение `org.apache.iceberg:iceberg-spark-runtime-3.3_2.12:1.5.2`.

    {% include [maven-setup](../../_includes/data-proc/maven-setup.md) %}

  * Скачайте файл библиотеки [iceberg-spark-runtime-3.3_2.12-1.5.2.jar](https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-3.3_2.12/1.5.2/iceberg-spark-runtime-3.3_2.12-1.5.2.jar), скопируйте его на все узлы кластера вручную или с помощью [скриптов инициализации](../concepts/init-action.md) и передайте полный путь к файлу в свойствах `spark.driver.extraClassPath` и `spark.executor.extraClassPath`.

- {{ dataproc-name }} 2.2.x

  * Скачайте файл библиотеки [iceberg-spark-runtime-3.5_2.12-1.5.2.jar](https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-3.5_2.12/1.5.2/iceberg-spark-runtime-3.5_2.12-1.5.2.jar), сохраните его в бакет {{ objstorage-name }} и передайте URL файла в свойстве `spark.jars`:

    `spark.jars=s3a://<имя_бакета>/<путь_к_файлу>`

    Сервисный аккаунт кластера должен иметь доступ на чтение из бакета.

  * Настройте доступ кластера к репозиторию [Maven](https://maven.apache.org/index.html) и установите свойство `spark.jars.packages` в значение `org.apache.iceberg:iceberg-spark-runtime-3.5_2.12:1.5.2`.

    {% include [maven-setup](../../_includes/data-proc/maven-setup.md) %}

  * Скачайте файл библиотеки [iceberg-spark-runtime-3.5_2.12-1.5.2.jar](https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-3.5_2.12/1.5.2/iceberg-spark-runtime-3.5_2.12-1.5.2.jar), скопируйте его на все узлы кластера вручную или с помощью [скриптов инициализации](../concepts/init-action.md) и передайте полный путь к файлу в свойствах `spark.driver.extraClassPath` и `spark.executor.extraClassPath`.

{% endlist %}

Теперь вы можете использовать Apache Iceberg в кластере {{ dataproc-name }}.

## **Пример использования Apache Iceberg** {#example}

1. [Подключитесь по SSH](connect.md#data-proc-ssh) к хосту-мастеру кластера {{ dataproc-name }}.

{% note info "Примечание" %}

Следующая команда задает Hadoop - каталог с именем local по пути \<bucket_name\>/home/ubuntu/warehouse. [Подробнее о каталогах](https://iceberg.apache.org/docs/latest/spark-configuration/#catalogs)

{% endnote %}

{% list tabs %}

- {{ dataproc-name }} 2.0.x и 2.1.x

  2. Запустите в кластере сессию spark-sql, передав необходимые параметры:

  ```bash
  spark-sql --packages org.apache.iceberg:iceberg-spark-runtime-3.0_2.12:1.0.0\
      --conf spark.sql.catalog.local=org.apache.iceberg.spark.SparkCatalog \
      --conf spark.sql.catalog.local.type=hadoop \
      --conf spark.sql.catalog.local.warehouse=$PWD/warehouse 
  
  ```

  3. Создайте таблицу Iceberg

  ```sql
  >CREATE TABLE local.db.table (id bigint, data string) USING iceberg;
  
  ```

  4. Добавьте данные

  ```sql
  >INSERT INTO local.db.table VALUES (1, 'a'), (2, 'b'), (3, 'c');
  
  ```

  5. Просмотр таблицы

  ```pgsql
  >desc formatted local.db.table;
  
  col_name	data_type	comment
  id	bigint
  data	string
  
  # Partitioning
  Not partitioned
  
  # Detailed Table Information
  Name	local.db.table
  Location	/home/ubuntu/warehouse/db/table
  Provider	iceberg
  Owner	ubuntu
  Table Properties	[current-snapshot-id=6776013156467893319,format=iceberg/parquet]
  Time taken: 0.343 seconds, Fetched 12 row(s)
  ```

  6. Работа с данными

  ```sql
  >SELECT count(1) as count, data
  FROM local.db.table
  GROUP BY data;
  
  count	data
  1	a
  1	b
  1	c
  ```

- {{ dataproc-name }} 2.2.x

  2. Запустите в кластере сессию spark-shell, передав необходимые параметры:

  ```bash
   spark-shell --packages org.apache.iceberg:iceberg-spark-runtime-3.5_2.12:1.5.2 \
      --conf spark.sql.catalog.local=org.apache.iceberg.spark.SparkCatalog \
      --conf spark.sql.catalog.local.type=hadoop \
      --conf spark.sql.catalog.local.warehouse=$PWD/warehouse 
  ```

  3. Создайте таблицу Iceberg и запишите туда данные

  ```scala
  scala> val df = spark.createDataFrame(Seq(
       |   (1, "a"), (2, "b"), (3, "c")
       |   )).toDF("id", "data")
  df: org.apache.spark.sql.DataFrame = [id: int, data: string]
  
  scala> df.writeTo("local.db.table").create()
  ```

  6. Работа с существующими данными

  ```scala
  scala> val outDf = spark.table("local.db.table")
  outDf: org.apache.spark.sql.DataFrame = [id: int, data: string]
  
  outDf.count()   
  res1: Long = 3
  ```

{% endlist %}
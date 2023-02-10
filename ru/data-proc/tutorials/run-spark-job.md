---
title: "Apache Spark и PySpark. Запуск и управление приложениями"
keywords:
  - apache spark
  - spark
  - PySpark
---

# Запуск и управление приложениями для Spark и PySpark

Чтобы запускать Spark-приложения в кластере {{ dataproc-name }}, [подготовьте данные](#prepare-data) для обработки, а затем выберите нужный вариант запуска:

* [Spark Shell](#spark-shell) (командная оболочка для языков программирования Scala и Python). Подробнее о ней читайте в [документации Spark](https://spark.apache.org/docs/latest/quick-start).
* [Скрипт spark-submit](#spark-submit). Более подробно этот способ описан в [документации Spark](https://spark.apache.org/docs/latest/submitting-applications.html#submitting-applications).
* [Команды CLI {{ yandex-cloud }}](#run-cli-jobs).

## Подготовка данных {#prepare-data}

Следуя этой инструкции вы рассчитаете статистику по воздушному трафику США за 2018-й год по данным с сайта [transtats.bts.gov](https://transtats.bts.gov/). Набор данных подготовлен в формате [Parquet](https://parquet.apache.org/) в публичном бакете {{ objstorage-full-name }} с именем `yc-mdb-examples`.

Для работы с {{ objstorage-name }} рекомендуется [настроить S3cmd](../../storage/tools/s3cmd.md).

Список файлов можно получить с помощью команды:

```bash
s3cmd ls s3://yc-mdb-examples/dataproc/example01/set01/
```

Результат:

```text
2019-09-13 17:17  19327838   s3://yc-mdb-examples/dataproc/example01/set01/On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2018_1.parquet
2019-09-13 17:17  21120204   s3://yc-mdb-examples/dataproc/example01/set01/On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2018_10.parquet
...
```

{% note info %}

Перед настройкой доступа к сервисам {{ yandex-cloud }} и интернет-ресурсам убедитесь, что сеть кластера [настроена правильно](./configure-network.md).

{% endnote %}

## Использование Spark Shell {#spark-shell}

1. Запустите Spark Shell на мастер-хосте:

   ```bash
   /usr/bin/pyspark
   ```

   Количество ядер и процессов выполнения задач (executor) ограничено только конфигурацией вашего кластера {{ dataproc-name }}.

1. Построчно введите следующий код:

   ```python
   sql = SQLContext(sc)
   df = sql.read.parquet("s3a://yc-mdb-examples/dataproc/example01/set01")
   ```

   Последняя строка — чтение данных из публичного бакета с набором данных для примера. После выполнения этой строки в текущей сессии будет доступен организованный набор данных (DataFrame) `df` с прочитанными данными.

1. Чтобы увидеть схему полученного DataFrame, выполните команду:

   ```python
   df.printSchema()
   ```

   В терминале будет выведен список столбцов с их типами.

1. Рассчитайте статистику перелетов по месяцам и найдите первую десятку городов по количеству вылетов:

   * Количество перелетов по месяцам:

     ```python
     df.groupBy("Month").count().orderBy("Month").show()
     ```

   * Первая десятка городов по количеству вылетов:

     ```python
     df.groupBy("OriginCityName").count().orderBy("count", ascending=False).show(10)
     ```

## Использование Spark Submit {#spark-submit}

Spark Submit позволяет запускать заранее написанные приложения через скрипт `spark-submit`. В качестве примера рассмотрим приложение для расчета количества перелетов по месяцам. 

{% list tabs %}

- PySpark Submit

  1. На мастер-хосте создайте файл `month_stat.py` со следующим кодом:

     ```python
     import sys

     from pyspark import SparkContext, SparkConf
     from pyspark.sql import SQLContext

     def main():
         conf = SparkConf().setAppName("Month Stat - Python")
         conf.set("fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.AnonymousAWSCredentialsProvider")
         sc = SparkContext(conf=conf)

         sql = SQLContext(sc)
         df = sql.read.parquet("s3a://yc-mdb-examples/dataproc/example01/set01")
         defaultFS = sc._jsc.hadoopConfiguration().get("fs.defaultFS")
         month_stat = df.groupBy("Month").count()
         month_stat.repartition(1).write.format("csv").save(defaultFS+"/tmp/month_stat")

     if __name__ == "__main__":
             main()
     ```

  1. Запустите приложение:

     ```bash
     /usr/bin/spark-submit month_stat.py
     ```
  1. Результат работы приложения будет выгружен в HDFS. Список получившихся файлов можно вывести командой:

     ```bash
     hdfs dfs -ls /tmp/month_stat
     ```

- Spark Submit

  В примере рассматривается сборка и запуск приложения на языке программирования [Scala](https://scala-lang.org). Для сборки приложений используется [sbt](https://scala-lang.org/download/), стандартная утилита сборки Scala.

  Чтобы создать и запустить Spark-приложение:
  1. Выполните команду `scala -version` на управляющем хосте, чтобы узнать необходимую версию Scala.

     Следите за тем, чтобы версия Scala соответствовала версиям библиотек, которые развернуты в кластере {{ dataproc-name }}, и библиотек, которые используются в приложении. Набор библиотек по умолчанию можно найти в каталоге `/usr/lib/spark/jars` на хосте-мастере {{ dataproc-name }}.
  1. Создайте папку, например `spark-app`.
  1. В созданную папку добавьте файл с путем `./src/main/scala/app.scala`.
  1. Скопируйте следующий код в файл `app.scala`:

      ```scala
      package com.yandex.cloud.dataproc.scala

      import org.apache.spark.{SparkConf, SparkContext}
      import org.apache.spark.sql.SQLContext

        object Main {
          def main(args: Array[String]) {
            val conf = new SparkConf().setAppName("Month Stat - Scala App")
            val sc = new SparkContext(conf)
            sc.hadoopConfiguration.set("fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.AnonymousAWSCredentialsProvider")
            val sqlContext = new org.apache.spark.sql.SQLContext(sc)
            val df = sqlContext.read.parquet("s3a://yc-mdb-examples/dataproc/example01/set01")
            val month_stat = df.groupBy("Month").count()
            val defaultFS = sc.hadoopConfiguration.get("fs.defaultFS")
            month_stat.repartition(1).write.format("csv").save(defaultFS+"/tmp/month_stat")

            sc.stop()
          }
        }
      ```

  1. В папке `spark-app` создайте файл `build.sbt` со следующей конфигурацией:

      ```scala
      scalaVersion  := "2.11.6"

      libraryDependencies ++= Seq(
          "org.apache.spark" %% "spark-core" % "2.2.3" % "provided",
          "org.apache.spark" %% "spark-sql" % "2.2.3" % "provided"
      )
      ```

     {% note info %}

     Версия Scala и библиотек может измениться с обновлениями компонентов {{ dataproc-name }}.

     {% endnote %}

  1. Скомпилируйте и соберите jar-файл:

      ```bash
      sbt compile && sbt package
      ```

  1. Запустите получившееся приложение:

      ```bash
      /usr/bin/spark-submit \
          --class com.yandex.cloud.dataproc.scala.Main \
              ./target/scala-2.11/scala-app_2.11-0.1-SNAPSHOT.jar
      ```

  1. Результат работы приложения будет выгружен в HDFS. Список получившихся файлов можно вывести командой:

      ```bash
      hdfs dfs -ls /tmp/month_stat
      ```

{% endlist %}


## Завершение работы приложения {#yarn-kill}

По умолчанию ресурсы запускаемого приложения управляются компонентом YARN. Если приложение необходимо завершить или убрать из очереди, используйте утилиту `yarn`:

1. Выведите список приложений:

   ```bash
   yarn application -list
   ```
1. Завершите ненужное приложение:

   ```bash
   yarn application -kill <application_id>
   ```

Более подробно с командами YARN можно ознакомиться на странице [YARN Commands](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/YarnCommands.html).

## Запуск заданий (jobs) с помощью CLI {{ yandex-cloud }} {#run-cli-jobs}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [cli-job-intro](../../_includes/data-proc/cli-job-intro.md) %}

Результат расчета приложение сохраняет либо с помощью компонента HDFS в кластере {{ dataproc-name }}, либо в указанный вами бакет {{ objstorage-name }}.

Служебная и отладочная информация сохраняется в бакете {{ objstorage-name }}, который был указан при создании кластера {{ dataproc-name }}. Для каждого задания агент {{ dataproc-name }} создает отдельную папку с путем вида `dataproc/clusters/<идентификатор кластера>/jobs/<идентификатор задачи>`. Перед первым запуском следует назначить права `WRITE` на бакет для сервисного аккаунта, под которым будут запускаться задания.

Ниже приведены два варианта приложения — для Scala и Python.

### Запуск Spark Job {#cli-scala}

Основные шаги:

1. Соберите Scala-приложение в единый JAR-файл с помощью [SBT](https://www.scala-sbt.org/index.html).
2. Загрузите JAR-файл в бакет {{ objstorage-name }}, к которому есть доступ у сервисного аккаунта кластера.
3. Запустите задание в кластере {{ dataproc-name }}.

#### Соберите Scala-приложение {#scala-build}

Чтобы упростить управление зависимостями, соберите приложение в один JAR-файл (fat JAR) с помощью плагина [sbt-assembly](https://github.com/sbt/sbt-assembly).

Необходимую версию Scala можно узнать исполнив команду `scala -version` на мастер-хосте. Для примера используется версия `2.11.12`. Для приложений Spark рекомендуется строго соблюдать версию Scala и версии библиотек, которые развернуты в кластере {{ dataproc-name }}. Набор библиотек по умолчанию можно посмотреть в каталоге `/usr/lib/spark/jars`.

Структура приложения:

```text
spark-app
|-project
|  |-plugins.sbt
|-src
|  |-main
|    |-scala
|      |-app.scala
|-build.sbt
```

Чтобы собрать приложение:

1. Создайте папку `spark-app`, в ней — папки `project` и `src/main/scala`.
1. Создайте файл `project/plugins.sbt`, который описывает подключение плагина `sbt-assembly` для сборки единого JAR-файла:

    ```scala
    addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "0.14.6")
    ```

1. Создайте файл `build.sbt` с описанием версии Scala, зависимостей и стратегии их слияния в одном JAR-файле:

    ```scala
    scalaVersion  := "2.11.12"

    libraryDependencies ++= Seq(
        "org.apache.spark" %% "spark-core" % "2.4.4",
        "org.apache.spark" %% "spark-sql" % "2.4.4",

    )

    assemblyMergeStrategy in assembly := {
      case PathList("org","aopalliance", xs @ _*) => MergeStrategy.last
      case PathList("javax", "inject", xs @ _*) => MergeStrategy.last
      case PathList("javax", "servlet", xs @ _*) => MergeStrategy.last
      case PathList("javax", "activation", xs @ _*) => MergeStrategy.last
      case PathList("org", "apache", xs @ _*) => MergeStrategy.last
      case PathList("com", "google", xs @ _*) => MergeStrategy.last
      case PathList("com", "esotericsoftware", xs @ _*) => MergeStrategy.last
      case PathList("com", "codahale", xs @ _*) => MergeStrategy.last
      case PathList("com", "yammer", xs @ _*) => MergeStrategy.last
      case "about.html" => MergeStrategy.rename
      case "overview.html" => MergeStrategy.last
      case "META-INF/ECLIPSEF.RSA" => MergeStrategy.last
      case "META-INF/mailcap" => MergeStrategy.last
      case "META-INF/mimetypes.default" => MergeStrategy.last
      case "plugin.properties" => MergeStrategy.last
      case "log4j.properties" => MergeStrategy.last
      case x =>
        val oldStrategy = (assemblyMergeStrategy in assembly).value
        oldStrategy(x)
    }
    ```
1. Создайте файл `src/main/scalaapp.scala` с кодом приложения:

    ```scala
    package com.yandex.cloud.dataproc.scala

    import org.apache.spark.{SparkConf, SparkContext}
    import org.apache.spark.sql.SQLContext

      object Main {
        def main(args: Array[String]) {
          if (args.length != 2){ //проверяем аргумент
            System.err.println("Usage spark-app.jar <input_dir> <output_dir>");
            System.exit(-1);
          }
          val inDir = args(0); //URI на исходные данные
          val outDir = args(1); //URI на директорию куда записать результат
          val conf = new SparkConf().setAppName("Month Stat - Scala App")
          val sc = new SparkContext(conf)
          val sqlContext = new org.apache.spark.sql.SQLContext(sc)
          val df = sqlContext.read.parquet(inDir)
          val monthStat = df.groupBy("Month").count()
          val defaultFS = sc.hadoopConfiguration.get("fs.defaultFS") //получить эндпоинт сервера HDFS
          val jobId = conf.get("spark.yarn.tags").replace("dataproc_job_", ""); //получить идентификатор задания
          if (outDir.toLowerCase().startsWith("s3a://")) {
            monthStat.repartition(1).write.format("csv").save(outDir + jobId)
          } else {
            monthStat.repartition(1).write.format("csv").save(defaultFS + "/" + outDir + jobId)
          }

          sc.stop()
        }
      }
    ```
1. Запустите сборку приложения в папке `spark-app`:

    ```bash
    sbt clean && sbt compile && sbt assembly
    ```

Файл будет доступен по следующему пути: `./target/scala-2.11/spark-app-assembly-0.1.0-SNAPSHOT.jar`

#### Загрузите JAR-файл в {{ objstorage-name }} {#scala-upload}

Чтобы Spark имел доступ к собранному JAR-файлу, загрузите файл в бакет {{ objstorage-name }}, к которому есть доступ у сервисного аккаунта кластера {{ dataproc-name }}. Загрузить файл можно с помощью [s3cmd](../../storage/tools/s3cmd.md):

```bash
s3cmd put ./target/scala-2.11/spark-app_2.11-0.1.0-SNAPSHOT.jar \
    s3://<ваш бакет>/bin/
```

Для текущего примера файл загружается по адресу `s3://<ваш бакет>/bin/spark-app_2.11-0.1.0-SNAPSHOT.jar`.

### Запустите задачу в кластере {{ dataproc-name }} {#scala-run}

Чтобы Data Proc Agent смог забрать задачу из подсети пользователя, необходимо настроить [NAT-шлюз](../../vpc/concepts/gateways.md). О том, как это сделать, читайте в разделе [{#T}](./configure-network.md).

Ниже приведены два шаблона команды CLI для запуска Spark-задания — с выводом результата в {{ objstorage-name }} и в HDFS.

{% list tabs %}

- {{objstorage-name}}

  ```bash
  {{ yc-dp }} job create-spark \
     --cluster-id=<идентификатор кластера> \
     --name=<имя задачи> \
     --main-class="com.yandex.cloud.dataproc.scala.Main" \
     --main-jar-file-uri="s3a://<ваш бакет>/bin/spark-app_2.11-0.1.0-SNAPSHOT.jar" \
     --args="s3a://yc-mdb-examples/dataproc/example01/set01" \
     --args="s3a://<ваш бакет>/jobs_results/"
  ```

- HDFS

  CSV-файл с результатом создается в папке `/tmp/jobs/<идентификатор задачи>/` в HDFS.

  ```bash
  {{ yc-dp }} job create-spark \
     --cluster-id=<идентификатор кластера> \
     --name=<имя задачи> \
     --main-class="com.yandex.cloud.dataproc.scala.Main" \
     --main-jar-file-uri="s3a://<ваш бакет>/bin/spark-app_2.11-0.1.0-SNAPSHOT.jar" \
     --args="s3a://yc-mdb-examples/dataproc/example01/set01" \
     --args="tmp/jobs/"
  ```

  Пример сообщения об успешном запуске задачи:

  ```text
  done (1m2s)
  id: {your_job_id}
  cluster_id: {your_cluster_id}
  name: test02
  status: DONE
  spark_job:
    args:
    - s3a://yc-mdb-examples/dataproc/example01/set01
    - s3a://<ваш бакет>/jobs_results/
    main_jar_file_uri: s3a://<ваш бакет>/bin/spark-app-assembly-0.1.0-SNAPSHOT.jar
    main_class: com.yandex.cloud.dataproc.scala.Main
  ```

{% endlist %}

### Запуск PySpark Job {#cli-python}

Основные шаги:

1. Подготовьте код Python-приложения.
2. Загрузите файл с кодом в бакет {{ objstorage-name }}, к которому есть доступ у сервисного аккаунта кластера.
3. Запустите задачу в кластере {{ dataproc-name }}.

Версия Python-приложения должна совпадать с версией, доступной из образа. Проверить версию можно на странице [{#T}](../concepts/environment.md). Для версии образа 2.0 следует использовать Python 3.8.10.

Чтобы запустить приложение:

1. Создайте файл `job.py` со следующим кодом:

    ```python
    import sys

    from pyspark import SparkContext, SparkConf
    from pyspark.sql import SQLContext

    def main():

        if len(sys.argv) != 3:
            print('Usage job.py <input_dir> <output_dir>')
            sys.exit(1)

        in_dir = sys.argv[1]
        out_dir = sys.argv[2]

        conf = SparkConf().setAppName('Month Stat - Python')
        sc = SparkContext(conf=conf)
        sql = SQLContext(sc)
        df = sql.read.parquet(in_dir)
        month_stat = df.groupBy('Month').count()
        job_id = dict(sc._conf.getAll())['spark.yarn.tags'].replace('dataproc_job_', '')
        if out_dir.startswith('s3a://'):
            month_stat.repartition(1).write.format('csv').save(out_dir + job_id)
        else:
            default_fs = sc._jsc.hadoopConfiguration().get('fs.defaultFS')
            month_stat.repartition(1).write.format('csv').save(default_fs + out_dir + job_id)


    if __name__ == '__main__':
        main()
    ```

1. Чтобы PySpark имел доступ к вашему коду, загрузите файл `job.py` в бакет {{ objstorage-name }}, к которому есть доступ у сервисного аккаунта кластера {{ dataproc-name }}. Загрузить файл можно с помощью [s3cmd](../../storage/tools/s3cmd.md):

    ```bash
    s3cmd put ./job.py s3://<ваш бакет>/bin/
    ```

1. Запустите команду CLI с записью результата:

   * В бакет {{ objstorage-name }}:

      ```bash
      {{ yc-dp }} job create-pyspark \
         --cluster-id=<идентификатор кластера> \
         --name=<имя задачи> \
         --main-python-file-uri="s3a://<ваш бакет>/bin/job.py" \
         --args="s3a://yc-mdb-examples/dataproc/example01/set01" \
         --args="s3a://<ваш бакет>/jobs_results/"
      ```

   * В HDFS:

      ```bash
      {{ yc-dp }} job create-pyspark \
         --cluster-id=<идентификатор кластера> \
         --name=<имя задачи> \
         --main-python-file-uri="s3a://<ваш бакет>/bin/job.py" \
         --args="s3a://yc-mdb-examples/dataproc/example01/set01" \
         --args="tmp/jobs/"
      ```

     CSV-файл с результатом создается в папке `/tmp/jobs/<идентификатор задачи>/` в HDFS.

1. Чтобы посмотреть логи задачи:

   ```bash
   {{ yc-dp }} job log <имя задачи> \
      --cluster-id=<идентификатор кластера>
   ```

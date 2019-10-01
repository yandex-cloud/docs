# Запуск и управление приложениями для Spark и PySpark

Следуя этой инструкции вы рассчитаете статистику по воздушному трафику США за 2018-й год по данным с сайта [transtats.bts.gov](https://transtats.bts.gov/). Набор данных подготовлен в формате [Parquet](https://parquet.apache.org/) в публичном бакете {{ storage-full-name }} с именем `yc-mdb-examples`.

Для работы с {{ storage-name }} рекомендуется [настроить S3cmd](../../storage/instruments/s3cmd.md).

Список файлов можно получить с помощью команды:

```bash
$ s3cmd ls s3://yc-mdb-examples/dataproc/example01/set01/

2019-09-13 17:17  19327838   s3://yc-mdb-examples/dataproc/example01/set01/On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2018_1.parquet
2019-09-13 17:17  21120204   s3://yc-mdb-examples/dataproc/example01/set01/On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2018_10.parquet
...
```

{% note info %}

Перед настройкой доступа к сервисам Облака и интернет-ресурсам убедитесь в правильности [настройки сети кластера](./configure-network.md).

{% endnote %}

Spark-приложения можно запускать с помощью:

1. Spark Shell, доступный для Scala и Python. Более подробно с ним можно ознакомиться на странице [Quick Start - Spark Documentation](https://spark.apache.org/docs/latest/quick-start).
1. Скрипта `spark-submit` для запуска готовых приложений на кластере. Более подробно этот способ описан можно ознакомиться на странице [Submitting Applications](https://spark.apache.org/docs/latest/submitting-applications.html#submitting-applications).


## Использование интерактивного Spark Shell

1. Запустите Spark Shell на мастер-хосте:

   ```bash
   pyspark
   ```
   Количество executer'ов и ядер ограничено только конфигурацией вашего кластера {{ dataproc-name }}.
1. Построчно введите следующий код:

   ```python
   sc._jsc.hadoopConfiguration().set("spark.hadoop.fs.s3a.endpoint", "storage.yandexcloud.net")
   sc._jsc.hadoopConfiguration().set("fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.AnonymousAWSCredentialsProvider")
   sql = SQLContext(sc)
   df = sql.read.parquet("s3a://yc-mdb-examples/dataproc/example01/set01")
   ```
   
   После этого текущая сессия будет содержать DataFrame `df` с прочитанными данными.
1. Чтобы посмотреть схему этого DataFrame выполните команду:
   ```
   df.printSchema()
   ```
   В терминале будет выведен список столбцов с их типами.
1. Рассчитайте статистику перелетов по месяцам и найдите топ-10 городов по количеству вылетов:
   * Количество перелетов по месяцам:

     ```python
     df.groupBy("Month").count().orderBy("Month").show()
     ```
   * Топ-10 городов с самых большим количеством вылетов:

     ```
     df.groupBy("OriginCityName").count().orderBy("count", ascending=False).show(10)
     ```


## Использование Spark Submit

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
              conf.set("spark.hadoop.fs.s3a.endpoint", "storage.yandexcloud.net")
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
      $ spark-submit month_stat.py`
      ```
  1. Посмотрите результат выполнения в HDFS, в списке файлов результата запуска приложения:
  
      ```bash
      $ hdfs dfs -ls /tmp/month_stat
      ```

- Spark Submit

  В данном примере рассмотрим сборку и запуск приложения на языке программирования [Scala](https://scala-lang.org). Рекомендуется использовать [sbt](https://scala-lang.org/download/) для сборки приложений.
  
  1. Чтобы узнать необходимую версию Scala, выполните команду `scala -version` на мастер-хосте.
     Для Spark приложений рекомендуется строго соблюдать версию Scala и версии библиотек, которые развернуты в кластере {{ dataproc-name }} и используются в приложении. Набор библиотек по умолчанию можно посмотреть в каталоге `/usr/lib/spark/jars`.
  1. Чтобы собрать приложение, создайте папку, например `spark-app`.
  1. В созданную папку добавьте файл с путем `./src/main/scala`.
  1. Скопируйте следующий код в файл `app.scala`:
   
      ```scala
      package com.yandex.cloud.mdb.dataproc.scala
      
      import org.apache.spark.{SparkConf, SparkContext}
      import org.apache.spark.sql.SQLContext
      
        object Main {
          def main(args: Array[String]) {
            val conf = new SparkConf().setAppName("Month Stat - Scala App")
            val sc = new SparkContext(conf)
            sc.hadoopConfiguration.set("spark.hadoop.fs.s3a.endpoint", "storage.yandexcloud.net")
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
      $ sbt complie
      $ sbt pacakge
      ```
  1. Запустите получившееся приложение:
  
      ```bash
      $ spark-submit --class com.yandex.cloud.mdb.dataproc.scala.Main ./target/scala-2.11/scala-app_2.11-0.1-SNAPSHOT.jar
      ```
  1. Посмотрите результат выполнения в HDFS, в списке файлов результата запуска приложения:
  
      ```bash
      $ hdfs dfs -ls /tmp/month_stat
      ```

{% endlist%}


## Завершение работы приложения 

По умолчанию, ресурсы для запускаемого приложения управляются YARN. Если по приложение необходимо завершить или убрать из очереди, используйте утилиту `yarn`:
  
1. Выведите список приложений:
  
   ```bash
   $ yarn application -list
   ```
1. Завершите ненужное приложение:
  
   ```bash
   $ yarn application -kill <application_id>
   ```
  
Более подробно с командами YARN можно ознакомиться на странице [YARN Commands](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/YarnCommands.html).

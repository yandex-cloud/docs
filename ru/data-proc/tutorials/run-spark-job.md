---
title: "Apache Spark и PySpark. Запуск и управление приложениями"
keywords:
  - apache spark
  - spark
  - PySpark
---

# Запуск и управление приложениями для Spark и PySpark

Существует несколько способов запустить Spark- и PySpark-задания в кластере {{ dataproc-name }}:

* [Spark Shell](#spark-shell) (командная оболочка для языков программирования Scala и Python). Расчеты запускаются не с помощью скрипта, а построчно. Подробнее о Spark Shell читайте в [документации Spark](https://spark.apache.org/docs/latest/quick-start).
* [Скрипт spark-submit](#spark-submit). Сохраняет результаты расчета в HDFS. Подробнее о `spark-submit` читайте в [документации Spark](https://spark.apache.org/docs/latest/submitting-applications.html#submitting-applications).
* [Команды CLI {{ yandex-cloud }}](#run-cli-jobs). Позволяют сохранить результаты расчета не только в HDFS, но и в [бакете {{ objstorage-full-name }}](../../storage/concepts/bucket.md).

Ниже рассматривается пример, по которому будет рассчитана статистика по воздушному трафику США за 2018 год по данным с сайта [transtats.bts.gov](https://transtats.bts.gov/). Набор данных представлен в формате [Parquet](https://parquet.apache.org/) и находится в публичном бакете {{ objstorage-full-name }} с именем `yc-mdb-examples`.

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=resources %}

- Вручную {#manual}

    1. [Создайте сеть](../../vpc/operations/network-create.md) с именем `data-proc-network`. При создании выключите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
    1. В сети `data-proc-network` [создайте подсеть](../../vpc/operations/subnet-create.md) со следующими параметрами:

        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** — `data-proc-subnet-a`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** — `{{ region-id }}-a`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** — `192.168.1.0/24`.

    1. [Создайте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) и таблицу маршрутизации с именем `data-proc-route-table` в сети `data-proc-network`. Привяжите таблицу к подсети `data-proc-subnet-a`.
    1. В сети `data-proc-network` [создайте группу безопасности](../../vpc/operations/security-group-create.md) с именем `data-proc-security-group` и следующими правилами:

        * По одному правилу для входящего и исходящего служебного трафика:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**/**{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`.

        * Правило для входящего трафика, чтобы подключаться к хостам подкластеров из интернета:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-ssh }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

        * Правило для исходящего HTTPS-трафика:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-https }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

        * Правило для исходящего HTTP-трафика:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-http }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `data-proc-sa` с ролями:

        * [dataproc.agent](../../data-proc/security/index.md#dataproc-agent);
        * [storage.admin](../../storage/security/index.md#storage-admin).

    1. [Создайте бакет {{ objstorage-full-name }}](../../storage/operations/buckets/create.md) `data-proc-bucket` с ограниченным доступом.
    1. [Предоставьте сервисному аккаунту](../../storage/operations/buckets/edit-acl.md) `data-proc-sa` разрешение `READ и WRITE` на бакет `data-proc-bucket`.
    1. [Создайте кластер {{ dataproc-name }}](../operations/cluster-create.md) любой подходящей конфигурации с настройками:

        * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** — `data-proc-sa`.
        * **{{ ui-key.yacloud.mdb.forms.config_field_zone }}** — `{{ region-id }}-a`.
        * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}** — `data-proc-bucket`.
        * **{{ ui-key.yacloud.mdb.forms.config_field_network }}** — `data-proc-network`.
        * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — `data-proc-security-group`.
        * **{{ ui-key.yacloud.mdb.forms.field_assign-public-ip }}** для подкластеров — предоставлен.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [data-proc-for-spark-jobs.tf](https://github.com/yandex-cloud-examples/yc-data-proc-spark-pyspark/blob/main/data-proc-for-spark-jobs.tf).

        В этом файле описаны:

        * сеть;
        * подсеть;
        * NAT-шлюз и таблица маршрутизации;
        * группы безопасности;
        * сервисный аккаунт для работы с ресурсами кластера;
        * бакет, в котором будут храниться зависимости заданий и результаты их выполнения;
        * кластер {{ dataproc-name }}.

    1. Укажите в файле конфигурации `data-proc-for-spark-jobs.tf` необходимые параметры.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Использование Spark Shell {#spark-shell}

1. [Подключитесь по SSH](../operations/connect.md#data-proc-ssh) к хосту-мастеру кластера {{ dataproc-name }}.
1. Запустите Spark Shell на хосте-мастере:

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

Spark Submit позволяет запускать заранее написанные приложения через скрипт `spark-submit`. Для примера рассчитывается количество перелетов по месяцам. 

{% list tabs %}

- PySpark Submit

  1. [Подключитесь по SSH](../operations/connect.md#data-proc-ssh) к хосту-мастеру кластера {{ dataproc-name }}.
  1. На хосте-мастере создайте файл `month_stat.py` со следующим кодом:

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

  1. [Подключитесь по SSH](../operations/connect.md#data-proc-ssh) к хосту-мастеру кластера {{ dataproc-name }}.
  1. [Установите](https://docs.scala-lang.net/getting-started/index.html#using-the-scala-installer-recommended-way) стандартную утилиту сборки sbt для Scala. Она устанавливается вместе с языком программирования Scala.
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

  1. Подготовьте данные для сборки приложения:

      1. Чтобы узнать установленную версию Scala, выполните команду `scala -version`.
      1. Чтобы узнать версии `spark-core` и `spark-sql`, посмотрите содержимое каталога `/usr/lib/spark/jars`:

          ```bash
          ls /usr/lib/spark/jars
          ```

          Версии указаны в названии JAR-файлов. Пример:

          ```text
          spark-core_2.12-3.0.3.jar
          spark-sql_2.12-3.0.3.jar
          ```

          Нужный номер версии — `3.0.3`.

      1. В папке `spark-app` создайте файл `build.sbt` с конфигурацией:

          ```scala
          scalaVersion := "<версия_Scala>"

          libraryDependencies ++= Seq(
              "org.apache.spark" %% "spark-core" % "<версия_spark-core>" % "provided",
              "org.apache.spark" %% "spark-sql" % "<версия_spark-sql>" % "provided"
          )
          ```

          Пример:

          ```scala
          scalaVersion := "2.12.10"

          libraryDependencies ++= Seq(
              "org.apache.spark" %% "spark-core" % "3.0.3" % "provided",
              "org.apache.spark" %% "spark-sql" % "3.0.3" % "provided"
          )
          ```

  1. Скомпилируйте и соберите JAR-файл:

      ```bash
      sbt compile && sbt package
      ```

  1. Получите название собранного JAR-файла:

      ```bash
      ls ~/spark-app/target/scala-<версия_Scala>
      ```

      Результат — `spark-app_2.12-0.1.0-SNAPSHOT.jar`.

  1. Запустите получившееся приложение:

      ```bash
      /usr/bin/spark-submit --class com.yandex.cloud.dataproc.scala.Main target/scala-<версия_Scala>/<название_собранного_JAR-файла>
      ```

      Пример:

      ```bash
      /usr/bin/spark-submit --class com.yandex.cloud.dataproc.scala.Main target/scala-2.12/spark-app_2.12-0.1.0-SNAPSHOT.jar
      ```

  1. Результат работы приложения будет выгружен в HDFS. Список получившихся файлов можно вывести командой:

      ```bash
      hdfs dfs -ls /tmp/month_stat
      ```

{% endlist %}

### Завершение работы приложения {#yarn-kill}

По умолчанию ресурсы запускаемого приложения управляются компонентом YARN. Если приложение необходимо завершить или убрать из очереди, используйте утилиту `yarn`:

1. Выведите список приложений:

   ```bash
   yarn application -list
   ```
1. Завершите ненужное приложение:

   ```bash
   yarn application -kill <идентификатор_приложения>
   ```

Более подробно с командами YARN можно ознакомиться на странице [YARN Commands](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/YarnCommands.html).

## Запуск заданий (jobs) с помощью CLI {{ yandex-cloud }} {#run-cli-jobs}

{% include [cli-job-intro](../../_includes/data-proc/cli-job-intro.md) %}

Результаты расчета можно сохранить в HDFS в кластере {{ dataproc-name }} или в бакете `data-proc-bucket`, указанном при создании кластера.

Служебная и отладочная информация сохраняется в бакете `data-proc-bucket`. Для каждого задания агент {{ dataproc-name }} создает отдельную папку с путем вида `dataproc/clusters/<идентификатор_кластера>/jobs/<идентификатор_задачи>`.

{% include [get-logs-info](../../_includes/data-proc/note-info-get-logs.md) %}

Ниже приведены два варианта приложения — для [Python](#cli-python) и [Scala](#cli-scala).

### Запуск PySpark-задания {#cli-python}

Чтобы запустить PySpark-задание:

1. [Установите дополнительные зависимости](#infra-for-python).
1. [Подготовьте и запустите PySpark-задание](#run-cli-pyspark).

#### Установите дополнительные зависимости {#infra-for-python}

На локальном компьютере выполните действия:

1. {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Установите и настройте](../../storage/tools/s3cmd.md) консольный клиент S3cmd для работы с {{ objstorage-full-name }}.
1. Установите Python. Убедитесь, что версия Python совпадает с версией, доступной из образа. Проверить версию можно в разделе [{#T}](../concepts/environment.md). Для версии образа 2.0 используйте Python 3.8.10:

    ```bash
    sudo apt update && sudo apt install python3.8
    ```

#### Подготовьте и запустите PySpark-задание {#run-cli-pyspark}

1. Создайте файл `job.py` со следующим кодом:

    ```python
    import sys

    from pyspark import SparkContext, SparkConf
    from pyspark.sql import SQLContext

    def main():

        if len(sys.argv) != 3:
            print('Usage job.py <входная_директория> <выходная_директория>')
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

1. Чтобы PySpark имел доступ к вашему коду, загрузите файл `job.py` в бакет {{ objstorage-name }}, к которому есть доступ у сервисного аккаунта кластера {{ dataproc-name }}:

    ```bash
    s3cmd put ./job.py s3://data-proc-bucket/bin/
    ```

1. Запустите задание.

    Команда для запуска зависит от того, где нужно сохранить результаты задания: в {{ objstorage-name }} или HDFS.

    {% list tabs group=storage_system %}

    - {{ objstorage-name }} {#storage}

      ```bash
      {{ yc-dp }} job create-pyspark \
         --cluster-id=<идентификатор_кластера> \
         --name=<имя_задачи> \
         --main-python-file-uri="s3a://data-proc-bucket/bin/job.py" \
         --args="s3a://yc-mdb-examples/dataproc/example01/set01" \
         --args="s3a://data-proc-bucket/jobs_results/"
      ```

      В команде укажите:

      * `--cluster-id` — идентификатор кластера. Его можно получить со [списком кластеров в каталоге](../operations/cluster-list.md#list).
      * `--name` — произвольное имя Spark-задания.

      CSV-файл с результатом сохранится в бакете `data-proc-bucket`.

    - Директория HDFS {#hdfs}

      ```bash
      {{ yc-dp }} job create-pyspark \
         --cluster-id=<идентификатор_кластера> \
         --name=<имя_задачи> \
         --main-python-file-uri="s3a://data-proc-bucket/bin/job.py" \
         --args="s3a://yc-mdb-examples/dataproc/example01/set01" \
         --args="tmp/jobs/"
      ```

      В команде укажите:

      * `--cluster-id` — идентификатор кластера. Его можно получить со [списком кластеров в каталоге](../operations/cluster-list.md#list).
      * `--name` — произвольное имя Spark-задания.

      CSV-файл с результатом сохранится в папке `/tmp/jobs/<идентификатор_задачи>/` в HDFS.

    {% endlist %}

1. (Опционально) Посмотрите логи задачи:

    ```bash
    {{ yc-dp }} job log <идентификатор_задачи> --cluster-id=<идентификатор_кластера>
    ```

### Запуск Spark-задания {#cli-scala}

Чтобы запустить Spark-задание:

1. [Установите дополнительные зависимости](#infra-for-scala).
1. [Соберите Scala-приложение](#scala-build).
1. [Загрузите JAR-файл в {{ objstorage-name }}](#scala-upload).
1. [Запустите Spark-задание в кластере {{ dataproc-name }}](#scala-run).

#### Установите дополнительные зависимости {#infra-for-scala}

1.  {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Подключитесь по SSH](../operations/connect.md#data-proc-ssh) к хосту-мастеру кластера {{ dataproc-name }}.
1. [Установите](https://docs.scala-lang.net/getting-started/index.html#using-the-scala-installer-recommended-way) стандартную утилиту сборки `sbt` для Scala. Она устанавливается вместе с языком программирования Scala.
1. [Установите и настройте](../../storage/tools/s3cmd.md) консольный клиент S3cmd для работы с {{ objstorage-full-name }}.

#### Соберите Scala-приложение {#scala-build}

Чтобы упростить управление зависимостями, соберите приложение в один JAR-файл (fat JAR) с помощью плагина [sbt-assembly](https://github.com/sbt/sbt-assembly):

1. Создайте папку `spark-app`, в ней — папки `project` и `src/main/scala`.
1. Создайте файл `spark-app/project/plugins.sbt`, который описывает подключение плагина `sbt-assembly` для сборки единого JAR-файла:

    ```scala
    addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "<версия_sbt-assembly>")
    ```

    Версию плагина `sbt-assembly` см. в его [репозитории](https://github.com/sbt/sbt-assembly), в разделе **Releases**.

1. Узнайте установленную версию Scala с помощью команды `scala -version`.
1. Создайте файл `spark-app/build.sbt` с описанием зависимостей и стратегии их слияния в одном JAR-файле. В файле `build.sbt` укажите версию Scala:

    ```scala
    scalaVersion := "<версия_Scala>"

    libraryDependencies ++= Seq(
        "org.apache.spark" %% "spark-core" % "2.4.4",
        "org.apache.spark" %% "spark-sql" % "2.4.4",
    )

    assembly / assemblyMergeStrategy := {
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
      case "git.properties" => MergeStrategy.last
      case x =>
        val oldStrategy = (assembly / assemblyMergeStrategy).value
        oldStrategy(x)
    }
    ```
1. Создайте файл `spark-app/src/main/scala/app.scala` с кодом приложения:

    ```scala
    package com.yandex.cloud.dataproc.scala

    import org.apache.spark.{SparkConf, SparkContext}
    import org.apache.spark.sql.SQLContext

      object Main {
        def main(args: Array[String]) {
          if (args.length != 2){ //проверяем аргумент
            System.err.println("Usage spark-app.jar <входная_директория> <выходная_директория>");
            System.exit(-1);
          }
          val inDir = args(0); //URI на исходные данные
          val outDir = args(1); //URI на директорию, куда записать результат
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

    {% cut "В случае ошибки `Error looking up function 'stat'`" %}

    Если вы получили ошибку `java.lang.UnsatisfiedLinkError: Error looking up function 'stat': java: undefined symbol: stat` и ОС хоста-мастера — Ubuntu, запустите каждую команду `sbt` с флагом `-Dsbt.io.jdktimestamps=true`:

    ```bash
    sbt clean -Dsbt.io.jdktimestamps=true && \
    sbt compile -Dsbt.io.jdktimestamps=true && \
    sbt assembly -Dsbt.io.jdktimestamps=true
    ```

    {% endcut %}

Файл будет доступен по следующему пути: `spark-app/target/scala-<версия_Scala>/spark-app-assembly-0.1.0-SNAPSHOT.jar`.

#### Загрузите JAR-файл в {{ objstorage-name }} {#scala-upload}

Чтобы Spark имел доступ к собранному JAR-файлу, загрузите файл в бакет `data-proc-bucket`. Загрузить файл можно с помощью [s3cmd](../../storage/tools/s3cmd.md):

```bash
s3cmd put ~/spark-app/target/scala-<версия_Scala>/spark-app-assembly-0.1.0-SNAPSHOT.jar s3://data-proc-bucket/bin/
```

Файл загружается по адресу `s3://data-proc-bucket/bin/spark-app-assembly-0.1.0-SNAPSHOT.jar`.

#### Запустите Spark-задание в кластере {{ dataproc-name }} {#scala-run}

1. Отключитесь от хоста-мастера кластера.
1. Запустите задание.

    Команда для запуска зависит от того, где нужно сохранить результаты задания: в {{ objstorage-name }} или HDFS.

    {% list tabs group=storage_system %}

    - {{ objstorage-name }} {#storage}

      ```bash
      {{ yc-dp }} job create-spark \
         --cluster-id=<идентификатор_кластера> \
         --name=<имя_задачи> \
         --main-class="com.yandex.cloud.dataproc.scala.Main" \
         --main-jar-file-uri="s3a://data-proc-bucket/bin/spark-app-assembly-0.1.0-SNAPSHOT.jar" \
         --args="s3a://yc-mdb-examples/dataproc/example01/set01" \
         --args="s3a://data-proc-bucket/jobs_results/"
      ```

      В команде укажите:

      * `--cluster-id` — идентификатор кластера. Его можно получить со [списком кластеров в каталоге](../operations/cluster-list.md#list).
      * `--name` — произвольное имя Spark-задания.

      CSV-файл с результатом сохранится в бакете `data-proc-bucket`.

    - Директория HDFS {#hdfs}

      ```bash
      {{ yc-dp }} job create-spark \
         --cluster-id=<идентификатор_кластера> \
         --name=<имя_задачи> \
         --main-class="com.yandex.cloud.dataproc.scala.Main" \
         --main-jar-file-uri="s3a://data-proc-bucket/bin/spark-app-assembly-0.1.0-SNAPSHOT.jar" \
         --args="s3a://yc-mdb-examples/dataproc/example01/set01" \
         --args="tmp/jobs/"
      ```

      В команде укажите:

      * `--cluster-id` — идентификатор кластера. Его можно получить со [списком кластеров в каталоге](../operations/cluster-list.md#list).
      * `--name` — произвольное имя Spark-задания.

      CSV-файл с результатом сохранится в папке `/tmp/jobs/<идентификатор_задачи>/` в HDFS.

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
        - s3a://data-proc-bucket/jobs_results/
        main_jar_file_uri: s3a://data-proc-bucket/bin/spark-app-assembly-0.1.0-SNAPSHOT.jar
        main_class: com.yandex.cloud.dataproc.scala.Main
      ```

    {% endlist %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=resources %}

- Вручную {#manual}

    1. [Удалите кластер {{ dataproc-name }}](../operations/cluster-delete.md).
    1. Если вы зарезервировали публичные статические IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).
    1. [Удалите подсеть](../../vpc/operations/subnet-delete.md).
    1. Удалите таблицу маршрутизации и NAT-шлюз.
    1. [Удалите сеть](../../vpc/operations/network-delete.md).

- {{ TF }} {#tf}

    Чтобы удалить инфраструктуру, [созданную с помощью {{ TF }}](#infra):

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `data-proc-for-spark-jobs.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в конфигурационных файлах есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Все ресурсы, которые были описаны в конфигурационном файле, будут удалены.

{% endlist %}

# Запуск заданий с удаленных хостов, не входящих в кластер {{ dataproc-name }}

В этом руководстве показывается, как с помощью [утилиты spark-submit](https://spark.apache.org/docs/latest/submitting-applications.html#submitting-applications) запускать Spark-задания в кластере {{ dataproc-name }} с хостов, не входящих в кластер {{ dataproc-name }}.

{% note info %}

Задания в кластере {{ dataproc-name }} также можно запускать из {{ ml-platform-full-name }}. Подробнее см. в разделе [{#T}](../../datasphere/concepts/data-proc.md#session).

{% endnote %}

## Перед началом работы {#before-you-begin}

Создайте и настройте хост для удаленного запуска заданий на кластере {{ dataproc-name }}:


{% list tabs %}

- Версия образа 1.4

  1. [Создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) с операционной системой Ubuntu 16.04 LTS.
  1. Чтобы обеспечить сетевой доступ к кластеру {{ dataproc-name }} с созданной ВМ, [настройте группы безопасности](../operations/connect.md#configuring-security-groups) кластера.
  1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по [SSH](../../glossary/ssh-keygen.md):

      ```bash
      ssh -A <имя_пользователя>@<FQDN ВМ>
      ```

  1. Скопируйте настройки репозитория с любого из хостов кластера {{ dataproc-name }}. Для этого выполните последовательность команд на созданной виртуальной машине.
     1. Скопируйте адрес репозитория:

        ```bash
        ssh root@<FQDN хоста кластера> \
        "cat /etc/apt/sources.list.d/yandex-dataproc.list" | \
        sudo tee /etc/apt/sources.list.d/yandex-dataproc.list
        ```

     1. Скопируйте gpg-ключ для верификации подписей deb-пакетов:

        ```bash
        ssh root@<FQDN хоста кластера> \
        "cat /srv/dataproc.gpg" | sudo apt-key add -
        ```

     1. Обновите кэш репозиториев:

        ```bash
        sudo apt update
        ```

  1. Установите необходимые пакеты:

     ```bash
     sudo apt install openjdk-8-jre-headless hadoop-client hadoop-hdfs spark-core spark-python
     ```

     {% note info %}

     Пакет `spark-python` необходим только для запуска заданий PySpark.

     {% endnote %}

  1. Скопируйте конфигурационные файлы Hadoop и Spark:

     ```bash
     sudo -E scp -r \
         root@<FQDN хоста кластера>:/etc/hadoop/conf/* \
         /etc/hadoop/conf/ && \
     sudo -E scp -r \
         root@<FQDN хоста кластера>:/etc/spark/conf/* \
         /etc/spark/conf/
     ```

  1. Создайте пользователя `sparkuser`, от имени которого будут запускаться задания:

     ```bash
     sudo useradd sparkuser && \
     ssh root@<FQDN хоста кластера> "
       hadoop fs -mkdir /user/sparkuser
       sudo -u hdfs hdfs dfs -chown sparkuser:sparkuser /user/sparkuser
       sudo -u hdfs hdfs dfs -ls /user/sparkuser
     "
     ```

- Версия образа 2.0

  1. [Создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) с операционной системой Ubuntu 20.04 LTS.
  1. Чтобы обеспечить сетевой доступ к кластеру {{ dataproc-name }} с созданной ВМ, [настройте группы безопасности](../operations/connect.md#configuring-security-groups) кластера.
  1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по [SSH](../../glossary/ssh-keygen.md):

     ```bash
     ssh -A <имя_пользователя>@<FQDN ВМ>
     ```

  1. Скопируйте настройки репозитория с любого из хостов кластера {{ dataproc-name }}. Для этого выполните последовательность команд на созданной виртуальной машине.
     1. Скопируйте адрес репозитория:

        ```bash
        ssh ubuntu@<FQDN хоста кластера> \
        "cat /etc/apt/sources.list.d/yandex-dataproc.list" | \
        sudo tee /etc/apt/sources.list.d/yandex-dataproc.list
        ```

     1. Скопируйте gpg-ключ для верификации подписей deb-пакетов:

        ```bash
        ssh ubuntu@<FQDN хоста кластера> \
        "cat /srv/dataproc.gpg" | sudo apt-key add -
        ```

     1. Обновите кэш репозиториев:

        ```bash
        sudo apt update
        ```

  1. Установите необходимые пакеты:

     ```bash
     sudo apt install openjdk-8-jre-headless hadoop-client hadoop-hdfs spark-core spark-python
     ```

     {% note info %}

     Пакет `spark-python` необходим только для запуска заданий PySpark.

     {% endnote %}

  1. Скопируйте конфигурационные файлы Hadoop и Spark:

     ```bash
     sudo -E scp -r \
         ubuntu@<FQDN хоста кластера>:/etc/hadoop/conf/* \
         /etc/hadoop/conf/ && \
     sudo -E scp -r \
         ubuntu@<FQDN хоста кластера>:/etc/spark/conf/* \
         /etc/spark/conf/
     ```

  1. Создайте пользователя `sparkuser`, от имени которого будут запускаться задания:

     ```bash
     sudo useradd sparkuser && \
     ssh ubuntu@<FQDN хоста кластера> "
       hadoop fs -mkdir /user/sparkuser
       sudo -u hdfs hdfs dfs -chown sparkuser:sparkuser /user/sparkuser
       sudo -u hdfs hdfs dfs -ls /user/sparkuser
     "
     ```


{% endlist %}


## Запуск задания {#spark-submit}

{% list tabs %}

- Spark-задание

  1. Запустите задание с помощью команды:

     ```bash
     sudo -u sparkuser spark-submit \
          --master yarn \
          --deploy-mode cluster \
          --class org.apache.spark.examples.SparkPi \
              /usr/lib/spark/examples/jars/spark-examples.jar 1000
     ```

     Результат:

     ```text
     20/04/19 16:43:58 INFO client.RMProxy: Connecting to ResourceManager at rc1b-dataproc-m-ds7lj5gnnnqggbqd.{{ dns-zone }}/  10.13.13.18:8032
     20/04/19 16:43:58 INFO client.AHSProxy: Connecting to Application History server at rc1b-dataproc-m-ds7lj5gnnnqggbqd.{{   dns-zone }}/10.13.13.18:10200
     20/04/19 16:43:58 INFO yarn.Client: Requesting a new application from cluster with 4 NodeManagers
     ...
     20/04/19 16:43:58 INFO yarn.Client: Preparing resources for our AM container
     20/04/19 16:43:58 INFO yarn.Client: Uploading resource file:/usr/lib/spark/examples/jars/spark-examples.jar -> hdfs://  rc1b-dataproc-m-ds7lj5gnnnqggbqd.{{ dns-zone }}/user/sparkuser/.sparkStaging/application_1586176069782_0003/  spark-examples.jar
     20/04/19 16:43:58 INFO yarn.Client: Uploading resource file:/etc/spark/conf/hive-site.xml -> hdfs://  rc1b-dataproc-m-ds7lj5gnnnqggbqd.{{ dns-zone }}/user/sparkuser/.sparkStaging/application_1586176069782_0003/hive-site.  xml
     20/04/19 16:43:58 INFO yarn.Client: Uploading resource file:/tmp/spark-6dff3163-089b-4634-8f74-c8301d424567/  __spark_conf__8717606866210190000.zip -> hdfs://rc1b-dataproc-m-ds7lj5gnnnqggbqd.{{ dns-zone }}/user/sparkuser/.  sparkStaging/application_1586176069782_0003/__spark_conf__.zip
     20/04/19 16:44:00 INFO yarn.Client: Submitting application application_1586176069782_0003 to ResourceManager
     20/04/19 16:44:00 INFO impl.YarnClientImpl: Submitted application application_1586176069782_0003
     20/04/19 16:44:01 INFO yarn.Client: Application report for application_1586176069782_0003 (state: ACCEPTED)
     20/04/19 16:44:01 INFO yarn.Client:
        client token: N/A
        diagnostics: AM container is launched, waiting for AM container to Register with RM
        ApplicationMaster host: N/A
        ApplicationMaster RPC port: -1
        queue: default
        start time: 1587314639386
        final status: UNDEFINED
        tracking URL: http://rc1b-dataproc-m-ds7lj5gnnnqggbqd.{{ dns-zone }}:8088/proxy/application_1586176069782_0003/
        user: sparkuser
     20/04/19 16:44:05 INFO yarn.Client: Application report for application_1586176069782_0003 (state: RUNNING)
     20/04/19 16:44:05 INFO yarn.Client:
        client token: N/A
        diagnostics: N/A
        ApplicationMaster host: rc1b-dataproc-d-9cd9yoenm4npsznt.{{ dns-zone }}
        ApplicationMaster RPC port: 41648
        queue: default
        start time: 1587314639386
        final status: UNDEFINED
        tracking URL: http://rc1b-dataproc-m-ds7lj5gnnnqggbqd.{{ dns-zone }}:8088/proxy/application_1586176069782_0003/
        user: sparkuser
     20/04/19 16:44:06 INFO yarn.Client: Application report for application_1586176069782_0003 (state: RUNNING)
     20/04/19 16:44:07 INFO yarn.Client: Application report for application_1586176069782_0003 (state: RUNNING)
     20/04/19 16:44:08 INFO yarn.Client: Application report for application_1586176069782_0003 (state: RUNNING)
     20/04/19 16:44:09 INFO yarn.Client: Application report for application_1586176069782_0003 (state: FINISHED)
     20/04/19 16:44:09 INFO yarn.Client:
        client token: N/A
        diagnostics: N/A
        ApplicationMaster host: rc1b-dataproc-d-9cd9yoenm4npsznt.{{ dns-zone }}
        ApplicationMaster RPC port: 41648
        queue: default
        start time: 1587314639386
        final status: SUCCEEDED
        tracking URL: http://rc1b-dataproc-m-ds7lj5gnnnqggbqd.{{ dns-zone }}:8088/proxy/application_1586176069782_0003/
        user: sparkuser
     20/04/19 16:44:09 INFO util.ShutdownHookManager: Shutdown hook called
     20/04/19 16:44:09 INFO util.ShutdownHookManager: Deleting directory /tmp/spark-6dff3163-089b-4634-8f74-c8301d424567
     20/04/19 16:44:09 INFO util.ShutdownHookManager: Deleting directory /tmp/spark-826498b1-8dec-4229-905e-921203b7b1d0
     ```

  1. Проверьте статус выполнения с помощью утилиты [yarn application](https://hadoop.apache.org/docs/r2.10.0/hadoop-yarn/hadoop-yarn-site/YarnCommands.html#application):

     ```bash
     yarn application -status application_1586176069782_0003
     ```

     Результат:

     ```text
     20/04/19 16:47:03 INFO client.RMProxy: Connecting to ResourceManager at rc1b-dataproc-m-ds7lj5gnnnqggbqd.{{ dns-zone }}/10.13.13.18:8032
     20/04/19 16:47:03 INFO client.AHSProxy: Connecting to Application History server at rc1b-dataproc-m-ds7lj5gnnnqggbqd.{{ dns-zone }}/10.13.13.18:10200
     Application Report :
         Application-Id : application_1586176069782_0003
         Application-Name : org.apache.spark.examples.SparkPi
         Application-Type : SPARK
         User : sparkuser
         Queue : default
         Application Priority : 0
         Start-Time : 1587314639386
         Finish-Time : 1587314647621
         Progress : 100%
         State : FINISHED
         Final-State : SUCCEEDED
         Tracking-URL : rc1b-dataproc-m-ds7lj5gnnnqggbqd.{{ dns-zone }}:18080/history/application_1586176069782_0003/1
         RPC Port : 41648
         AM Host : rc1b-dataproc-d-9cd9yoenm4npsznt.{{ dns-zone }}
         Aggregate Resource Allocation : 141510 MB-seconds, 11 vcore-seconds
         Aggregate Resource Preempted : 0 MB-seconds, 0 vcore-seconds
         Log Aggregation Status : SUCCEEDED
         Diagnostics :
         Unmanaged Application : false
         Application Node Label Expression : <Not set>
         AM container Node Label Expression : <DEFAULT_PARTITION>
         TimeoutType : LIFETIME    ExpiryTime : UNLIMITED    RemainingTime : -1seconds
     ```

  1. Просмотрите журналы со всех запущенных контейнеров с помощью утилиты [yarn logs](https://hadoop.apache.org/docs/r2.10.0/hadoop-yarn/hadoop-yarn-site/YarnCommands.html#logs):

     ```bash
     sudo -u sparkuser yarn logs \
          -applicationId application_1586176069782_0003 | grep "Pi is"
     ```

     Результат:

     ```text
     Pi is roughly 3.14164599141646
     ```

- PySpark-задание

  1. На виртуальной машине создайте файл `month_stat.py` со следующим кодом:

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

  1. Скопируйте файл `month_stat.py` на мастер-хост кластера:

     ```bash
     sudo -E scp month_stat.py <имя_пользователя>@<FQDN хоста кластера>:~/month_stat.py
     ```

     {% include [user name](../../_includes/data-proc/tutorials/user-name-images.md) %}

  1. Запустите приложение:

     ```bash
     sudo -u sparkuser spark-submit \
          --master yarn \
          --deploy-mode cluster \
          month_stat.py
     ```

  1. Результат работы приложения будет выгружен в HDFS на кластере. Список получившихся файлов можно вывести командой:

     ```bash
     ssh <имя_пользователя>@<FQDN хоста кластера> "hdfs dfs -ls /tmp/month_stat"
     ```

     {% include [user name](../../_includes/data-proc/tutorials/user-name-images.md) %}

{% endlist %}

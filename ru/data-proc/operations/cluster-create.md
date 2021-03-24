# Создание кластера {{ dataproc-name }}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер.

  1. Нажмите кнопку **Создать ресурс** и выберите **Кластер {{ dataproc-name }}** в выпадающем списке.

  1. Введите имя кластера в поле **Имя кластера**. Имя кластера должно быть уникальным в рамках каталога.

  1. Выберите подходящую [версию образа](../concepts/environment.md) и компоненты, которые вы хотите использовать в кластере.

     {% note info %}

     Обратите внимание на то, что некоторые компоненты обязательны для использования других компонентов. Например, чтобы использовать Spark необходим YARN.

     {% endnote %}

  1. Вставьте в поле **Публичный ключ** публичную часть вашего SSH-ключа. Как сгенерировать и использовать SSH-ключи, читайте в [документации {{ compute-full-name }}](../../compute/operations/vm-connect/ssh.md).
  1. Выберите или создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), которому нужно разрешить доступ к кластеру.
  1. Выберите зону доступности для кластера.

  1. При необходимости задайте свойства Hadoop и его компонентов, например:

     ```
     hdfs:dfs.replication : 2
     hdfs:dfs.blocksize : 1073741824
     spark:spark.driver.cores : 1
     ```

     Доступные свойства перечислены в официальной документации компонентов:

     * [Hadoop](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/core-default.xml)
     * [HDFS](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml)
     * [YARN](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-common/yarn-default.xml)
     * [MapReduce](https://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/mapred-default.xml)
     * [Spark](https://spark.apache.org/docs/2.2.3/configuration.html#available-properties)
     * [Flume 1.8.0](https://flume.apache.org/releases/content/1.8.0/FlumeUserGuide.html#flume-properties)
     * [HBASE](https://hbase.apache.org/book.html#hbase_default_configurations)
     * [HIVE](https://cwiki.apache.org/confluence/display/Hive/Configuration+Properties)
     * [SQOOP](https://sqoop.apache.org/docs/1.4.6/SqoopUserGuide.html#_additional_import_configuration_properties)
     * [Tez 0.9.1](https://tez.apache.org/releases/0.9.1/tez-api-javadocs/configs/TezConfiguration.html)
     * [Zeppelin 0.7.3](https://zeppelin.apache.org/docs/0.7.3/install/configuration.html)
     * [ZooKeeper 3.4.6](http://zookeeper.apache.org/doc/r3.4.6/zookeeperAdmin#sc_configuration)

  1. Выберите или создайте сеть для кластера.
  1. Включите опцию **UI Proxy**, чтобы получить доступ к [веб-интерфейсам компонентов](../concepts/ui-proxy.md) {{ dataproc-name }}.
  1. Настройте подкластеры: не больше одного главного подкластера с управляющим хостом (обозначается как **Мастер**), и подкластеры для хранения данных или вычислений.

     Роли подкластеров (`Compute` и `Data`) различаются тем, что на `Data`-подкластерах можно разворачивать компоненты для хранения данных, а на `Compute` — компоненты обработки данных. Хранилище на подкластере `Compute` предназначено только для временного хранения обрабатываемых файлов.

  1. Для каждого подкластера можно настроить:

     * Количество хостов.
     * [Класс хостов](../concepts/instance-types.md) — платформа и вычислительные ресурсы, доступные хосту.
     * Размер и тип хранилища.
     * Подсеть сети, в которой расположен кластер.

  1. Для `Compute` подкластеров можно задать параметры [автоматического масштабирования](../concepts/autoscaling.md).

     {% include [note-info-service-account-roles](../../_includes/data-proc/service-account-roles.md) %}

     1. В блоке **Добавить подкластер** нажмите кнопку **Добавить**.
     1. В поле **Роли** выберите _COMPUTENODE_.
     1. В блоке **Масштабирование** включите настройку **Автоматическое масштабирование**.
     1. Задайте параметры автоматического масштабирования.
     1. По умолчанию в качестве метрики для автоматического масштабирования используется `yarn.cluster.containersPending`. Чтобы включить масштабирование на основе загрузки CPU, выключите настройку **Масштабирование по умолчанию** и укажите целевой уровень загрузки CPU.
     1. Нажмите кнопку **Добавить**.

  1. После того как все нужные подкластеры настроены, нажмите кнопку **Создать кластер**.

{% endlist %}

{{ dataproc-name }} запустит операцию создания кластера. После того, как кластер перейдет в статус **Running**, вы можете [подключиться](connect.md) к любому активному подкластеру с помощью указанного SSH-ключа.

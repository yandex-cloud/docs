# Логи в Yandex Data Processing

Сервис [Yandex Cloud Logging](../../logging/index.md) собирает и отображает логи кластера Yandex Data Processing. Они автоматически сохраняются в лог-группу, привязанную к кластеру при его [создании](../operations/cluster-create.md) или [изменении](../operations/cluster-update.md). Это может быть лог-группа, которая действует по умолчанию в каталоге, или заранее подготовленная лог-группа пользователя.

Чтобы посмотреть логи кластера Yandex Data Processing, с его страницы перейдите в лог-группу кластера. Затем в поле **Запрос** [введите фильтр](../../logging/concepts/filter.md):

* Стандартные параметры фильтрации:

   * `resource_type` — всегда принимает значение `dataproc.cluster`;
   * `resource_id` — идентификатор кластера.

* Дополнительные параметры фильтрации:

   * `hostname` — [FQDN](../../glossary/fqdn.md) хоста;
   * `log_type` — тип записи логов кластера.

В результате на странице лог-группы отобразится гистограмма логов и записи из них.

## Типы записей логов Yandex Data Processing {#types}

### Логи компонентов кластера {#components}

В зависимости от роли подкластера, для логов компонентов используются перечисленные типы записей:

* Все хосты кластера:
   * `cloud-init` — кластеры Yandex Data Processing с [версией образа](environment.md) 2.0 или выше;
   * `salt-minion` — лог сервисной инициализации кластера Yandex Data Processing;
   * `syslog` — системный лог;
   * `telegraf` — лог отправки метрик кластера Yandex Data Processing в сервис [Monitoring](../../monitoring/index.md).

* Хост-мастер:
   * `flume` — кластеры Yandex Data Processing с [версией образа](environment.md) ниже 2.0;
   * `hadoop-hdfs-namenode`;
   * `hadoop-hdfs-secondarynamenode`;
   * `hadoop-mapreduce`;
   * `hadoop-yarn-resourcemanager`;
   * `hadoop-yarn-timelineserver`;
   * `hbase-master`;
   * `hbase-rest`;
   * `hbase-thrift`;
   * `hive-metastore`;
   * `hiveserver2`;
   * `hive-webhcat-console` — кластеры Yandex Data Processing с [версией образа](environment.md) ниже 2.0;
   * `hive-webhcat-console-error` — кластеры Yandex Data Processing с [версией образа](environment.md) ниже 2.0;
   * `hive-webhcat` — кластеры Yandex Data Processing с [версией образа](environment.md) ниже 2.0;
   * `knox` — кластеры Yandex Data Processing с [версией образа](environment.md) ниже 2.0;
   * `livy-out`;
   * `livy-request`;
   * `oozie`;
   * `oozie-audit`;
   * `oozie-error`;
   * `oozie-instrumentation`;
   * `oozie-jetty`;
   * `oozie-jpa`;
   * `oozie-ops`;
   * `postgres`;
   * `sqoop` — кластеры Yandex Data Processing с [версией образа](environment.md) ниже 2.0;
   * `supervisor` — кластеры Yandex Data Processing с [версией образа](environment.md) ниже 2.0;
   * `yandex-dataproc-agent`;
   * `zeppelin`;
   * `zookeeper`.

* Хосты подкластеров для хранения данных:
   * `hadoop-hdfs-datanode`;
   * `hadoop-yarn-nodemanager`.

* Хосты подкластеров для обработки данных содержат логи `hadoop-yarn-nodemanager`.

### Логи заданий {#jobs}

В логах заданий отражаются следующие типы записей:

* Записи логов YARN-контейнеров.

  Для типа записи указывается `containers`.

  Записи дополняются тегами:
    * `yarn_log_type` — имя файла лога, который YARN сохраняет в качестве лога контейнера.

       Примеры:
         * `stdout`
         * `stderr`
         * `launch_container.sh`
         * `prelaunch.out`
         * `directory.info`
    * `container_id` — идентификатор YARN контейнера. Пример: `container_1638976919626_0002_01_000001`.
    * `application_id` — идентификатор YARN приложения. Пример: `application_1638976919626_0002`.

* Записи лога вывода запускающего процесса. Сохраняются в случае запуска задания через [API](../../glossary/rest-api.md) Yandex Data Processing, а не на хостах кластера.

  Для типа записи указывается `job_output`.

  Записи содержат тег `job_id` с идентификатором задания, созданного через API Yandex Data Processing. Если задание начало исполняться и не было завершено на этапе валидации, то записи содержат тег `application_id`.
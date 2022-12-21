# Логи в {{ dataproc-name }}

Собирает и отображает логи кластера {{ dataproc-name }} сервис [{{ cloud-logging-full-name }}](../../logging/).

Все отправляемые кластером записи логов содержат [стандартные параметры для фильтрации](../../logging/concepts/filter.md):

* `resource_type` — всегда принимает значение `dataproc.cluster`;
* `resource_id` — идентификатор кластера.

Также записи логов {{ dataproc-name }} содержат дополнительные параметры:

* `hostname` — FQDN хоста;
* `log_type` — [тип записи](#log-types) логов кластера.

## Типы записей логов {{ dataproc-name }} {#types}

### Логи компонентов кластера {#components}

В зависимости от роли подкластера, для логов компонентов используются перечисленные типы записей:

* Все хосты кластера:
   * `cloud-init` — кластеры {{ dataproc-name }} с [версией образа](../concepts/environment.md) 2.0 или выше;
   * `salt-minion` — лог сервисной инициализации кластера {{ dataproc-name }};
   * `syslog` — системный лог;
   * `telegraf` — лог отправки метрик кластера {{ dataproc-name }} в сервис [{{ monitoring-name }}](../../monitoring/);
   * `yandex-dataproc-start` — лог сервисной инициализации кластера {{ dataproc-name }}.

* Управляющий хост:
   * `flume` — кластеры {{ dataproc-name }} с [версией образа](../concepts/environment.md) ниже 2.0;
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
   * `hive-webhcat-console` — кластеры {{ dataproc-name }} с [версией образа](../concepts/environment.md) ниже 2.0;
   * `hive-webhcat-console-error` — кластеры {{ dataproc-name }} с [версией образа](../concepts/environment.md) ниже 2.0;
   * `hive-webhcat` — кластеры {{ dataproc-name }} с [версией образа](../concepts/environment.md) ниже 2.0;
   * `knox` — кластеры {{ dataproc-name }} с [версией образа](../concepts/environment.md) ниже 2.0;
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
   * `sqoop` — кластеры {{ dataproc-name }} с [версией образа](../concepts/environment.md) ниже 2.0;
   * `supervisor` — кластеры {{ dataproc-name }} с [версией образа](../concepts/environment.md) ниже 2.0;
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

* Записи лога вывода запускающего процесса. Сохраняются в случае запуска задания через [API](../../glossary/rest-api.md) {{ dataproc-name }}, а не на хостах кластера.

  Для типа записи указывается `job_output`.

  Записи содержат тег `job_id` с идентификатором задания, созданного через API {{ dataproc-name }}. Если задание начало исполняться и не было завершено на этапе валидации, то записи содержат тег `application_id`.

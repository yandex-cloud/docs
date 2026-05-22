# Общие вопросы про Yandex Data Processing

* [Какие кластеры можно перенести в другую зону доступности?](#new-availability-zone)

* [Что делать, если данные на хостах подкластера для хранения данных распределены неравномерно?](#data-unevenly-distributed)

* [Где можно посмотреть логи кластера Yandex Data Processing?](#cluster-logs)

* [Я могу получить логи моей работы в сервисах?](#logs)

* [Почему кластер работает медленно, хотя вычислительные ресурсы использованы не до предела?](#throttling)

* [При запуске скрипта инициализации я получаю ошибку `^M: bad interpreter`, как это исправить?](#syntax-error)

* [При запуске задания PySpark возникает ошибка, связанная с `com/amazonaws/auth/AWSCredentialsProvider`, как это исправить?](#sharedPrefixes-property)

* [При использовании динамической перезаписи партиций возникает ошибка, связанная с `PathOutputCommitProtocol`, как это исправить?](#dynamic-partition-overwrite)

* [Почему возникает ошибка `NAT should be enabled on the subnet`, и как ее исправить?](#nat)

* [Почему возникает ошибка `Using fileUris is forbidden on lightweight cluster`, и как ее исправить?](#file-uri)

* [Почему возникает ошибка `Create Yandex Data Processing cluster Error: 0 Address space exhausted`, и как ее исправить?](#addresses-exhausted)

* [Почему кластер в статусе `Unknown`?](#unknown)

* [Какая минимальная вычислительная мощность нужна для работы подкластера с хостом-мастером?](#master-computing-power)

* [Как обновить версию образа в Yandex Data Processing?](#upgrade)

* [Как запустить задания (jobs)?](#jobs)

* [Какие есть лимиты на группы безопасности?](#security-groups)

* [Можно ли получить на хостах права суперпользователя?](#connect-root)

* [Как исправить ошибку отсутствия прав при подключении сервисного аккаунта к кластеру?](#attach-service-account)

#### Какие кластеры можно перенести в другую зону доступности? {#new-availability-zone}

Можно перенести [легковесные кластеры](../operations/migration-to-an-availability-zone.md) и [кластеры с файловой системой HDFS](../tutorials/hdfs-cluster-migration.md).

#### Что делать, если данные на хостах подкластера для хранения данных распределены неравномерно? {#data-unevenly-distributed}

[Подключитесь](../operations/connect.md) к хосту-мастеру кластера и запустите перебалансировку с помощью команды:

```bash
sudo -u hdfs hdfs balancer
```

Вы можете изменять параметры балансировщика. Например, чтобы изменить максимальный объем данных для переноса, добавьте аргумент `-D dfs.balancer.max-size-to-move=<размер-данных-в-байтах>`.

#### Где можно посмотреть логи кластера Yandex Data Processing? {#cluster-logs}

Логи кластера доступны в его лог-группе. Чтобы следить за событиями кластера и его отдельных хостов, при [создании](../operations/cluster-create.md) или [изменении](../operations/cluster-update.md) кластера укажите в его настройках нужную [лог-группу](../../logging/concepts/log-group.md). Если для кластера не выбрана лог-группа, то для отправки и хранения логов будет использована лог-группа по умолчанию в каталоге кластера. Подробнее см. в разделе [Работа с логами](../operations/logging.md).

#### Я могу получить логи моей работы в сервисах? {#logs}

Да, вы можете запросить информацию о работе с вашими ресурсами из логов сервисов Yandex Cloud. Для этого обратитесь в [техническую поддержку](https://center.yandex.cloud/support).

#### Почему кластер работает медленно, хотя вычислительные ресурсы использованы не до предела? {#throttling}

Вероятно, максимальные значения [IOPS и пропускной способности (bandwidth)](../../compute/concepts/storage-read-write.md) хранилища недостаточны для обработки текущего количества запросов. В этом случае срабатывает [троттлинг](../../compute/concepts/storage-read-write.md#throttling) и быстродействие всего кластера падает.

Максимальные IOPS и bandwidth прирастают на фиксированную величину при увеличении размера хранилища на определенный шаг. Шаг и прирост зависят от типа дисков:

| Тип дисков                  | Шаг, ГБ | Прирост макс. IOPS (чтение/запись) | Прирост макс. bandwidth (чтение/запись), МБ/с |
|-----------------------------|---------|------------------------------------|-----------------------------------------------|
| `network-hdd`               | 256     | 300/300                            | 30/30                                         |
| `network-ssd`               | 32      | 1000/1000                          | 15/15                                         |
| `network-ssd-nonreplicated`, `network-ssd-io-m3` | 93      | 28000/5600                         | 110/82                                        |

Чтобы увеличить максимальные значения IOPS и bandwidth и снизить вероятность троттлинга, рассмотрите возможность перехода на другой кластер с увеличенным размером хранилищ на хостах или более быстрым типом дисков. Перенести данные на новый кластер можно, например, при помощи [Apache Hive™ Metastore](../../metadata-hub/concepts/metastore.md).

#### При запуске скрипта инициализации я получаю ошибку `^M: bad interpreter`, как это исправить? {#syntax-error}

Так как среда выполнения скрипта — Linux (Ubuntu), то скрипты, подготовленные в Windows, могут выполниться с ошибкой `^M: bad interpreter` из-за использования символа переноса строки `CR/LF` (в Linux – `LF`). Для исправления ошибки сохраните файл скрипта в формате Linux. Подробнее см. в разделе [Ошибки синтаксиса](../concepts/init-action.md#syntax-errors).

#### При запуске задания PySpark возникает ошибка, связанная с `com/amazonaws/auth/AWSCredentialsProvider`, как это исправить? {#sharedPrefixes-property}

Если кластер Yandex Data Processing подключен к кластеру Apache Hive™ Metastore, при запуске PySpark-заданий может возникать ошибка:

```text
previously initiated loading for a different type with name "com/amazonaws/auth/AWSCredentialsProvider";
```

Чтобы ее исправить, [добавьте свойство](../operations/cluster-update.md) `spark:spark.sql.hive.metastore.sharedPrefixes` со значением `com.amazonaws,ru.yandex.cloud` в кластер Yandex Data Processing.

#### При использовании динамической перезаписи партиций возникает ошибка, связанная с `PathOutputCommitProtocol`, как это исправить? {#dynamic-partition-overwrite}

Если при обработке данных используется динамическая перезапись партиций, может возникнуть такая ошибка:

```text
py4j.protocol.Py4JJavaError: An error occurred while calling o264.parquet.
: java.io.IOException: PathOutputCommitProtocol does not support dynamicPartitionOverwrite
```

Чтобы ее исправить, [добавьте](../operations/cluster-update.md) в кластер Yandex Data Processing свойства:

* `spark:spark.sql.sources.partitionOverwriteMode : dynamic`
* `spark:spark.sql.parquet.output.committer.class : org.apache.parquet.hadoop.ParquetOutputCommitter`
* `spark:spark.sql.sources.commitProtocolClass : org.apache.spark.sql.execution.datasources.SQLHadoopMapReduceCommitProtocol`

Добавить свойства также можно при [создании задания](../operations/jobs.md).

#### Почему возникает ошибка `NAT should be enabled on the subnet`, и как ее исправить? {#nat}

Ошибка возникает при попытке создать кластер Yandex Data Processing в подсети, для которой не настроен NAT-шлюз. Чтобы исправить ее, [настройте сеть для Yandex Data Processing](../tutorials/configure-network.md).

#### Почему возникает ошибка `Using fileUris is forbidden on lightweight cluster`, и как ее исправить? {#file-uri}

Ошибка возникает из-за того, что конфигурация [легковесных кластеров](../concepts/index.md#light-weight-clusters) не включает в себя HDFS. Чтобы исправить ошибку, [создайте кластер](../operations/cluster-create.md), который поддерживает HDFS.

Кроме того, для работы с заданиями (jobs) рекомендуется использовать [бакеты Yandex Object Storage](../../storage/concepts/bucket.md). Вы можете [загружать в них скрипты](../../storage/operations/objects/upload.md) для запуска заданий. Эти скрипты хранятся в виде объектов, на которые можно [получать ссылки](../../storage/operations/objects/link-for-download.md). В результате вместо ссылки вида `file:/` вы можете использовать ссылки из Object Storage в своих заданиях.

#### Почему возникает ошибка `Create Yandex Data Processing cluster Error: 0 Address space exhausted`, и как ее исправить? {#addresses-exhausted}

Ошибка означает, что закончились свободные IP-адреса в подсети кластера Yandex Data Processing, которые можно выделить хостам кластера. Чтобы проверить количество доступных адресов, [посмотрите список используемых адресов](../../vpc/operations/subnet-used-addresses.md) в подсети и ее маску.

Чтобы исправить ошибку, выполните одно из действий:

* Удалите лишние ресурсы, которые занимают IP-адреса в подсети.
* Создайте подсеть с CIDR, подходящим под конфигурацию вашего кластера. Затем создайте кластер Yandex Data Processing в новой подсети.

Подробнее о размерах подсетей см. в документации [Yandex Virtual Private Cloud](../../vpc/concepts/network.md#subnet).

#### Почему кластер в статусе `Unknown`? {#unknown}

Если у кластера был статус `Alive`, а затем стал `Unknown`:

1. Убедитесь, что вы [настроили сеть для Yandex Data Processing](../tutorials/configure-network.md). Для работы кластера нужно создать и настроить несколько сетевых ресурсов:

   * сеть;
   * подсеть;
   * NAT-шлюз;
   * таблицу маршрутизации;
   * группу безопасности;
   * сервисный аккаунт для кластера;
   * бакет, в котором будут храниться зависимости заданий и результаты их выполнения.

1. Изучите логи, которые описывают состояние кластера за заданный период:

   ```bash
   yc logging read \
      --group-id=<идентификатор_лог-группы> \
      --resource-ids=<идентификатор_кластера> \
      --filter=log_type=yandex-dataproc-agent \
      --since 'YYYY-MM-DDThh:mm:ssZ' \
      --until 'YYYY-MM-DDThh:mm:ssZ'
   ```

   В параметрах `--since` и `--until` укажите границы периода. Формат времени: `YYYY-MM-DDThh:mm:ssZ`. Пример: `2020-08-10T12:00:00Z`. Время указывается в часовом поясе UTC.

   Подробнее см. в разделе [Работа с логами](../operations/logging.md).

#### Какая минимальная вычислительная мощность нужна для работы подкластера с хостом-мастером? {#master-computing-power}

Это зависит от режима размещения драйвера:

* При режиме `deployMode=cluster`, когда драйвер размещается на одном из вычислительных хостов кластера (`compute`), подкластеру с хостом-мастером (`master`) достаточно 4–8 ядер CPU и 16 ГБ оперативной памяти.
* При режиме `deployMode=client`, когда драйвер размещается на хосте-мастере кластера, вычислительная мощность зависит от логики заданий и количества запущенных конкурентных заданий.

Подробнее о режимах размещения драйвера и потреблении вычислительной мощности см. в разделе [Распределение ресурсов](../concepts/spark-sql.md#resource-management).

В Yandex Cloud вычислительная мощность определяется классом хостов. Их соотношение см. в разделе [Классы хостов](../concepts/instance-types.md).

#### Как обновить версию образа в Yandex Data Processing? {#upgrade}

В сервисе нет встроенного механизма для обновления [версии образа](../concepts/environment.md). Чтобы ее обновить, создайте новый кластер.

Если вы хотите постоянно использовать актуальную версию, [автоматизируйте](../tutorials/airflow-automation.md) создание и удаление временных кластеров Yandex Data Processing с помощью сервиса Yandex Managed Service for Apache Airflow™. Для автоматизированного запуска заданий помимо Managed Service for Apache Airflow™ вы также можете [использовать](../tutorials/datasphere-integration.md) сервис Yandex DataSphere.

#### Как запустить задания (jobs)? {#jobs}

Возможно несколько способов:

* [Создайте задания в Yandex Data Processing](../operations/jobs.md). После этого они запустятся автоматически.
* [Запустите задания Apache Hive](../tutorials/how-to-use-hive.md) с помощью Yandex Cloud CLI или Hive CLI.
* [Запустите приложения Spark или PySpark](../tutorials/run-spark-job.md) с помощью Spark Shell, утилиты `spark-submit` или Yandex Cloud CLI.
* [Запустите задания с удаленных хостов](../tutorials/remote-run-job.md), не входящих в кластер Yandex Data Processing, с помощью утилиты `spark-submit`.
* Настройте интеграцию с сервисом [Yandex Managed Service for Apache Airflow™](../tutorials/airflow-automation.md) или [Yandex DataSphere](../tutorials/datasphere-integration.md). Тогда запуск заданий будет автоматизирован.

#### Какие есть лимиты на группы безопасности? {#security-groups}

В сети можно создавать не более пяти групп безопасности. В каждой группе может быть до 50 правил. Подробнее о [лимитах в Yandex Virtual Private Cloud](../../vpc/concepts/limits.md#vpc-limits).

#### Можно ли получить на хостах права суперпользователя? {#connect-root}

Да. Чтобы переключиться на суперпользователя, после подключения к хосту введите команду:

   ```bash
     sudo su
   ```

Однако переключаться на суперпользователя необязательно — достаточно использовать `sudo`.

#### Как исправить ошибку отсутствия прав при подключении сервисного аккаунта к кластеру? {#attach-service-account}

#### Как исправить ошибку отсутствия прав при подключении сервисного аккаунта к кластеру? {#attach-service-account}

Текст ошибки:

```text
ERROR: rpc error: code = PermissionDenied desc = you do not have permission to access the requested service account or service account does not exist
```

Ошибка возникает, если вы создаете или изменяете кластер и привязываете к нему сервисный аккаунт.

**Решение**
[Назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.
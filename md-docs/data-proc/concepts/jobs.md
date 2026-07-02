[Документация Yandex Cloud](../../index.md) > [Yandex Data Processing](../index.md) > [Концепции](index.md) > Задания в Yandex Data Processing

# Задания в Yandex Data Processing

В кластере Yandex Data Processing можно создавать и выполнять задания (jobs). Это позволяет, например, на регулярной основе загружать набор данных из [бакета Object Storage](../../storage/concepts/bucket.md), использовать их в расчетах и формировать [аналитику](../../glossary/data-analytics.md).

Поддерживаются задания следующих типов:

* [Hive](https://cwiki.apache.org/confluence/display/HIVE#Home-HiveDocumentation),
* [MapReduce](https://hadoop.apache.org/docs/stable/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html),
* [PySpark](https://spark.apache.org/docs/latest/api/python/index.html),
* [Spark](https://spark.apache.org/docs/latest/).

При создании задания указываются:

* _Аргументы_ — значения, используемые основным исполняемым файлом задания.
* _Свойства_ — пары <q>ключ:значение</q>, задающие настройки [компонентов образа](environment.md).

Для размещения и [запуска задания](../operations/running-jobs.md):
* Воспользуйтесь интерфейсами Yandex Cloud. Подробнее в [базовых примерах](../tutorials/job-overview.md#jobs-basic-tutorials) работы с заданиями.



* Подключитесь напрямую к узлу кластера. Смотрите пример в разделе [Запуск заданий с удаленных хостов, не входящих в кластер](../tutorials/remote-run-job.md).


Для успешного выполнения задания:

* Предоставьте доступ к нужным бакетам Object Storage для сервисного аккаунта кластера.

    Рекомендуется использовать минимум два бакета:
    * Бакет с правами только на чтение для хранения исходных данных и файлов, необходимых для запуска задания.
    * Бакет с правами на чтение и запись для хранения результатов выполнения заданий. Укажите его при создании кластера.

* Передайте при создании задания все необходимые для его работы файлы.

Если в кластере достаточно вычислительных ресурсов, несколько созданных заданий будут выполняться параллельно. В противном случае из заданий будет сформирована очередь.

## Логи заданий {#logs}

Логи заданий сохраняются в сервисе Yandex Cloud Logging. Подробнее в разделе [Работа с логами](../operations/logging.md).
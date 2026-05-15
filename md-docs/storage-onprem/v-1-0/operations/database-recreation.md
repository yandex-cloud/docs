# Пересоздание базы данных

Если реплики кластера находятся не в статусе `Standby (sync)`, в простейшем случае это можно исправить удалением и повторным созданием сломанной реплики.

{% note alert %}

Рекомендуется проводить пересоздание БД, только если есть хотя бы одна реплика в статусе `Standby (sync)`. Удаление PVC может привести к потере данных.

{% endnote %}

Чтобы пересоздать базу данных:

1. Определите текущее расположение мастеров всех баз `s3-db0x`:
   
   ```bash
   for i in {1..4} ; do kubectl cnpg -n cnpg-system status s3-db0$i | grep '^s3.*Primary' ; done
   ```
   
   Результат:
   
   ```text
   s3-db01-1  22/591A2F50  Primary  OK  Burstable  1.24.1  s3-0-1
   s3-db02-4  22/8A009D00  Primary  OK  Burstable  1.24.1  s3-0-4
   s3-db03-2  22/43003580  Primary  OK  Burstable  1.24.1  s3-0-1
   s3-db04-2  22/65088C8C  Primary  OK  Burstable  1.24.1  s3-0-2
   ```
1. Проверьте текущий статус кластера:

    ```bash
    kubectl cnpg -n cnpg-system status <имя_мастера>
    ```

    Результат:

    ```text
    Name         Current LSN    Replication role   Status    QoS             Manager Version    Node
    ----         -----------    ---------------    ------    ---             ---------------    ----
    s3-db04-2    22/675A7408    Primary            OK        Burstable       1.24.1             s3-0-2
    s3-db04-5    22/675A7408    Standby (sync)     OK        Burstable       1.24.1             s3-0-1
    s3-db04-1    -              -                  -         InternalError   Burstable          s3-0-3
    ```

1. Посмотрите лог сломанной реплики:

    ```bash
    kubectl -n cnpg-system logs <имя_реплики>
    ```

    Если в логе есть ошибка вида:

    ```text
    could not receive data from WAL stream: ERROR:  requested WAL segment 00000021000000220000000E has already been removed
    ```

    То с большой вероятностью проблема исправится удалением этой реплики.

1. Удалите PVC реплики, что приведет к удалению реплики и ее пересозданию:

    ```bash
    kubectl -n cnpg-system delete pvc <имя_реплики>
    ```

    Результат:

    ```text
    ...
    Status:    Creating a new replica Creating replica s3-db04-6-join
    Instances: 3
    Ready instances: 2
    ...
    ```

1. Наблюдайте за процессом пересоздания:

    ```bash
    kubectl cnpg -n cnpg-system status <имя_мастера>
    ```

    Результат:

    ```text
    Instances status
    Name         Current LSN    Replication role   Status    QoS        Manager Version   Node
    ----         -----------    ---------------    ------    ---        ---------------   ----
    s3-db04-2    22/6A01CF30    Primary            OK        Burstable  1.24.1            s3-0-2
    s3-db04-5    22/6A01CF30    Standby (sync)     OK        Burstable  1.24.1            s3-0-1
    s3-db04-6    22/6A01CF30    Standby (sync)     OK        Burstable  1.24.1            s3-0-3
    ```

    Пересоздание занимает несколько минут в зависимости от нагрузки и размера базы.
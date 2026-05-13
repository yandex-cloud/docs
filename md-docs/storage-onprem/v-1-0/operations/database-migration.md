# Перенос базы данных

В On-premises Yandex Object Storage четыре кластера PostgreSQL. В каждом кластере по три инстанса — один мастер и два слейва.

{% note alert %}

Ручное вмешательство в работу Cloud-Native PG (cnpg) может привести к полной потере данных.

{% endnote %}

В нормальном состоянии реплики должны быть в статусе `Standby (sync)`.

{% note warning %}

Если статус реплики отличается от `Standby (sync)` в течение длительного времени (более десяти минут), вероятно, cnpg не способен самостоятельно устранить проблему. В этом случае обратитесь в [техническую поддержку](../quickstart.md#support).

{% endnote %}

Чтобы перенести мастер базы данных кластера на другой хост:

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
1. Посмотрите расположение всех инстансов кластера и статус реплик:

    ```bash
    kubectl cnpg -n cnpg-system status <имя_мастера>
    ```

    Результат:

    ```text
    Instances status
    Name         Current LSN    Replication role   Status    QoS        Manager Version   Node
    ----         -----------    ---------------    ------    ---        ---------------   ----
    s3-db01-1    22/591BC578    Primary            OK        Burstable  1.24.1            s3-0-1
    s3-db01-2    22/591BC578    Standby (sync)     OK        Burstable  1.24.1            s3-0-4
    s3-db01-3    22/591BC578    Standby (sync)     OK        Burstable  1.24.1            s3-0-3
    ```

1. Убедитесь, что статус всех реплик — `Standby (sync)`. Если это не так, сначала выясните причину и устраните проблему.
1. Переключите мастер на нужную реплику:

    ```bash
    kubectl cnpg -n cnpg-system promote <имя_мастера> <имя_реплики>
    ```

    Результат:

    ```text
    {"level":"info","ts":"2025-10-30T12:46:12.798791678Z","msg":"Cluster has become unhealthy"}
    Node s3-db01-3 in cluster s3-db01 will be promoted
    ```
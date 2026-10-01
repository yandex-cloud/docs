# Перенос базы данных

В {{ objstorage-onprem-name }} четыре кластера {{ PG }}. В каждом кластере по три инстанса — один мастер и два слейва.

{% note alert %}

Ручное вмешательство в работу Cloud-Native PG (cnpg) может привести к полной потере данных.

{% endnote %}

В нормальном состоянии реплики должны быть в статусе `Standby (sync)`.

{% note warning %}

Если статус реплики отличается от `Standby (sync)` в течение длительного времени (более десяти минут), вероятно, cnpg не способен самостоятельно устранить проблему. В этом случае обратитесь в [техническую поддержку](../quickstart.md#support).

{% endnote %}

Чтобы перенести мастер базы данных кластера на другой хост:

1. {% include [current-location-masters](../_includes/current-location-masters.md) %}
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
[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Базы данных > Managed Service for ClickHouse® > Восстановить кластер

# Восстановить кластер

Если вы утратили кластер [ClickHouse®](../../concepts/components/clickhouse.md) в [проекте](../projects/create-project.md)), вы можете восстановить его.

## Через CLI

Поддерживаются два варианта восстановления в `spec.clickhouse.recovery`:

- **fullRecovery** — восстановление всего кластера из одной полной резервной копии. Укажите в `spec.clickhouse.recovery.fullRecovery.backup.name` имя ресурса `ClickhouseBackup`. Подходит, когда есть одна полная копия кластера.
- **shardsRecovery** — восстановление по шардам из разных копий. В `spec.clickhouse.recovery.shardsRecovery.backups[]` задайте для каждого шарда элемент с полями:
  - `backup.name` — имя ресурса `ClickhouseBackup` для этого шарда;
  - `shard` — идентификатор шарда (например, `shard-1`, `shard-2`), должен совпадать с `shards[].id` в спецификации кластера.

Список резервных копий: `kubectl get ClickhouseBackup -n <название проекта>`.

1. Создайте файл ресурса `ClickhouseCluster`. Например: `touch clickhousecluster-from-backup.yaml`.
1. Откройте файл и вставьте конфигурацию для восстановления:

    {% list tabs %}

    - Из одной полной копии (fullRecovery)

        Подставьте в `spec.clickhouse.recovery.fullRecovery.backup.name` имя резервной копии, из которой восстанавливается весь кластер.

        ```yaml
        apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
        kind: ClickhouseCluster
        metadata:
          labels:
            app.kubernetes.io/name: ch-stackland-operator
            app.kubernetes.io/managed-by: kustomize
          name: ch-sample-full
        spec:
          clickhouse:
            version: "25.3"
            enableSuperuserAccess: true
            superuserSecretRef:
              name: "ch-sample-superuser"
            recovery:
              fullRecovery:
                backup:
                  name: your_backup_full_name  # kubectl get ClickhouseBackup -n <namespace>
          backup:
            storage:
              type: stackland-storage
            schedule: "0 0 * * * *"
            deltaMaxSteps: 5
        ---
        apiVersion: v1
        kind: Secret
        metadata:
          name: ch-sample-superuser
        type: Opaque
        stringData:
          password: "your_password"
          username: "your_username"
        ```

    - По шардам (shardsRecovery)

        Для каждого шарда укажите в `spec.clickhouse.recovery.shardsRecovery.backups[]` элемент с `backup.name` (имя копии для шарда) и `shard` (id шарда). Количество элементов должно соответствовать числу шардов в кластере.

        ```yaml
        apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
        kind: ClickhouseCluster
        metadata:
          labels:
            app.kubernetes.io/name: ch-stackland-operator
            app.kubernetes.io/managed-by: kustomize
          name: ch-sample-full
        spec:
          clickhouse:
            version: "25.3"
            shards:
              - id: "shard-1"
                weight: 1
                settings:
                instances: 2
                storage:
        #          storageClass: "your-storage-class"
                  size: 2Gi
              - id: "shard-2"
                weight: 2
                settings:
                instances: 1
                storage:
        #          storageClass: "your-storage-class"
                  size: 2Gi
            storage:
        #      storageClass: "your-storage-class"
              size: 2Gi
            resources:
              requests:
                cpu: "500m"
                memory: "1Gi"
              limits:
                cpu: "1"
                memory: "2Gi"
            enableSuperuserAccess: true
            superuserSecretRef:
              name: "ch-sample-superuser"
            recovery:
              shardsRecovery:
                backups:
                  - backup:
                      name: your_backup_shard_1_name
                    shard: "shard-1"
                  - backup:
                      name: your_backup_shard_2_name
                    shard: "shard-2"
          keeper:
            instances: 3
            storage:
        #      storageClass: "your-storage-class"
              size: 1Gi
            resources:
              requests:
                cpu: "500m"
                memory: "1Gi"
              limits:
                cpu: "1"
                memory: "2Gi"
          backup:
            storage:
              type: stackland-storage
            schedule: "0 0 * * * *"
        ---
        apiVersion: v1
        kind: Secret
        metadata:
          name: ch-sample-superuser
        type: Opaque
        stringData:
          password: "your_password"
          username: "your_username"
        ```

    {% endlist %}

1. Примените манифест: `kubectl apply -f clickhousecluster-from-backup.yaml -n <название проекта>`. При необходимости можно прописать название проекта в параметр ресурса `metadata.namespace` и не использовать в команде.

## Через консоль управления

1. Если вы еще не открыли проект, выберите проект.
1. В левом меню выберите **ClickHouse® Clusters**.
1. Перейдите на вкладку **Резервные копии**.
1. В строке нужной копии откройте меню и нажмите **Восстановить**.
1. Проверьте настройки кластера и измените их при необходимости.
1. Нажмите **Восстановить**.

Готово, кластер восстановлен и виден в списке кластеров проекта.
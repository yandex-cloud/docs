# Восстановить кластер

Если вы утратили кластер [{{ CH }}](../../concepts/components/clickhouse.md) в [проекте](../projects/create-project.md), вы можете восстановить его.

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

        {% include notitle [YAML-файл](../../_includes/yamls/operations/clickhouse/cluster_from_backup_full.md) %}

    - По шардам (shardsRecovery)

        Для каждого шарда укажите в `spec.clickhouse.recovery.shardsRecovery.backups[]` элемент с `backup.name` (имя копии для шарда) и `shard` (id шарда). Количество элементов должно соответствовать числу шардов в кластере.

        {% include notitle [YAML-файл](../../_includes/yamls/operations/clickhouse/cluster_from_backup.md) %}

    {% endlist %}

1. Примените манифест: `kubectl apply -f clickhousecluster-from-backup.yaml -n <название проекта>`. При необходимости можно прописать название проекта в параметр ресурса `metadata.namespace` и не использовать в команде.

## Через консоль управления

1. Если вы еще не открыли проект, выберите проект.
1. В левом меню выберите **{{ CH }} Clusters**.
1. Перейдите на вкладку **Резервные копии**.
1. В строке нужной копии откройте меню и нажмите **Восстановить**.
1. Проверьте настройки кластера и измените их при необходимости.
1. Нажмите **Восстановить**.

Готово, кластер восстановлен и виден в списке кластеров проекта.

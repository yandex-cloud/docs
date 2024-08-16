# Устранение ошибки `The transfer is located in zone ru-central1-c and will be removed`


## Описание проблемы {#issue-description}

При запуске трансфера, находящегося в зоне `ru-central1-c`, возникает ошибка:
```
TYPE_ERROR [target]: failed to execute pg activate hook: Snapshot loading failed: 
unable to upload tables: upload of 85 tables failed: 
failed to deliver items to destination while loading table '"public"."%table_name%" [1/1]': 
failed to push items from 0 to 1 in batch: 
failed to push (with retries): 
Push failed: failed to push 1 rows to ClickHouse shard 0: 
ClickHouse Push failed after 20 attempts;
last error: failed to check existing of table %table_name%: 
dial tcp 000.000.000.000:9440: i/o timeout TYPE_WARNING: 
The transfer is located in zone ru-central1-c, which is deprecated and will be removed soon. 
Please follow the migration instructions
at https://yandex.cloud/ru/docs/data-transfer/operations/endpoint/migration-to-an-availability-zone
to ensure that the transfer works after the removal of the zone.
```

## Решение {#issue-resolution}

 

Хост кластера эндпоинта сейчас размещается в зоне доступности `ru-central1-c`, которая [выводится из эксплуатации](../../../overview/concepts/ru-central1-c-deprecation.md). Текст ошибки [сообщает](../../../data-transfer/operations/endpoint/migration-to-an-availability-zone.md), что необходимо [перенести эндпоинт в другую зону доступности](../../../managed-postgresql/operations/host-migration.md).

{% note info %}

Может потребоваться [перезапуск трансфера](../../../managed-postgresql/operations/host-migration.md#data-transfer).

{% endnote %}



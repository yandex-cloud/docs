### Превышение количества блоков данных {#partition-blocks}

При переносе данных в приемник {{ CH }} трансфер прерывается с ошибкой. Текст ошибки:

```text
ERROR Unable to Activate ... 
unable to upload tables: unable to upload data objects: unable upload part <имя таблицы> (): 
unable to start \*clickhouse.HTTPSource event source: failed to push events to destination: 
unable to push http batch: <имя таблицы>: failed: INSERT INTO ...
```

Дополнительно может выводиться ошибка:

```text
pod instance restarted
```

Ошибки возникают при попытке вставить в базу-приемник {{ CH }} больше блоков данных, чем позволяет настройка `max_partitions_per_insert_block`.

**Решение:** увеличьте параметр `max_partitions_per_insert_block` для учетной записи, под которой трансфер подключается к приемнику. Для приемника {{ mch-name }} параметр можно изменить в [настройках пользователя](../../../../managed-clickhouse/concepts/settings-list.md#setting-partitions-per-insert-block). Для пользовательской инсталляции {{ CH }} можно создать профиль настроек и назначить его учетной записи:

```sql
CREATE SETTINGS PROFILE max_partitions
SETTINGS max_partitions_per_insert_block = <значение_настройки>

ALTER USER <имя_пользователя> PROFILE 'max_partitions'
```

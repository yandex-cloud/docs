### Ошибка обращения к бинарному логу {#binlog-bytes}

В трансферах типа _{{ dt-type-copy-repl}}_ может возникнуть ошибка:

```text
Warn(replication): failed to run (abstract1 source):
failed to run canal: failed to start binlog sync:
failed to get canal event: ERROR 1236 (HY000): Could not find first log file name in binary log index file
```

Ошибка возникает, если необходимые для репликации файлы бинарного лога недоступны. Обычно это связано с добавлением в бинарный лог новых изменений, из-за чего размер файла превышает допустимый. В этом случае часть старых данных лога удаляется.

**Решение:**

[Увеличьте](../../../../managed-mysql/operations/update.md#change-mysql-config) допустимый размер файлов бинарного лога в настройках {{ MY }} с помощью параметра [Mdb preserve binlog bytes](../../../../managed-mysql/concepts/settings-list.md#setting-mdb-preserve-binlog-bytes).

Минимальное значение — `1073741824` (1 ГБайт), максимальное значение — `107374182400` (100 ГБайт), по умолчанию — `1073741824` (1 ГБайт).

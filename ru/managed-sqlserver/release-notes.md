# История изменений в {{ mms-full-name }}

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## 01.05.2022 {#01.05.2022}

* Доработан механизм создания резервных копий: резервное копирование базы больше не влияет на резервное копирование логов WAL-G.
* Добавлена возможность ручной смены мастера в CLI с помощью команды `{{ yc-mdb-ms }} cluster start-failover`. {{ tag-cli }}
* Добавлена возможность [экспорта](operations/cluster-backups.md#objstorage-export) и [импорта](operations/cluster-backups.md#objstorage-import) резервной копии базы данных в {{ objstorage-full-name }}. {{ tag-cli }} {{ tag-con }}
* Добавлена возможность изменять настройку публичного доступа для хоста в консоли управления. {{ tag-con }}

## 01.04.2022 {#01.04.2022}

* Добавлена процедура-обертка [msdb.dbo.mdb_readerrorlog](https://www.sqlshack.com/read-sql-server-error-logs-using-the-xp_readerrorlog-command/) для чтения лога ошибок. Вызов процедуры доступен пользователям с ролью `db_owner` хотя бы в одной базе данных. {{ tag-sql }}

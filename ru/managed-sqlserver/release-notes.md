# История изменений в {{ mms-full-name }}

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## 01.04.2022 {#01.04.2022}

* Добавлена процедура-обертка [msdb.dbo.mdb_readerrorlog](https://www.sqlshack.com/read-sql-server-error-logs-using-the-xp_readerrorlog-command/) для чтения лога ошибок. Вызов процедуры доступен пользователям с ролью `db_owner` хотя бы в одной базе данных. {{ tag-sql }}

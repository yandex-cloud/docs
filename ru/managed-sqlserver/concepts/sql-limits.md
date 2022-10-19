# Ограничения для команд SQL

В сервисе {{ mms-short-name }} существуют ограничения на действия владельца БД с помощью команд SQL:

* Нельзя менять настройки {{ MS }}, в том числе управлять объектами уровня сервера:
  * `Linked Server`
  * `Login`
  * `Credential`
  * `SQL Server Agent Job`
  * `Maintenance Plan`
  * `Audit`
  * `Polybase`
  * `Replication`
  * `Backup devices`
  * `Server Triggers`
  * `Extended events`

* Нельзя управлять пользователями и назначать им роли. Однако можно [назначать пользователям привилегии](./../operations/grant.md).
* Нельзя создавать базы данных. Однако владельцу БД можно выполнять команду `ALTER DATABASE` для ранее созданной БД, кроме изменения [модели восстановления]({{ ms.docs }}/sql/relational-databases/backup-restore/recovery-models-sql-server).
* Недоступны никакие действия по администрированию сервера.

Выполнение этих действий с помощью инструментов {{ yandex-cloud }} описано в [пошаговых инструкциях](../operations/index.md).

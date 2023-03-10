# Пошаговые инструкции для {{ mch-name }}

- [Информация об имеющихся кластерах](cluster-list.md)
{% if audience == "internal" %}
- [Управление квотами и ресурсами](quotas-control.md)
{% endif %}
- [Создание кластера](cluster-create.md)
- [Подключение к базе данных](connect.md)
{% if audience != "internal" %}
- [Остановка и запуск кластера](cluster-stop.md)
{% endif %}
{% if product == "yandex-cloud" %}
- [SQL-запросы в консоли управления](web-sql-query.md)
{% endif %}
- [Изменение настроек кластера и базы данных](update.md)
- [Настройка доступа к {{ objstorage-name }}](s3-access.md)
- [Подключение внешних словарей](dictionaries.md)
- [Подключение собственной геобазы](geobase.md)
- [Управление моделями машинного обучения](ml-models.md)
- [Управление схемами формата данных](format-schemas.md)
- [Подключение к {{ datalens-name }}](datalens-connect.md)
- [Изменение версии {{ CH }}](cluster-version-update.md)
- [Управление хостами {{ ZK }}](zk-hosts.md)
- [Управление хостами {{ CH }}](hosts.md)
- [Управление базами данных](databases.md)
- [Управление пользователями БД](cluster-users.md)
- [Управление резервными копиями](cluster-backups.md)
- [Управление шардами](shards.md)
- [Управление группами шардов](shard-groups.md)
- [Просмотр логов кластера](cluster-logs.md)
- [Удаление кластера](cluster-delete.md)
- [Мониторинг состояния кластера и хостов](monitoring.md)

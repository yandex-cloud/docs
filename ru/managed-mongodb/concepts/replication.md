# Репликация MongoDB

Кластеры Managed Service for MongoDB поддерживает репликацию по умолчанию: если в кластере есть больше 1 активного хоста, среди них автоматически выбирается первичный сервер, обрабатывающий запросы на запись.

{% include [non-replicating-hosts](../../_includes/mdb/non-replicating-hosts.md) %}

Подробнее о том, как организована репликация в MongoDB, читайте в [документации СУБД](https://docs.mongodb.com/manual/replication/).
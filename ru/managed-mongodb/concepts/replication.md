# Репликация [!KEYREF MG]

Кластеры [!KEYREF mmg-name] поддерживает репликацию по умолчанию: если в кластере есть больше 1 активного хоста, среди них автоматически выбирается первичный сервер, обрабатывающий запросы на запись.

[!INCLUDE [non-replicating-hosts](../../_includes/mdb/non-replicating-hosts.md)]

Подробнее о том, как организована репликация в [!KEYREF MG], читайте в [документации СУБД](https://docs.mongodb.com/manual/replication/).
[Документация Yandex Cloud](../../../index.md) > [Все решения](../../index.md) > [Managed Service for PostgreSQL](../index.md) > Устранение ошибки `psql error could not translate host name to address nodename nor servname provided, or not known`

# Устранение ошибки `psql: error: could not translate host name to address: nodename nor servname provided, or not known`


## Описание проблемы {#issue-description}

Нет публичного доступа к кластеру PostgreSQL и возникает ошибка вида:
```
psql: error: could not translate host name to address: nodename nor servname provided, or not known
```

## Решение {#issue-resolution}

Для устранения ошибки уточните, разрешен ли публичный доступ к хостам кластера PostgreSQL. Хост в кластере может быть доступен извне Yandex Cloud, если [публичный доступ был разрешен при создании хоста или изменении его настроек](../../../managed-postgresql/concepts/network.md#public-access-to-a-host). В противном случае его нужно [разрешить](../../../managed-postgresql/operations/hosts.md#update).

Инструкции по подключению к базе данных в кластере PostgreSQL представлены в [документации сервиса Managed Service for PostgreSQL](../../../managed-postgresql/operations/connect/index.md).
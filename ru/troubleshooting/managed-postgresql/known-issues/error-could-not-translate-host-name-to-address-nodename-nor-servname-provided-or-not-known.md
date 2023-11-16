# Устранение ошибки psql: error: could not translate host name to address: nodename nor servname provided, or not known


## Описание проблемы {#issue-description}

Нет публичного доступа к кластеру PostgreSQL, возникает ошибка вида:
```
psql: error: could not translate host name to address: nodename nor servname provided, or not known
```

## Решение {#issue-resolution}

Необходимо уточнить, включён ли публичный доступ к хостам кластера PostgreSQL. Хост в кластере может быть доступен извне Yandex Cloud, если [публичный доступ был включён при создании хоста или изменении его настроек](../../../managed-postgresql/concepts/network.md#public-access-to-a-host).

Если публичный доступ не включён, то его необходимо [разрешить](../../../managed-postgresql/operations/hosts.md#update).

Инструкции по подключению к базе данных в кластере PostgreSQL представлены в [документации](../../../managed-postgresql/operations/connect.md).
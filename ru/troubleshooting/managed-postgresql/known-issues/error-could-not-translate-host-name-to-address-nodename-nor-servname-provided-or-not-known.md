# Устранение ошибки `psql: error: could not translate host name to address: nodename nor servname provided, or not known`


## Описание проблемы {#issue-description}

Нет публичного доступа к кластеру {{ PG }} и возникает ошибка вида:
```
psql: error: could not translate host name to address: nodename nor servname provided, or not known
```

## Решение {#issue-resolution}

Для устранения ошибки уточните, разрешен ли публичный доступ к хостам кластера {{ PG }}. Хост в кластере может быть доступен извне {{ yandex-cloud }}, если [публичный доступ был разрешен при создании хоста или изменении его настроек](../../../managed-postgresql/concepts/network.md#public-access-to-a-host). В противном случае его нужно [разрешить](../../../managed-postgresql/operations/hosts.md#update).

Инструкции по подключению к базе данных в кластере {{ PG }} представлены в [документации сервиса {{ mpg-name }}](../../../managed-postgresql/operations/connect.md).
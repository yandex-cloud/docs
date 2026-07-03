# Удалить базу данных PostgreSQL

Если у вас есть база данных PostgreSQL в [кластере](../../concepts/components/postgresql.md), вы можете удалить ее.

{% note warning %}

После удаления база данных и все ее данные удаляются из кластера. Действие необратимо.

{% endnote %}

## Через CLI {#cli}

1. Найдите название нужного ресурса в списке баз данных проекта: `kubectl get PostgresqlDatabase -n <название_проекта>`.
1. Удалите ресурс: `kubectl delete PostgresqlDatabase <название_ресурса> -n <название_проекта>`.

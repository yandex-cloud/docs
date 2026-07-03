# Изменить базу данных PostgreSQL

Если у вас есть база данных PostgreSQL в [кластере](../../concepts/components/postgresql.md), вы можете изменить ее настройки.

## Через CLI {#cli}

1. Откройте ресурс `PostgresqlDatabase`. Например, с помощью команды `kubectl edit PostgresqlDatabase <название_ресурса> -n <название_проекта>`.
1. Отредактируйте параметры:

    * `spec.owner` — роль-владелец базы данных.
    * `spec.allowConnections` — разрешение на подключения к базе данных.
    * `spec.connectionLimit` — лимит одновременных подключений. Значение `-1` — без лимита.
    * `spec.isTemplate` — использовать базу данных как шаблон при создании других БД.
    * `spec.tablespace` — tablespace по умолчанию.
    * `spec.schemas` — список управляемых схем. Чтобы удалить схему, установите значение `state: absent` или удалите элемент из списка.

1. Примените манифест: `kubectl apply -f postgresqldatabase.yaml -n <название_проекта>`.

После создания нельзя изменить поля `name`, `template`, `encoding`, `localeProvider`, `locale`, `localeCollate`, `localeCType`, `icuLocale`, `icuRules`, `builtinLocale`, `collationVersion`.

# Создать базу данных PostgreSQL

Если у вас есть кластер [PostgreSQL](../../concepts/components/postgresql.md) в [проекте](../projects/create-project.md), вы можете создать в нем базу данных. База данных описывается ресурсом `PostgresqlDatabase`. Владелец базы данных задается через поле `spec.owner` и должен соответствовать существующей роли PostgreSQL — см. [{#T}](create-user.md).

## Через CLI {#cli}

1. Создайте файл ресурса `PostgresqlDatabase`. Например, с помощью команды `touch postgresqldatabase.yaml`.
1. Откройте файл и вставьте конфигурацию ниже:

    {% list tabs %}

    - Минимальная конфигурация

        {% include notitle [YAML-файл](../../_includes/yamls/operations/postgresql/create-database-min.md) %}

        В манифесте заданы только обязательные поля: имя кластера, имя базы данных и роль-владелец.

    - Локаль libc

        Конфигурация с провайдером локали `libc` и параметрами `locale`, `localeCollate`, `localeCType`.

        {% include notitle [YAML-файл](../../_includes/yamls/operations/postgresql/create-database-libc.md) %}

    - Локаль ICU

        Конфигурация с провайдером локали `icu` и параметрами `icuLocale`, `icuRules`. Доступна с PostgreSQL 15.

        {% include notitle [YAML-файл](../../_includes/yamls/operations/postgresql/create-database-icu.md) %}

    - Локаль builtin

        Конфигурация с провайдером локали `builtin` и параметром `builtinLocale`. Доступна с PostgreSQL 17.

        {% include notitle [YAML-файл](../../_includes/yamls/operations/postgresql/create-database-builtin.md) %}

    - Схемы

        Конфигурация с управляемыми схемами PostgreSQL.

        {% include notitle [YAML-файл](../../_includes/yamls/operations/postgresql/create-database-schemas.md) %}

        В блоке `spec.schemas` опишите схемы базы данных: имя, владелец (необязательно) и состояние (`present` — создать, `absent` — удалить).

    {% endlist %}

1. Примените манифест: `kubectl apply -f postgresqldatabase.yaml -n <название_проекта>`. При необходимости можно прописать название проекта в параметр ресурса `metadata.namespace` и не использовать в команде.

После создания нельзя изменить поля `name`, `template`, `encoding`, `localeProvider`, `locale`, `localeCollate`, `localeCType`, `icuLocale`, `icuRules`, `builtinLocale`, `collationVersion`.

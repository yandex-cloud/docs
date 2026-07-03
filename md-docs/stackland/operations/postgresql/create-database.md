[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Базы данных > Managed Service for PostgreSQL > Создать базу данных

# Создать базу данных PostgreSQL

Если у вас есть кластер [PostgreSQL](../../concepts/components/postgresql.md) в [проекте](../projects/create-project.md), вы можете создать в нем базу данных. База данных описывается ресурсом `PostgresqlDatabase`. Владелец базы данных задается через поле `spec.owner` и должен соответствовать существующей роли PostgreSQL — см. [Создать пользователя PostgreSQL](create-user.md).

## Через CLI {#cli}

1. Создайте файл ресурса `PostgresqlDatabase`. Например, с помощью команды `touch postgresqldatabase.yaml`.
1. Откройте файл и вставьте конфигурацию ниже:

    {% list tabs %}

    - Минимальная конфигурация

        ```yaml
        apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
        kind: PostgresqlDatabase
        metadata:
          name: test-cluster-test-database
        spec:
          cluster: test-cluster # имя ресурса PostgresqlCluster
          name: test-database # имя базы данных в PostgreSQL
          owner: test-user # роль-владелец базы данных
        ```

        В манифесте заданы только обязательные поля: имя кластера, имя базы данных и роль-владелец.

    - Локаль libc

        Конфигурация с провайдером локали `libc` и параметрами `locale`, `localeCollate`, `localeCType`.

        ```yaml
        apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
        kind: PostgresqlDatabase
        metadata:
          name: test-cluster-test-database
        spec:
          cluster: test-cluster
          name: test-database
          owner: test-user
          template: template1 # шаблон, на основе которого создается база данных
          encoding: UTF8 # кодировка символов
          localeProvider: libc # провайдер локали
          locale: en_US.UTF-8 # локаль по умолчанию
          localeCollate: en_US.UTF-8 # правило сортировки строк
          localeCType: en_US.UTF-8 # правило классификации символов
        ```

    - Локаль ICU

        Конфигурация с провайдером локали `icu` и параметрами `icuLocale`, `icuRules`. Доступна с PostgreSQL 15.

        ```yaml
        apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
        kind: PostgresqlDatabase
        metadata:
          name: test-cluster-test-database
        spec:
          cluster: test-cluster
          name: test-database
          owner: test-user
          template: template1
          encoding: UTF8
          localeProvider: icu # провайдер локали
          icuLocale: en-US # имя ICU-локали
          icuRules: "" # дополнительные правила ICU collation
        ```

    - Локаль builtin

        Конфигурация с провайдером локали `builtin` и параметром `builtinLocale`. Доступна с PostgreSQL 17.

        ```yaml
        apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
        kind: PostgresqlDatabase
        metadata:
          name: test-cluster-test-database
        spec:
          cluster: test-cluster
          name: test-database
          owner: test-user
          template: template1
          encoding: UTF8
          localeProvider: builtin # провайдер локали; доступен с PostgreSQL 17
          builtinLocale: C.UTF-8 # имя встроенной локали
        ```

    - Схемы

        Конфигурация с управляемыми схемами PostgreSQL.

        ```yaml
        apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
        kind: PostgresqlDatabase
        metadata:
          name: test-cluster-test-database
        spec:
          cluster: test-cluster
          name: test-database
          owner: test-user
          allowConnections: true # разрешить подключения к базе данных
          connectionLimit: -1 # лимит подключений, -1 — без лимита
          isTemplate: false # использовать базу данных как шаблон
          tablespace: pg_default # tablespace по умолчанию
          schemas: # управляемые схемы
            - name: test-schema
              owner: test-user
              state: present # present — создать или поддерживать, absent — удалить
        ```

        В блоке `spec.schemas` опишите схемы базы данных: имя, владелец (необязательно) и состояние (`present` — создать, `absent` — удалить).

    {% endlist %}

1. Примените манифест: `kubectl apply -f postgresqldatabase.yaml -n <название_проекта>`. При необходимости можно прописать название проекта в параметр ресурса `metadata.namespace` и не использовать в команде.

После создания нельзя изменить поля `name`, `template`, `encoding`, `localeProvider`, `locale`, `localeCollate`, `localeCType`, `icuLocale`, `icuRules`, `builtinLocale`, `collationVersion`.
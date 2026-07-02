[Документация Yandex Cloud](../../index.md) > [Yandex MetaData Hub](../index.md) > Apache Hive™ Metastore > Концепции > Имперсонация в Apache Hive™ Metastore

# Имперсонация в Apache Hive™ Metastore

_Имперсонация_ позволяет [кластеру Apache Hive™ Metastore](metastore.md) взаимодействовать с ресурсами в облаке от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

По умолчанию кластер Apache Hive™ Metastore не имеет доступа к пользовательским ресурсам. Чтобы обеспечить доступ к таким ресурсам, [создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с нужными ролями и привяжите его к кластеру Apache Hive™ Metastore при [создании кластера](../operations/metastore/cluster-create.md#create-cluster). После этого Apache Hive™ Metastore сможет взаимодействовать с пользовательскими ресурсами, так как авторизация происходит от имени сервисного аккаунта.

Набор ролей для сервисного аккаунта зависит от того, с каким сервисом вы планируете использовать Apache Hive™ Metastore. Например, чтобы настроить экспорт логов кластера в [Yandex Cloud Logging](../../logging/index.md), нужна роль `logging.writer`, а чтобы использовать дашборды [Yandex Monitoring](../../monitoring/index.md) — `monitoring.editor`.

При создании сервисного аккаунта для Apache Hive™ Metastore рекомендуется использовать роль `managed-metastore.integrationProvider`, так как она уже включает в себя роли `logging.writer` и `monitoring.editor`. Подробнее о возможностях роли — в [справочнике](../security/metastore-roles.md#managed-metastore-integrationProvider).

_Apache® и [Apache Hive™](https://hive.apache.org/) являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._
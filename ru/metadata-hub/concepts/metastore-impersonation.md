---
title: Имперсонация в {{ metastore-name }}
description: Имперсонация позволяет кластеру {{ metastore-name }} взаимодействовать с ресурсами в облаке от имени сервисного аккаунта.
---

# Имперсонация в {{ metastore-name }}

_Имперсонация_ позволяет [кластеру {{ metastore-name }}](metastore.md) взаимодействовать с ресурсами в облаке от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

По умолчанию кластер {{ metastore-name }} не имеет доступа к пользовательским ресурсам. Чтобы обеспечить доступ к таким ресурсам, [создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с нужными ролями и привяжите его к кластеру {{ metastore-name }} при [создании кластера](../operations/metastore/cluster-create.md#create-cluster). После этого {{ metastore-name }} сможет взаимодействовать с пользовательскими ресурсами, так как авторизация происходит от имени сервисного аккаунта.

Набор ролей для сервисного аккаунта зависит от того, с каким сервисом вы планируете использовать {{ metastore-name }}. Например, чтобы настроить экспорт логов кластера в [{{ cloud-logging-full-name }}](../../logging/index.yaml), нужна роль `{{ roles-logging-writer }}`, а чтобы использовать дашборды [{{ monitoring-full-name }}](../../monitoring/index.yaml) — `{{ roles-monitoring-editor }}`.

При создании сервисного аккаунта для {{ metastore-name }} рекомендуется использовать роль `{{ roles.metastore.integrationProvider}}`, так как она уже включает в себя роли `{{ roles-logging-writer }}` и `{{ roles-monitoring-editor }}`. Подробнее о возможностях роли см. в [справочнике](../security/metastore-roles.md#managed-metastore-integrationProvider).

---
title: Как назначить политику доступа в {{ objstorage-short-name }} для сервисного подключения {{ vpc-full-name }}
description: Следуя данной инструкции, вы сможете назначить политику доступа в {{ objstorage-short-name }} для сервисного подключения.
---

# Назначить политику доступа в {{ objstorage-short-name }} для сервисного подключения


[Политики доступа (bucket policy)](../../storage/concepts/policy.md) устанавливают права на действия с [бакетами](../../storage/concepts/bucket.md), [объектами](../../storage/concepts/object.md) и группами объектов.

Минимально необходимая роль для применения или изменения политики доступа — `storage.configurer`. Описание роли в разделе [Управление доступом](../../storage/security/index.md#storage-configurer).

Чтобы назначить политику доступа в {{ objstorage-short-name }} для [сервисного подключения](../concepts/private-endpoint.md):

{% include [private-endpoint-policy-tabs](../../_includes/storage/private-endpoint-policy-tabs.md) %}

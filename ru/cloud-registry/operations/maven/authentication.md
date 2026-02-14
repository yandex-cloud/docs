---
title: Аутентифицироваться в {{ cloud-registry-full-name }}
description: Следуя данной инструкции, вы сможете аутентифицироваться в {{ cloud-registry-name }} для работы с Maven-артефактами.
---

# Аутентифицироваться в {{ cloud-registry-name }} для Maven

Перед началом работы с Maven-артефактами в {{ cloud-registry-name }} необходимо [настроить Maven](installation.md) и аутентифицироваться для соответствующего интерфейса:
* Для **Консоли управления** минимально необходимая [роль](../../../iam/concepts/access-control/roles.md) на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) — `viewer`.
* Для **Maven CLI** или **Gradle** минимально необходимая роль на [реестр](../../concepts/registry.md) `cloud-registry.artifacts.puller`.

Назначьте нужную роль пользователю {{ yandex-cloud }}. Ознакомьтесь со [способами аутентификации](#method) и выберите подходящий.

Подробнее про роли читайте в разделе [{#T}](../../security/index.md).

## Способы аутентификации {#method}

## Аутентифицироваться как пользователь {#user}

1. Настройте переменные окружения `REGISTRY_USERNAME` и `REGISTRY_PASSWORD`:

   {% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}

1. Настройте Maven для использования переменных окружения в файле `~/.m2/settings.xml`:

   В раздел `servers` файла с настройками Maven добавьте новый сервер:

   ```xml
   <server>
       <id>local</id>
       <username>${env.REGISTRY_USERNAME}</username>
       <password>${env.REGISTRY_PASSWORD}</password>
   </server>
   ```

   Где:
   * `id` — идентификатор сервера, должен совпадать с `id` репозитория в разделе `repositories`.
   * `${env.REGISTRY_USERNAME}` — переменная окружения, содержащая тип токена (`iam`, `oauth` или `api_key`).
   * `${env.REGISTRY_PASSWORD}` — переменная окружения, содержащая тело токена для аутентификации.
